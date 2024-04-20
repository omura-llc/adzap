import SwiftUI

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
                    .foregroundColor(enabled ? bannerColor : Color("BannerColorCherry"))
                    .rotationEffect(.degrees(enabled ? 0 : -10))
                    .lineLimit(1)
                    .frame(width: proxy.size.width)
            }
            .padding(.top)
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Banner(enabled: false, bannerColor: .bannerColorCherry)
                .preferredColorScheme(.light)
            Banner(enabled: true, bannerColor: .bannerColorClover)
                .preferredColorScheme(.light)
            Banner(enabled: false, bannerColor: .bannerColorCherry)
                .preferredColorScheme(.dark)
            Banner(enabled: true, bannerColor: .bannerColorClover)
                .preferredColorScheme(.dark)
        }
    }
}
