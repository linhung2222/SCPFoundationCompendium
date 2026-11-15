import SwiftUI

/// 分級怪物清單頁：包含水平滑動 Page 預覽輪播 + List 表格 + NavigationStack & NavigationLink
struct SCPCategoryListView: View {
    let scpClass: SCPClass
    let monsters: [SCPMonster]

    init(scpClass: SCPClass) {
        self.scpClass = scpClass
        self.monsters = SCPDatabase.monsters(for: scpClass)
    }

    var body: some View {
        NavigationStack {
            List {
                // Section 1: 水平滑動的分頁 (TabView + .tabViewStyle(.page))
                Section {
                    TabView {
                        ForEach(monsters) { monster in
                            NavigationLink(value: monster) {
                                SCPFeaturedPageCard(monster: monster)
                            }
                            .buttonStyle(.plain)
                            .padding(.horizontal, 6)
                            .padding(.bottom, 26)
                        }
                    }
                    #if os(iOS) || os(visionOS)
                        .tabViewStyle(.page(indexDisplayMode: .always))
                    #endif
                    .frame(height: 215)
                    .listRowInsets(
                        EdgeInsets(top: 10, leading: 0, bottom: 4, trailing: 0)
                    )
                    .listRowBackground(Color.clear)
                } header: {
                    HStack {
                        Image(systemName: "hand.draw.fill")
                        Text("左右滑動瀏覽 \(scpClass.rawValue) 級精選異常（Page 分頁）")
                    }
                    .font(.caption.bold())
                    .foregroundStyle(scpClass.badgeColor)
                }

                // Section 2: 盒子測試分級法則說明
                Section("分級定義（盒子測試法則）") {
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: scpClass.systemIcon)
                            .font(.title2)
                            .foregroundStyle(scpClass.badgeColor)
                            .frame(width: 32)
                        Text(scpClass.boxRuleSummary)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }

                // Section 3: 4 隻怪物的 List 表格列，點擊透過 NavigationLink 傳遞 monster 到下一頁
                Section("\(scpClass.chineseTitle) 收容清單（共 \(monsters.count) 項）")
                {
                    ForEach(monsters) { monster in
                        NavigationLink(value: monster) {
                            SCPMonsterRowView(monster: monster)
                        }
                    }
                }
            }
            .navigationTitle("\(scpClass.rawValue) 級收容檔案")
            .navigationDestination(for: SCPMonster.self) { monster in
                SCPDetailView(monster: monster)
            }
        }
    }
}

/// 水平滑動 Page 卡片視圖
struct SCPFeaturedPageCard: View {
    let monster: SCPMonster

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 18)
                .fill(
                    LinearGradient(
                        colors: [
                            monster.objectClass.badgeColor.opacity(0.85),
                            Color(red: 0.1, green: 0.11, blue: 0.15),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(monster.code)
                        .font(.system(.title3, design: .monospaced).bold())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(.black.opacity(0.45), in: Capsule())
                        .foregroundStyle(.white)

                    Text(monster.objectClass.rawValue.uppercased())
                        .font(.caption.monospaced().bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.white.opacity(0.2), in: Capsule())
                        .foregroundStyle(.white)

                    Spacer()

                    Image(systemName: monster.symbolName)
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.9))
                }

                Spacer(minLength: 4)

                Text(monster.name)
                    .font(.title2.bold())
                    .foregroundStyle(.white)

                Text(monster.tagline)
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.9))
                    .lineLimit(2)

                HStack {
                    Label(
                        monster.containmentSite,
                        systemImage: "mappin.and.ellipse"
                    )
                    Spacer()
                    Text("點擊查閱機密檔案 →")
                        .fontWeight(.semibold)
                }
                .font(.caption2)
                .foregroundStyle(.white.opacity(0.85))
                .padding(.top, 2)
            }
            .padding(16)
        }
        .shadow(
            color: monster.objectClass.badgeColor.opacity(0.25),
            radius: 6,
            y: 3
        )
    }
}

/// List 表格單列視圖
struct SCPMonsterRowView: View {
    let monster: SCPMonster

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(monster.objectClass.badgeColor.opacity(0.16))
                    .frame(width: 52, height: 52)

                Image(systemName: monster.symbolName)
                    .font(.title2)
                    .foregroundStyle(monster.objectClass.badgeColor)
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Text(monster.code)
                        .font(.system(.subheadline, design: .monospaced).bold())
                        .foregroundStyle(monster.objectClass.badgeColor)

                    Text(monster.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                }

                Text(monster.tagline)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                HStack(spacing: 8) {
                    Label(
                        monster.containmentSite,
                        systemImage: "building.columns.fill"
                    )
                    Text("·")
                    Text(monster.threatLevel)
                }
                .font(.caption2)
                .foregroundStyle(.tertiary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    SCPCategoryListView(scpClass: .euclid)
}
