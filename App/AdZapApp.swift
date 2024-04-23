import SwiftUI

@main
struct AdZapApp: App {
  @ObservedObject var contentBlockerState = ContentBlockerState(withIdentifier: "co.omura.adzap.ios")

  var body: some Scene {
    WindowGroup {
      HomeScreen(isEnabled: contentBlockerState.isEnabled)
    }
  }
}
