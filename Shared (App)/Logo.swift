import SwiftUI

struct Logo: View {
    var enabled: Bool
    var logoColor: Color

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Rectangle()
                    .foregroundColor(Color("BorderColor"))
                    .frame(idealWidth:400, maxWidth: 600, maxHeight: 150)
                    
                Rectangle()
                    .foregroundColor(enabled ? logoColor : Color("LogoColorGray"))
                    .padding(10)
                    .frame(idealWidth:400, maxWidth: 600, maxHeight: 150)
                
                Text(enabled ? "Ads Zapped!" : "disabled")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .shadow(radius: 3, y: 3)
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(enabled ? 0 : -10))
                    .lineLimit(1)
                    .frame(width: proxy.size.width)
            }
            .padding(.top)
        }
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
    }
}
