import SwiftUI

@main
struct MyApp: App {
    @State private var hasEnteredArchive = false

    var body: some Scene {
        WindowGroup {
            if hasEnteredArchive {
                ContentView()
            } else {
                SCPLaunchScreenView {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        hasEnteredArchive = true
                    }
                }
            }
        }
    }
}
