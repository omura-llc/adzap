import SwiftUI

struct HelpScreen: View {

  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        Text(LocalizedStringKey("help-text"))
          .padding()
        
        Link(destination: URL(string: "https://github.com/omura-llc/adzap/issues")!) {
          Text(LocalizedStringKey("github-issue"))
            .padding()
            .foregroundColor(.white)
            .background(Color.omura)
            .cornerRadius(5)
        }
        .frame(maxWidth: .infinity)
        .multilineTextAlignment(.center)
        
        Text(versionBuildText)
          .padding()
          .frame(maxWidth: .infinity)
          .multilineTextAlignment(.center)
      }
      .padding()
    }
  }
  
  private var versionBuildText: String {
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    return "version \(version) (\(build))"
  }
}

struct HelpScreen_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      HelpScreen().preferredColorScheme(.light)
      HelpScreen().preferredColorScheme(.dark)
    }
    .previewLayout(.device)
  }
}
