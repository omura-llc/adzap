import SwiftUI

struct Logo: View {
    var enabled: Bool
    var logoColor: Color

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                let stateColor = enabled ? logoColor : Color("LogoColorGray")

                Circle()
                    .stroke(stateColor, lineWidth: 0.1)

                Circle()
                    .foregroundColor(Color.white)

                Circle()
                    .foregroundColor(stateColor)
                    .padding(20)
                
                Text(enabled ? "Ads Zapped!" : "disabled")
                    .font(Font.custom("DIN Condensed Bold", size: min(proxy.size.height, proxy.size.width) * 0.2))
                    .shadow(radius: enabled ? 1 : 0, y: 1)
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(enabled ? 0 : -15))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(width: proxy.size.width - 20)
            }
            .padding(.top, 50)
        }
        .frame(minWidth: 200, minHeight: 200)
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Logo(enabled: false, logoColor: .logoColorGray)
                .preferredColorScheme(.light)
            Logo(enabled: true, logoColor: .logoColorClover)
                .preferredColorScheme(.light)
            Logo(enabled: false, logoColor: .logoColorGray)
                .preferredColorScheme(.dark)
            Logo(enabled: true, logoColor: .logoColorClover)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
