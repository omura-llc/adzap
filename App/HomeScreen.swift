import SwiftUI
import UIKit

func goodVibes() {
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    generator.prepare()
    generator.impactOccurred(intensity: 1.0)
}

struct HomeScreen: View {
    var isEnabled: Bool
    @State private var colorIndex = 0
    
    private let logoColors = [Color.logoColorClover, Color.logoColorCherry, Color.logoColorOmura, Color.logoColorTangerine, Color.logoColorGrape, Color.logoColorSunshine]
    
    private var version: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    private var build: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Logo(enabled: isEnabled, logoColor: logoColors[colorIndex])
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
                                        colorIndex = (colorIndex + 1) % logoColors.count
                                        goodVibes()
                                    }
                                }
                            }
                    )

                Spacer()
                
                Text(isEnabled ? "instructions-enabled" : "instructions-disabled")
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                if isEnabled {
                    Spacer()
                } else {
                    Text("Open Settings")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        }
                        .font(.system(size: 17))
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                }

                Text("\(version) (\(build))")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeScreen(isEnabled: false)
                .preferredColorScheme(.light)
            HomeScreen(isEnabled: true)
                .preferredColorScheme(.light)
            HomeScreen(isEnabled: false)
                .preferredColorScheme(.dark)
            HomeScreen(isEnabled: true)
                .preferredColorScheme(.dark)

            HomeScreen(isEnabled: true)
                .preferredColorScheme(.light)
                .previewDevice("iPhone 15")
        }
        .previewLayout(.device)
    }
}
