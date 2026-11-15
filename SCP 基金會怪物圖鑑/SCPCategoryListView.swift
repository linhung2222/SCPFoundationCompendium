import SwiftUI

/// 分級怪物清單頁（SCPCategoryListView）
/// 包含水平滑動 Page 預覽輪播、盒子測試分級法則說明，以及完整的異常收容項目表格清單
struct SCPCategoryListView: View {
    /// 此頁面所呈現的 SCP 項目等級（Safe / Euclid / Keter / Thaumiel）
    let scpClass: SCPClass
    /// 屬於該項目等級的所有 SCP 異常項目陣列
    let monsters: [SCPMonster]

    /// 初始化指定等級的清單頁面，並從資料庫篩選出對應等級的所有異常項目
    init(scpClass: SCPClass) {
        self.scpClass = scpClass
        self.monsters = SCPDatabase.monsters(for: scpClass)
    }

    var body: some View {
        NavigationStack {
            List {
                // MARK: - Section 1: 水平滑動的分頁輪播卡片 (TabView + .tabViewStyle(.page))
                Section {
                    TabView {
                        ForEach(monsters) { monster in
                            // 點擊輪播卡片亦可導覽至該怪物的詳細機密檔案頁
                            NavigationLink(value: monster) {
                                SCPFeaturedPageCard(monster: monster)
                            }
                            .buttonStyle(.plain)
                            .padding(.horizontal, 6)
                            .padding(.bottom, 26)
                        }
                    }
                    #if os(iOS) || os(visionOS)
                        // 設定為水平分頁滑動樣式，並始終顯示底部分頁圓點指示器
                        .tabViewStyle(.page(indexDisplayMode: .always))
                    #endif
                    .frame(height: 215)
                    // 移除 List 預設邊距並將背景設為透明，讓輪播卡片視覺更突出
                    .listRowInsets(
                        EdgeInsets(top: 10, leading: 0, bottom: 4, trailing: 0)
                    )
                    .listRowBackground(Color.clear)
                } header: {
                    // 輪播區塊頂部提示標題
                    HStack {
                        Image(systemName: "hand.draw.fill")
                        Text("左右滑動瀏覽 \(scpClass.rawValue) 級精選異常（Page 分頁）")
                    }
                    .font(.caption.bold())
                    .foregroundStyle(scpClass.badgeColor)
                }

                // MARK: - Section 2: 盒子測試分級法則說明
                Section("分級定義（盒子測試法則）") {
                    HStack(alignment: .top, spacing: 12) {
                        // 顯示該等級對應的代表性 SF Symbol 圖示與代表色
                        Image(systemName: scpClass.systemIcon)
                            .font(.title2)
                            .foregroundStyle(scpClass.badgeColor)
                            .frame(width: 32)
                        // 顯示「盒子測試（Locked Box Test）」的分級定義說明文字
                        Text(scpClass.boxRuleSummary)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }

                // MARK: - Section 3: 該等級所有怪物的 List 表格列
                // 點擊任一列會透過 NavigationLink 將選中的 SCPMonster 傳遞至詳細檔案頁面
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
            // 註冊型別導覽目的地：當點擊帶有 SCPMonster 值的 NavigationLink 時跳轉至 SCPDetailView
            .navigationDestination(for: SCPMonster.self) { monster in
                SCPDetailView(monster: monster)
            }
        }
    }
}

/// 水平滑動 Page 精選卡片視圖（SCPFeaturedPageCard）
/// 用於清單頁頂部的水平輪播，以漸層背景卡片展示單一異常的核心資訊
struct SCPFeaturedPageCard: View {
    /// 要展示的 SCP 異常項目資料
    let monster: SCPMonster

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // 卡片底圖：使用該異常等級代表色至深藍黑色的對角線漸層圓角矩形
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

            // 卡片前景文字與圖示排版
            VStack(alignment: .leading, spacing: 8) {
                // 頂部列：項目編號膠囊、收容等級標籤與右側代表圖示
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

                // 中央：異常項目中文名稱與簡短標語
                Text(monster.name)
                    .font(.title2.bold())
                    .foregroundStyle(.white)

                Text(monster.tagline)
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.9))
                    .lineLimit(2)

                // 底部列：收容站點位置與點擊查閱提示
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
        // 依據收容等級代表色加上柔和外陰影
        .shadow(
            color: monster.objectClass.badgeColor.opacity(0.25),
            radius: 6,
            y: 3
        )
    }
}

/// List 表格單列視圖（SCPMonsterRowView）
/// 在收容清單中以緊湊的圖文排版呈現單一異常的編號、名稱、簡介、站點與威脅等級
struct SCPMonsterRowView: View {
    /// 此列所顯示的 SCP 異常項目資料
    let monster: SCPMonster

    var body: some View {
        HStack(spacing: 14) {
            // 左側：帶有等級代表色淡色方框的 SF Symbol 圖示
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(monster.objectClass.badgeColor.opacity(0.16))
                    .frame(width: 52, height: 52)

                Image(systemName: monster.symbolName)
                    .font(.title2)
                    .foregroundStyle(monster.objectClass.badgeColor)
            }

            // 右側：編號、名稱、副標語與收容站點／威脅等級資訊
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

/// 預覽：Euclid 級收容清單頁
#Preview {
    SCPCategoryListView(scpClass: .euclid)
}
