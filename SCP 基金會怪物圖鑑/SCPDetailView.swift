import SwiftUI

/// SCP 怪物詳細機密檔案頁面（接收上一頁傳來的 SCPMonster 資料）
struct SCPDetailView: View {
    let monster: SCPMonster
    @State private var selectedSlideIndex = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 頂部機密識別卡
                headerCard

                // 水平滑動的分頁情報卡（使用 TabView + .tabViewStyle(.page)）
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Label(
                            "機密情報幻燈片（左右滑動 Page）",
                            systemImage: "rectangle.split.3x1.fill"
                        )
                        .font(.headline)
                        Spacer()
                        Text(
                            "\(selectedSlideIndex + 1) / \(monster.galleryHighlights.count)"
                        )
                        .font(.caption.monospaced())
                        .foregroundStyle(.secondary)
                    }

                    TabView(selection: $selectedSlideIndex) {
                        ForEach(
                            Array(monster.galleryHighlights.enumerated()),
                            id: \.offset
                        ) { index, highlight in
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: monster.symbolName)
                                        .font(.title2)
                                        .foregroundStyle(
                                            monster.objectClass.badgeColor
                                        )
                                    Text("\(monster.code) 觀測紀錄 #0\(index + 1)")
                                        .font(.subheadline.monospaced().bold())
                                        .foregroundStyle(
                                            monster.objectClass.badgeColor
                                        )
                                    Spacer()
                                    Text("LEVEL 4 CLASSIFIED")
                                        .font(.caption2.monospaced())
                                        .foregroundStyle(.secondary)
                                }

                                Text(highlight)
                                    .font(.body)
                                    .foregroundStyle(.primary)
                                    .fixedSize(
                                        horizontal: false,
                                        vertical: true
                                    )

                                Spacer(minLength: 0)
                            }
                            .padding(18)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(
                                        monster.objectClass.badgeColor.opacity(
                                            0.1
                                        )
                                    )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(
                                        monster.objectClass.badgeColor.opacity(
                                            0.35
                                        ),
                                        lineWidth: 1
                                    )
                            )
                            .padding(.horizontal, 4)
                            .padding(.bottom, 28)
                            .tag(index)
                        }
                    }
                    #if os(iOS) || os(visionOS)
                        .tabViewStyle(.page(indexDisplayMode: .always))
                    #endif
                    .frame(height: 175)
                }

                // 特殊收容措施
                VStack(alignment: .leading, spacing: 10) {
                    Label(
                        "特殊收容措施 (Special Containment Procedures)",
                        systemImage: "lock.shield.fill"
                    )
                    .font(.headline)
                    .foregroundStyle(monster.objectClass.badgeColor)

                    Text(monster.procedures)
                        .font(.body)
                        .lineSpacing(5)
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            .regularMaterial,
                            in: RoundedRectangle(cornerRadius: 14)
                        )
                }

                // 項目描述
                VStack(alignment: .leading, spacing: 10) {
                    Label(
                        "項目描述 (Description)",
                        systemImage: "doc.text.magnifyingglass"
                    )
                    .font(.headline)
                    .foregroundStyle(.primary)

                    Text(monster.description)
                        .font(.body)
                        .lineSpacing(6)
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            .regularMaterial,
                            in: RoundedRectangle(cornerRadius: 14)
                        )
                }

                // 透過 NavigationLink 前往內建 WebView 閱讀官方繁中 Wiki 頁面
                NavigationLink {
                    SCPWebPageView(
                        title: "\(monster.code) 官方檔案",
                        url: monster.wikiURL
                    )
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "globe.asia.australia.fill")
                            .font(.title3)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("在 App 內開啟 SCP 繁中 Wiki 原始網頁")
                                .font(.headline)
                            Text(monster.wikiURLString)
                                .font(.caption.monospaced())
                                .opacity(0.85)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.white)
                    .padding(16)
                    .background(
                        LinearGradient(
                            colors: [
                                monster.objectClass.badgeColor,
                                monster.objectClass.badgeColor.opacity(0.7),
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        in: RoundedRectangle(cornerRadius: 16)
                    )
                }
            }
            .padding()
        }
        .navigationTitle("\(monster.code) \(monster.name)")
        #if os(iOS) || os(visionOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .center, spacing: 16) {
                ZStack {
                    Circle()
                        .fill(monster.objectClass.badgeColor.opacity(0.2))
                        .frame(width: 72, height: 72)

                    Image(systemName: monster.symbolName)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(monster.objectClass.badgeColor)
                }

                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("項目編號：\(monster.code)")
                            .font(.system(.title3, design: .monospaced).bold())
                        Spacer()
                        Text(monster.objectClass.rawValue.uppercased())
                            .font(.caption.monospaced().bold())
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(
                                monster.objectClass.badgeColor,
                                in: Capsule()
                            )
                            .foregroundStyle(.white)
                    }

                    Text(monster.name)
                        .font(.title2.bold())

                    Text(monster.tagline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            Divider()

            HStack {
                Label(
                    "收容站點：\(monster.containmentSite)",
                    systemImage: "building.2.fill"
                )
                Spacer()
                Label(monster.threatLevel, systemImage: "bolt.shield.fill")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(18)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(
                    monster.objectClass.badgeColor.opacity(0.4),
                    lineWidth: 1.5
                )
        )
    }
}

#Preview {
    NavigationStack {
        SCPDetailView(monster: SCPDatabase.allMonsters[4])
    }
}
