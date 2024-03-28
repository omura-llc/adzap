import SwiftUI

struct HomeScreen: View {
    var isEnabled: Bool

    private var version: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
        
    private var build: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Logo(enabled: isEnabled)
                    .padding()
                    .padding(.vertical, 20.0)
                    .background(Color("UpperBackgroundColor"))

                VStack {
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
                        .font(.system(size: 17))
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    
                    Spacer()
                }
                .frame(width: proxy.size.width, height: proxy.size.height / 2.5)
                .background(Color("LowerBackgroundColor"))
            }
        }
        .ignoresSafeArea()

    }
}

@available(macOS 12.0, *)
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
                .previewDevice("iPad Pro (12.9-inch) (5th generation)")
        }
        .previewLayout(.device)
    }
}
