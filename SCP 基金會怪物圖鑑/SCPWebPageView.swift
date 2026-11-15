import SwiftUI
import WebKit

/// 內建網頁瀏覽器視圖（SCPWebPageView）
/// 使用 SwiftUI 原生 WebView 顯示對應 SCP 項目的繁體中文 Wiki 原始檔案頁面
struct SCPWebPageView: View {
    /// 導覽列顯示的頁面標題（例如「SCP-173 官方檔案」）
    let title: String
    /// 要載入的目標網頁 URL
    let url: URL

    var body: some View {
        // 直接載入指定 URL 的內建 WebView
        WebView(url: url)
            .navigationTitle(title)
            #if os(iOS) || os(visionOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
            // 右上角工具列提供外部 Safari 開啟按鈕，方便使用者在系統瀏覽器中閱讀
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Link(destination: url) {
                        Label("Safari 開啟", systemImage: "safari")
                    }
                }
            }
    }
}

/// 獨立的「基金會官網」Tab 分頁視圖（SCPWikiPortalTabView）
/// 提供頂部快速切換膠囊按鈕列與下方內建 WebView，方便一鍵瀏覽熱門 SCP 官方條目
struct SCPWikiPortalTabView: View {
    /// 目前選取並載入的網址字串，預設為 SCP 繁中分部首頁
    @State private var selectedURLString = "https://scp-zh-tr.wikidot.com"

    /// 預設提供的熱門官方條目快速連結清單
    private let quickLinks: [(title: String, url: String)] = [
        ("繁中首頁", "https://scp-zh-tr.wikidot.com"),
        ("SCP-173", "https://scp-zh-tr.wikidot.com/scp-173"),
        ("SCP-682", "https://scp-zh-tr.wikidot.com/scp-682"),
        ("SCP-999", "https://scp-zh-tr.wikidot.com/scp-999"),
        ("SCP-2000", "https://scp-zh-tr.wikidot.com/scp-2000"),
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // MARK: - 頂部水平捲動快速切換膠囊按鈕列
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(quickLinks, id: \.url) { item in
                            Button {
                                // 點擊後切換目前 WebView 載入的網址
                                selectedURLString = item.url
                            } label: {
                                Text(item.title)
                                    .font(.caption.bold())
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    // 若為目前選中的網址則顯示紅色膠囊，否則顯示淺灰底色
                                    .background(
                                        selectedURLString == item.url
                                            ? Color.red
                                            : Color.secondary.opacity(0.2),
                                        in: Capsule()
                                    )
                                    .foregroundStyle(
                                        selectedURLString == item.url
                                            ? .white : .primary
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .background(.bar)

                Divider()

                // MARK: - 顯示目前選中網址的 WebView 主體
                WebView(url: URL(string: selectedURLString))
            }
            .navigationTitle("SCP 基金會繁中官網 (WebView)")
            #if os(iOS) || os(visionOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
        }
    }
}

/// 預覽：基金會官網入口分頁
#Preview {
    SCPWikiPortalTabView()
}
