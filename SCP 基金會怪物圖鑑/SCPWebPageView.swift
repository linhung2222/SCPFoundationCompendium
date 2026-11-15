import SwiftUI
import WebKit

/// 使用 SwiftUI 原生 WebView 顯示 SCP 基金會繁體中文網（https://scp-zh-tr.wikidot.com）
struct SCPWebPageView: View {
    let title: String
    let url: URL

    var body: some View {
        WebView(url: url)
            .navigationTitle(title)
            #if os(iOS) || os(visionOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Link(destination: url) {
                        Label("Safari 開啟", systemImage: "safari")
                    }
                }
            }
    }
}

/// 獨立的「基金會官網」Tab 分頁，提供快速切換不同 SCP 官網頁面的 WebView
struct SCPWikiPortalTabView: View {
    @State private var selectedURLString = "https://scp-zh-tr.wikidot.com"

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
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(quickLinks, id: \.url) { item in
                            Button {
                                selectedURLString = item.url
                            } label: {
                                Text(item.title)
                                    .font(.caption.bold())
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
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

                WebView(url: URL(string: selectedURLString))
            }
            .navigationTitle("SCP 基金會繁中官網 (WebView)")
            #if os(iOS) || os(visionOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
        }
    }
}

#Preview {
    SCPWikiPortalTabView()
}
