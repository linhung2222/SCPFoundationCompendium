import SwiftUI

struct ContentView: View {
    @State private var showLaunchScreen = false

    var body: some View {
        TabView {
            Tab("Safe", systemImage: SCPClass.safe.systemIcon) {
                SCPCategoryListView(scpClass: .safe)
            }

            Tab("Euclid", systemImage: SCPClass.euclid.systemIcon) {
                SCPCategoryListView(scpClass: .euclid)
            }

            Tab("Keter", systemImage: SCPClass.keter.systemIcon) {
                SCPCategoryListView(scpClass: .keter)
            }

            Tab("Thaumiel", systemImage: SCPClass.thaumiel.systemIcon) {
                SCPCategoryListView(scpClass: .thaumiel)
            }

            Tab("基金會官網", systemImage: "globe") {
                SCPWikiPortalTabView()
            }
        }
        .tint(.red)
        .sheet(isPresented: $showLaunchScreen) {
            SCPLaunchScreenView {
                showLaunchScreen = false
            }
        }
    }
}

#Preview("Main App") {
    ContentView()
}

#Preview("Launch Screen") {
    SCPLaunchScreenView(onEnterArchive: {})
}
