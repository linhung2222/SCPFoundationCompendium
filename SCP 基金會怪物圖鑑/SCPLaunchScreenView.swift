import SwiftUI

/// 開頭畫面（Launch / Terminal Access Screen）
struct SCPLaunchScreenView: View {
    var onEnterArchive: () -> Void
    @State private var isScanning = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.black, Color(red: 0.08, green: 0.08, blue: 0.11),
                    Color(red: 0.14, green: 0.04, blue: 0.05),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                // 基金會徽章圖示
                ZStack {
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

                    Circle()
                        .fill(Color.red.opacity(0.15))
                        .frame(width: 116, height: 116)

                    Image(
                        systemName:
                            "shield.lefthalf.filled.trianglebadge.exclamationmark"
                    )
                    .font(.system(size: 56, weight: .bold))
                    .foregroundStyle(.red, .white)
                }

                VStack(spacing: 8) {
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

                    Text("控制  ·  收容  ·  保護")
                        .font(.headline)
                        .foregroundStyle(.red)
                        .tracking(6)

                    Text("SECURE · CONTAIN · PROTECT")
                        .font(.caption.monospaced())
                        .foregroundStyle(.secondary)
                }

                // 警告橫幅
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
                    .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .frame(maxWidth: 480)
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
        .onAppear {
            isScanning = true
        }
    }
}

#Preview {
    SCPLaunchScreenView(onEnterArchive: {})
}
