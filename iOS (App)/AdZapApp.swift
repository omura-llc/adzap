import SwiftUI

@main
struct AdZapApp: App {
    @ObservedObject var contentBlockerState = ContentBlockerState(withIdentifier: "co.omura.adzap.ios.contentblocker")

    var body: some Scene {
        WindowGroup {
            HomeScreen(isEnabled: contentBlockerState.isEnabled)
        }
    }
}
