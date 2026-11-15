import SwiftUI

/// 應用程式入口點（App Entry Point）
/// 負責管理開頭終端機驗證畫面（Launch Screen）與主資料庫畫面（ContentView）之間的切換狀態
@main
struct MyApp: App {
    /// 紀錄使用者是否已點擊按鈕通過驗證、進入機密檔案庫
    @State private var hasEnteredArchive = false

    var body: some Scene {
        WindowGroup {
            // 若已通過生物識別驗證，顯示主頁籤畫面；否則顯示基金會開頭警告畫面
            if hasEnteredArchive {
                ContentView()
            } else {
                SCPLaunchScreenView {
                    // 點擊進入按鈕時，使用淡入淡出動畫平滑切換至主畫面
                    withAnimation(.easeInOut(duration: 0.35)) {
                        hasEnteredArchive = true
                    }
                }
            }
        }
    }
}
