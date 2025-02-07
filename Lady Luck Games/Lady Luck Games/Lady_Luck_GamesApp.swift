import SwiftUI

@main
struct Lady_Luck_GamesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            FirstView()
        }
    }
}
