import SwiftUI

/// 應用程式主畫面（Main TabView）
/// 使用 TabView 提供四大收容等級（Safe、Euclid、Keter、Thaumiel）與基金會官網共五個主要分頁
struct ContentView: View {
    /// 控制是否以彈出視窗（Sheet）重新顯示開頭畫面
    @State private var showLaunchScreen = false

    var body: some View {
        // 主分頁導覽列，包含四個異常等級清單頁與一個內建官網瀏覽頁
        TabView {
            // Safe（安全級）異常收容清單分頁
            Tab("Safe", systemImage: SCPClass.safe.systemIcon) {
                SCPCategoryListView(scpClass: .safe)
            }

            // Euclid（歐幾里得級）異常收容清單分頁
            Tab("Euclid", systemImage: SCPClass.euclid.systemIcon) {
                SCPCategoryListView(scpClass: .euclid)
            }

            // Keter（凱特爾級）異常收容清單分頁
            Tab("Keter", systemImage: SCPClass.keter.systemIcon) {
                SCPCategoryListView(scpClass: .keter)
            }

            // Thaumiel（陶米爾級）最高機密反制異常清單分頁
            Tab("Thaumiel", systemImage: SCPClass.thaumiel.systemIcon) {
                SCPCategoryListView(scpClass: .thaumiel)
            }

            // SCP 基金會繁體中文官方網站（WebView）分頁
            Tab("基金會官網", systemImage: "globe") {
                SCPWikiPortalTabView()
            }
        }
        // 設定全域強調色為符合 SCP 警戒風格的紅色
        .tint(.red)
        // 支援以 Sheet 形式彈出開頭終端機畫面
        .sheet(isPresented: $showLaunchScreen) {
            SCPLaunchScreenView {
                showLaunchScreen = false
            }
        }
    }
}

/// 預覽：主應用程式分頁畫面
#Preview("Main App") {
    ContentView()
}

/// 預覽：開頭終端機登入畫面
#Preview("Launch Screen") {
    SCPLaunchScreenView(onEnterArchive: {})
}
