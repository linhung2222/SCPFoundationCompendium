import SwiftUI

/// 開頭畫面（Launch / Terminal Access Screen）
/// 模擬 SCP 基金會最高機密終端機的生物識別登入與安全警告介面
struct SCPLaunchScreenView: View {
    /// 當使用者點擊「驗證生物識別並進入資料庫」按鈕時觸發的回呼閉包
    var onEnterArchive: () -> Void
    /// 控制基金會徽章外圈掃描光環縮放動畫的狀態變數
    @State private var isScanning = false

    var body: some View {
        ZStack {
            // 背景：黑與暗紅交織的斜向漸層，營造機密終端機的壓迫氛圍
            LinearGradient(
                colors: [
                    Color.black, Color(red: 0.08, green: 0.08, blue: 0.11),
                    Color(red: 0.14, green: 0.04, blue: 0.05),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea() // 忽略安全區域使背景填滿整個螢幕

            VStack(spacing: 24) {
                Spacer()

                // MARK: - 基金會徽章圖示與呼吸燈掃描動畫
                ZStack {
                    // 外層動態縮放的紅色圓環，持續無限循環播放呼吸掃描效果
                    Circle()
                        .stroke(Color.red.opacity(0.4), lineWidth: 3)
                        .frame(width: 140, height: 140)
                        .scaleEffect(isScanning ? 1.12 : 0.95)
                        .animation(
                            .easeInOut(duration: 1.8).repeatForever(
                                autoreverses: true
                            ),
                            value: isScanning
                        )

                    // 內層半透明紅色圓形襯底
                    Circle()
                        .fill(Color.red.opacity(0.15))
                        .frame(width: 116, height: 116)

                    // 中央防護盾牌與警告標誌 SF Symbol 圖示
                    Image(
                        systemName:
                            "shield.lefthalf.filled.trianglebadge.exclamationmark"
                    )
                    .font(.system(size: 56, weight: .bold))
                    .foregroundStyle(.red, .white)
                }

                // MARK: - 基金會標題與核心宗旨標語
                VStack(spacing: 8) {
                    // 英文主標題（等寬粗體字型 + 字距加寬）
                    Text("SCP FOUNDATION")
                        .font(
                            .system(
                                size: 30,
                                weight: .black,
                                design: .monospaced
                            )
                        )
                        .foregroundStyle(.white)
                        .tracking(3)

                    // 繁體中文核心口號
                    Text("控制  ·  收容  ·  保護")
                        .font(.headline)
                        .foregroundStyle(.red)
                        .tracking(6)

                    // 英文核心口號副標題
                    Text("SECURE · CONTAIN · PROTECT")
                        .font(.caption.monospaced())
                        .foregroundStyle(.secondary)
                }

                // MARK: - 機密授權等級與記憶刪除警告橫幅
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "exclamationmark.octagon.fill")
                            .foregroundStyle(.yellow)
                        Text("最高機密檔案庫 — 授權等級 4 / O5")
                            .font(.subheadline.bold())
                            .foregroundStyle(.yellow)
                    }
                    Text(
                        "本系統收錄 Safe、Euclid、Keter、Thaumiel 四大項目等級各 10 隻（共 40 個）異常實體之機密收容檔案。未經授權存取將派遣機動特遣隊（MTF）進行記憶刪除。"
                    )
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.8))
                    // 允許文字垂直完整展開，避免多行文字被截斷
                    .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .frame(maxWidth: 480)
                // 使用毛玻璃材質背景與黃色細邊框突顯警告區塊
                .background(
                    .ultraThinMaterial,
                    in: RoundedRectangle(cornerRadius: 16)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.yellow.opacity(0.35), lineWidth: 1)
                )
                .padding(.horizontal, 24)

                Spacer()

                // MARK: - 進入資料庫按鈕
                Button(action: onEnterArchive) {
                    HStack(spacing: 12) {
                        Image(systemName: "lock.open.display")
                            .font(.headline)
                        Text("驗證生物識別並進入資料庫")
                            .font(.headline.bold())
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: 360)
                    .padding(.vertical, 16)
                    // 膠囊狀紅色漸層背景與發光陰影
                    .background(
                        LinearGradient(
                            colors: [
                                .red, Color(red: 0.65, green: 0.1, blue: 0.15),
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        in: Capsule()
                    )
                    .shadow(color: .red.opacity(0.45), radius: 12, y: 4)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
            }
        }
        // 畫面出現時啟動外圈圓環的呼吸掃描動畫
        .onAppear {
            isScanning = true
        }
    }
}

/// 預覽：開頭畫面
#Preview {
    SCPLaunchScreenView(onEnterArchive: {})
}
