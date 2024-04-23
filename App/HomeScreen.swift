import SwiftUI

struct HomeScreen: View {
  var isEnabled: Bool
  @State private var colorIndex = 0
  @State private var showHelp = false
  
  private let bannerColors = [
    Color.clover,
    Color.omura,
    Color.grape,
    Color.tangerine
  ]
  
  private var versionBuildText: String {
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "N/A"
    let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "N/A"
    return "\n\(version) (\(build))"
  }
  
  var body: some View {
    NavigationView {
      GeometryReader { proxy in
        VStack {
          Banner(enabled: isEnabled, bannerColor: bannerColors[colorIndex])
            .padding(.top, 100)
            .padding(.horizontal, 20)
            .frame(height: proxy.size.height / 1.5)
            .gesture(
              DragGesture()
                .onEnded { gesture in
                  if isEnabled {
                    let horizontalMovement = gesture.translation.width
                    let swipeDistance: CGFloat = 200
                    if abs(horizontalMovement) > swipeDistance {
                      colorIndex = (colorIndex + 1) % bannerColors.count
                    }
                  }
                }
            )
          
          Spacer()
          
          if isEnabled {
            Button(action: { showHelp = true }) {
              Image(systemName: "questionmark.circle.fill")
                .font(.largeTitle)
                .foregroundColor(bannerColors[colorIndex])
            }
          } else {
            Text(LocalizedStringKey("instructions"))
              .multilineTextAlignment(.center)
              .padding(.top)
            Text(LocalizedStringKey("open-settings"))
              .foregroundColor(.blue)
              .onTapGesture {
                if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                  UIApplication.shared.open(url)
                }
              }
              .multilineTextAlignment(.center)
              .padding(.vertical)
          }
          
          Spacer()
        }
        .overlay(
          NavigationLink(destination: HelpScreen(), isActive: $showHelp) { EmptyView() }
        )
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct Banner: View {
  var enabled: Bool
  var bannerColor: Color
  
  var body: some View {
    GeometryReader { proxy in
      ZStack {
        Text(LocalizedStringKey(enabled ? "banner-enabled" : "banner-disabled"))
          .padding(10)
          .frame(idealWidth:400, maxWidth: 600, maxHeight: 200)
          .font(.system(size: 50, weight: .bold, design: .rounded))
          .shadow(radius: 3, y: 1)
          .foregroundColor(enabled ? bannerColor : Color("Cherry"))
          .rotationEffect(.degrees(enabled ? 0 : -10))
          .lineLimit(1)
          .frame(width: proxy.size.width)
      }
      .padding(.top)
    }
  }
}

struct HomeScreen_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      HomeScreen(isEnabled: false).preferredColorScheme(.light)
      HomeScreen(isEnabled: true).preferredColorScheme(.light)
      HomeScreen(isEnabled: false).preferredColorScheme(.dark)
      HomeScreen(isEnabled: true).preferredColorScheme(.dark)
    }
    .previewLayout(.device)
  }
}
