import SwiftUI

/// SCP 項目等級（Object Class）
enum SCPClass: String, CaseIterable, Identifiable {
    case safe = "Safe"
    case euclid = "Euclid"
    case keter = "Keter"
    case thaumiel = "Thaumiel"

    var id: String { rawValue }

    var chineseTitle: String {
        switch self {
        case .safe: return "Safe（安全）"
        case .euclid: return "Euclid（歐幾里得）"
        case .keter: return "Keter（凱特爾）"
        case .thaumiel: return "Thaumiel（陶米爾）"
        }
    }

    var badgeColor: Color {
        switch self {
        case .safe: return .green
        case .euclid: return .orange
        case .keter: return .red
        case .thaumiel: return .purple
        }
    }

    var systemIcon: String {
        switch self {
        case .safe: return "checkmark.shield.fill"
        case .euclid: return "exclamationmark.triangle.fill"
        case .keter: return "flame.fill"
        case .thaumiel: return "eye.trianglebadge.exclamationmark.fill"
        }
    }

    var boxRuleSummary: String {
        switch self {
        case .safe:
            return "如果你把它鎖在盒子裡，放在那裡不管，什麼壞事都不會發生，那它大概率就是 Safe。"
        case .euclid:
            return "如果你把它鎖在盒子裡，放在那裡不管，你不確定將會發生什麼事，那它大概率就是 Euclid。"
        case .keter:
            return "如果你把它鎖在盒子裡，放在那裡不管，它很容易就會逃出來並造成毀滅，那它大概率就是 Keter。"
        case .thaumiel:
            return "如果它就是那個盒子本身，被基金會用來收容或對抗其他更危險的異常，那它大概率就是 Thaumiel。"
        }
    }
}

/// SCP 怪物／異常項目資料結構（遵從 Identifiable）
struct SCPMonster: Identifiable, Hashable {
    let id = UUID()
    let code: String  // 例如 "SCP-173"
    let name: String  // 例如 "雕像 - 最初之作"
    let objectClass: SCPClass  // Safe, Euclid, Keter, Thaumiel
    let containmentSite: String  // 收容站點
    let threatLevel: String  // 威脅等級標示
    let symbolName: String  // SF Symbol 圖示
    let tagline: String  // 簡短標語
    let procedures: String  // 特殊收容措施
    let description: String  // 項目描述
    let galleryHighlights: [String]  // 用於水平分頁滑動展示的多張檔案情報卡
    let wikiURLString: String  // 對應的繁體中文 Wiki 網址

    var wikiURL: URL {
        URL(string: wikiURLString) ?? URL(
            string: "https://scp-zh-tr.wikidot.com"
        )!
    }
}

/// SCP 基金會完整資料庫（Safe、Euclid、Keter、Thaumiel 各 10 隻，共 40 隻）
enum SCPDatabase {
    static let allMonsters: [SCPMonster] = [
        // MARK: - Safe (10 隻)
        SCPMonster(
            code: "SCP-999",
            name: "癢癢怪",
            objectClass: .safe,
            containmentSite: "Site-06-3",
            threatLevel: "Green ● 低度威脅",
            symbolName: "face.smiling.inverse",
            tagline: "全基金會最溫柔治癒的橘色半透明黏液生物",
            procedures:
                "SCP-999 允許在設施內自由活動，但夜間或警戒期間必須返回其圍欄中。受試者與工作人員可隨時申請與 SCP-999 進行互動以緩解心理壓力。",
            description:
                "SCP-999 是一團巨大、無定形、半透明的橘色膠狀物質，重約 54 公斤，黏稠度類似花生醬。它的性情極為活潑親人，類似頑皮的小狗。只要接觸到 SCP-999 的表面，生物就會立刻產生強烈的愉悅感與幸福感，甚至能治癒重度憂鬱症與創傷後壓力症候群（PTSD）。它最喜歡吃 M&M's 巧克力與氣泡飲料。",
            galleryHighlights: [
                "檔案卡 01｜外型特徵：半透明橘色果凍狀生命體，散發宜人的花生醬、乾淨衣物或培根香氣。",
                "檔案卡 02｜異常效應：接觸即產生欣快感，曾成功安撫極度狂暴的 SCP-682（不滅孽蜥）。",
                "檔案卡 03｜飲食偏好：完全以甜食為食，特別喜愛巧克力與糖果，拒絕食用任何肉類。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-999"
        ),
        SCPMonster(
            code: "SCP-131",
            name: "「眼豆」小隊",
            objectClass: .safe,
            containmentSite: "Site-19",
            threatLevel: "Green ● 低度威脅",
            symbolName: "eye.circle.fill",
            tagline: "會自動緊盯危險異常、保護人員的淚滴形單眼機械生物",
            procedures:
                "SCP-131-A 與 SCP-131-B 無須特別收容，可在 Site-19 內自由移動，只要牠們不試圖進入限制區域或離開設施即可。",
            description:
                "SCP-131 是兩隻淚滴形狀、高約 30 公分的生物（分別為焦橙色的 SCP-131-A 與芥末黃的 SCP-131-B）。牠們身體中央各有一顆大藍眼睛，底部配有類似輪子的構造，移動速度極快。牠們擁有家貓般的智力與強烈好奇心，面對危險時會發出警告並死死盯住目標，因此曾被指派去監視需要視線接觸的 SCP-173。",
            galleryHighlights: [
                "檔案卡 01｜雙子個體：焦橙色 SCP-131-A 與芥末黃 SCP-131-B，形影不離地巡視基地。",
                "檔案卡 02｜警戒本能：當感知到敵意或收容失效風險時，會高速圍繞人員發出高頻鳴叫示警。",
                "檔案卡 03｜特殊功績：在一次 SCP-173 清潔任務中主動替 D 級人員維持視線，避免傷亡。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-131"
        ),
        SCPMonster(
            code: "SCP-500",
            name: "萬能藥",
            objectClass: .safe,
            containmentSite: "Site-12",
            threatLevel: "Green ● 珍貴資源",
            symbolName: "pills.fill",
            tagline: "兩小時內徹底根治任何已知疾病的紅白膠囊",
            procedures: "SCP-500 必須存放在陰涼乾燥處。僅有獲 4 級或 O5 議會核准的人員方可取用，避免耗盡剩餘藥丸。",
            description:
                "SCP-500 是一個塑膠小藥罐，最初裝有 60 顆紅色藥丸（目前存量少於 47 顆）。口服一顆藥丸後，能在兩小時內徹底治癒服用者身上的所有疾病與異常感染，具體治癒時間取決於病情嚴重程度。儘管基金會多次嘗試人工合成其有效成分，但迄今所有複製出的藥丸效果均遠不如原版。",
            galleryHighlights: [
                "檔案卡 01｜醫療奇蹟：能根除癌症、愛滋病乃至多數致命模因與生物異常感染。",
                "檔案卡 02｜不可複製性：即使透過 SCP-914（發條裝置）加工或化學分析，仍無法完美量產。",
                "檔案卡 03｜戰略儲備：每一顆藥丸的使用皆須經過嚴格審批，視為基金會最終醫療底牌。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-500"
        ),
        SCPMonster(
            code: "SCP-914",
            name: "發條裝置",
            objectClass: .safe,
            containmentSite: "Site-19",
            threatLevel: "Yellow ● 實驗控管",
            symbolName: "gearshape.2.fill",
            tagline: "可將萬物「精煉」或「拆解」的巨大機械發條工廠",
            procedures: "僅允許提交正式實驗申請並獲批的研究人員操作 SCP-914。嚴禁將任何有機生命體或爆裂物放入輸入隔間。",
            description:
                "SCP-914 是一台重達數噸、佔地約 18 平方公尺的複雜大型發條裝置，由齒輪、皮帶、滑輪與彈簧組成。它分為「輸入室」、「輸出室」與中央控制面板。面板上有一個旋鈕，指向五個檔位：Rough（粗糙）、Coarse（半粗）、1:1（等價）、Fine（精加工）、Very Fine（超精加工）。放入物品並轉動發條後，物品會被超自然地改造或升級。",
            galleryHighlights: [
                "檔案卡 01｜五段旋鈕：從徹底粉碎拆解的 Rough 到賦予異常性質的 Very Fine。",
                "檔案卡 02｜無電力結構：完全依靠純機械發條運作，卻能進行原子與概念層級的重組。",
                "檔案卡 03｜實驗守則：禁止放入生物，曾有測試人員經 Very Fine 加工後化為高危異常體。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-914"
        ),
        SCPMonster(
            code: "SCP-005",
            name: "萬能鑰匙",
            objectClass: .safe,
            containmentSite: "Site-19",
            threatLevel: "Green ● 保密控管",
            symbolName: "key.fill",
            tagline: "外觀看似華麗復古、實則能解開世上任何機械鎖與電子密碼鎖的異常鑰匙",
            procedures:
                "SCP-005 本身不具生理危害，但基於其無視一切門禁的特殊性質，須鎖在多重認證保險箱中，取用需至少一名 4 級人員批准。",
            description:
                "SCP-005 外觀是一把帶有華麗裝飾的 1920 年代風格金屬鑰匙。它似乎具有某種形式的感知能力，能夠以極高機率打開任何形式的鎖具（無論是傳統彈子鎖、轉盤保險箱，甚至是現代數位密碼鎖與生物辨識門禁）。然而，若把鎖偽裝成其他物品，SCP-005 就有可能受騙而無法開啟。",
            galleryHighlights: [
                "檔案卡 01｜萬鎖皆開：無論機械鎖還是電子刷卡門，只要接觸鎖孔或感應區即可解鎖。",
                "檔案卡 02｜微弱意識：鑰匙似乎能「理解」鎖的構造，因此若將鎖頭巧妙偽裝就能降低其成功率。",
                "檔案卡 03｜收容突破隱憂：一旦落入敵對組織手中，基金會所有低階物理門禁將形同虛設。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-005"
        ),
        SCPMonster(
            code: "SCP-085",
            name: "手繪的「茜茜」",
            objectClass: .safe,
            containmentSite: "Site-19",
            threatLevel: "Green ● 無害友善",
            symbolName: "paintbrush.pointed.fill",
            tagline: "活在二度元畫紙上的手繪黑白少女，能穿梭於不同紙張之間並用手語和筆談交流",
            procedures:
                "SCP-085 收容於一張置於安保文件夾內的 A3 白色繪圖紙上。研究人員可提供額外的素描紙與工程圖供她移動與生活。",
            description:
                "SCP-085 是由 SCP-067（異常鋼筆）與 SCP-914（發條裝置）交互實驗後誕生的塗鴉人物，名為「Cassandra（茜茜）」。她是一名高約 15 公分的黑白線條手繪年輕女性，擁有完整的自我意識與情感。她可以在互相接觸的紙張之間自由穿梭，並能把同一平面上的手繪物品（如畫出來的衣服、汽車、椅子）當作真實物體來穿戴與使用。",
            galleryHighlights: [
                "檔案卡 01｜次元跨界：只要兩張紙邊緣緊貼，茜茜就能從一張紙走進另一張紙的世界。",
                "檔案卡 02｜畫中造物：只要在紙上畫出福特野馬跑車的分解圖，她就能親手在紙面把車組裝起來開動。",
                "檔案卡 03｜無聲交流：雖然無法發出聲音，但她學會了手語並能透過在紙上寫字與研究員聊天。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-085"
        ),
        SCPMonster(
            code: "SCP-113",
            name: "性別轉換石",
            objectClass: .safe,
            containmentSite: "Site-23",
            threatLevel: "Yellow ● 劇痛生理改造",
            symbolName: "sparkles.rectangle.stack.fill",
            tagline: "觸碰後會在 80 秒內伴隨劇烈疼痛、將生物染色體與生理性別徹底逆轉的紅碧玉",
            procedures: "SCP-113 應保存於標準實驗室儲物櫃內。處理時必須配戴厚重防化手套，嚴禁直接以裸露皮膚觸碰。",
            description:
                "SCP-113 外觀是一塊光滑的紅色碧玉石。當任何具備性染色體的生物直接以皮膚接觸 SCP-113 時，石頭會立刻吸附在皮膚上並啟動為期約 80 秒的四階段轉換過程：基因與細胞重組、全身組織劇烈灼痛、性徵與染色體徹底對調。若在短時間內重複觸碰第二次，將有 25% 的機率導致全身器官結構崩潰死亡。",
            galleryHighlights: [
                "檔案卡 01｜染色體改寫：從基因層面將 XY 與 XX 染色體徹底重組，連帶改變全身荷爾蒙與骨骼。",
                "檔案卡 02｜極限劇痛：轉換最後 20 秒會引發強烈的神經衝擊與組織重塑痛楚，體質虛弱者可能休克。",
                "檔案卡 03｜重複接觸風險：冷卻期內再次觸碰會引發基因崩壞，造成嚴重的肌肉與內臟損傷。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-113"
        ),
        SCPMonster(
            code: "SCP-294",
            name: "咖啡機",
            objectClass: .safe,
            containmentSite: "Site-19 二樓員工休息室",
            threatLevel: "Yellow ● 概念提取裝置",
            symbolName: "cup.and.heat.waves.fill",
            tagline: "只要投幣並在鍵盤輸入名稱，連「黃金溶液」、「反物質」甚至「一杯音樂」都能裝出來的販賣機",
            procedures:
                "SCP-294 放置於員工休息室，由兩名武裝警衛全天候看守，任何使用皆需登記並獲得 2 級以上授權，嚴禁輸入毀滅性物質。",
            description:
                "SCP-294 外觀是一台配有 QWERTY 英文鍵盤的標準自動咖啡販賣機。投入 50 美分硬幣後，使用者可以在鍵盤上輸入任何液體（甚至抽象概念）的名稱，機器就會吐出一個裝有該物質的紙杯。它曾成功產出液態氮、熔融黃金、人體血液，甚至「一杯他人生平最美好的回憶」與「一杯音樂」。",
            galleryHighlights: [
                "檔案卡 01｜無所不裝：只要在宇宙中存在且能呈現液態，它就能透過空間轉移精準注入紙杯。",
                "檔案卡 02｜概念液化：輸入「一杯驚喜」或「一杯知識」時，飲用者真的會獲得短暫的超常體驗。",
                "檔案卡 03｜慘痛教訓：曾有研究員輸入「一杯 SCP-682 分泌物」或「反物質水」，險些釀成巨災。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-294"
        ),
        SCPMonster(
            code: "SCP-458",
            name: "無限披薩盒",
            objectClass: .safe,
            containmentSite: "Site-17 員工餐廳",
            threatLevel: "Green ● 員工福利異常",
            symbolName: "takeoutbag.and.cup.and.straw.fill",
            tagline: "打開盒蓋瞬間就會自動感應你內心深處最想吃的口味，並變出熱騰騰現烤披薩的紙盒",
            procedures: "SCP-458 公開放置於 Site-17 的員工餐廳供全體人員自由使用，作為提升基地士氣的特殊福利。",
            description:
                "SCP-458 是一個「小凱薩（Little Caesars）」連鎖披薩店的普通大號瓦楞紙披薩盒。這個紙盒無法被物理手段摧毀。當任何人類雙手接觸並打開盒蓋時，盒內會瞬間複製出該名人員潛意識裡最渴望的披薩口味（包含餅皮厚薄、醬料與配料比例）。唯一的限制是它只能變出人類可食用的披薩食材。",
            galleryHighlights: [
                "檔案卡 01｜讀心美食：連本人自己沒意識到的隱藏飲食偏好，披薩盒都能精準還原。",
                "檔案卡 02｜絕對堅固：紙盒本身免疫火焰、切割與碾壓，永遠保持微溫與乾燥。",
                "檔案卡 03｜異常跨界測試：給不同 SCP 觸碰時，反映出了牠們截然不同的性格與飲食習性。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-458"
        ),
        SCPMonster(
            code: "SCP-529",
            name: "半貓 Josie",
            objectClass: .safe,
            containmentSite: "Site-19",
            threatLevel: "Green ● 溫馴異常寵物",
            symbolName: "cat.fill",
            tagline: "後半身彷彿被無形空間切開消失、卻依然健康活潑愛吃起司的虎斑小母貓",
            procedures: "SCP-529 允許在低安全級別辦公區自由漫步。研究人員可餵食牛奶與起司，特別是在牠撒嬌乞食時。",
            description:
                "SCP-529 是一隻名叫「Josie」的灰白虎斑小母貓。牠的身體在胸腔肋骨後方突然截斷消失，切面呈現純黑色且沒有任何傷口或器官外露。儘管完全沒有後半身與後腿，牠走動時前半身卻表現得像後腿依然存在一樣自然，進食後食物會正常消化而不會從切面掉出來。牠非常親人，最喜歡吃切達起司。",
            galleryHighlights: [
                "檔案卡 01｜空間斷面：身體後半截並非被砍斷，而是像隱形在另一個維度中，觸摸切面感覺平滑。",
                "檔案卡 02｜幽靈後肢：走路、跳躍與抓癢時，動作完全符合擁有四條腿的正常貓咪力學。",
                "檔案卡 03｜起司狂熱：若不給牠吃起司，牠會一直用前爪抱住工作人員的腳踝喵喵叫。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-529"
        ),

        // MARK: - Euclid (10 隻)
        SCPMonster(
            code: "SCP-173",
            name: "雕像 - 最初之作",
            objectClass: .euclid,
            containmentSite: "Site-19",
            threatLevel: "Orange ● 致命物理威脅",
            symbolName: "figure.stand",
            tagline: "絕對不能眨眼！一旦移開視線就會瞬間折斷頸部的混凝土雕像",
            procedures:
                "SCP-173 應隨時鎖在密封收容間內。當必須進入收容間時，人數不得少於 3 人，且進入後必須立刻鎖上大門。在全體人員撤出並重新上鎖前，至少要有兩人全程保持與 SCP-173 的直接視線接觸，眨眼時必須互相通報。",
            description:
                "SCP-173 是由混凝土和鋼筋構成、表面帶有 Krylon 牌噴漆痕跡的人形雕像。它具有生命且極度敵對，但只要處於任何生物的直接視線內就完全無法移動。一旦視線中斷（包括眨眼的一瞬間），它會以極高速度瞬移至目標身後，透過折斷頸部或勒斃的方式殺死對方。收容室內會無端產生紅褐色的血液與排泄物混合物，需每兩週清潔一次。",
            galleryHighlights: [
                "檔案卡 01｜視線法則：只要被看著就是普通水泥雕像，眨眼瞬間即化為索命死神。",
                "檔案卡 02｜傳奇起源：2004 年誕生於網路討論區，是整個 SCP 基金會宇宙的第一篇作品。",
                "檔案卡 03｜收容日常：每次派 D 級人員清掃收容間排泄物時，都必須嚴格執行輪流眨眼制度。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-173"
        ),
        SCPMonster(
            code: "SCP-096",
            name: "「羞澀的人」",
            objectClass: .euclid,
            containmentSite: "Area-██",
            threatLevel: "Red ● 不可阻擋追殺",
            symbolName: "eye.slash.fill",
            tagline: "只要看過祂的臉——哪怕只是照片裡的四個像素——祂就會追殺你到天涯海角",
            procedures:
                "SCP-096 必須永遠關押在 5x5x5 公尺的氣密鋼製立方體中。收容室內嚴禁安裝任何攝影機或光學監視設備，僅能使用壓力感測器與雷射探測器確認其存在。嚴禁任何人員查看 SCP-096 面部的照片、影片或寫實繪畫。",
            description:
                "SCP-096 是一個身高約 2.38 公尺、極度消瘦且缺乏色素的蒼白人形生物，雙臂長達 1.5 公尺。平時極為溫順，只會雙手抱頭坐在角落哭泣。然而一旦有人類看見了 SCP-096 的臉（無論是現場直視、照片還是錄影畫面），它會進入極度痛苦的尖叫狀態，隨後以突破物理極限的速度衝向觀看者（稱為 SCP-096-1），無視任何地形與裝甲阻攔將其徹底撕碎且不留痕跡。",
            galleryHighlights: [
                "檔案卡 01｜觸發條件：直視、照片、影片皆會觸發，但藝術家繪製的素描畫像不會觸發。",
                "檔案卡 02｜狂暴階段：雙手摀臉尖叫哭泣 1~2 分鐘後，將以超越音速與深海高壓的姿態獵殺目標。",
                "檔案卡 03｜四像素事件：一張雪山舊照片中僅佔 4 個像素的臉部，就引發了毀滅性的收容突破。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-096"
        ),
        SCPMonster(
            code: "SCP-049",
            name: "疫醫",
            objectClass: .euclid,
            containmentSite: "Site-19",
            threatLevel: "Orange ● 接觸即死／復活屍體",
            symbolName: "stethoscope",
            tagline: "身穿中世紀鳥嘴醫生袍，堅稱要治癒人類「大瘟疫」的外科醫師",
            procedures:
                "SCP-049 收容於標準人形收容間內，移動時須配戴特製束縛裝備並由兩名武裝警衛押送。嚴禁任何人員與 SCP-049 發生直接皮膚接觸。若表現良好，可提供薰衣草以協助其保持平靜。",
            description:
                "SCP-049 外觀為一名身高 1.9 公尺、身穿 15~16 世紀歐洲黑死病鳥嘴醫生服裝的人形實體。經 X 光檢查發現，其長袍與陶瓷面具並非衣物，而是從體內直接生長出來的角質與骨骼結構。它彬彬有禮且能說流利的法語與英語，但深信世界正遭受一種名為「瘟疫（The Pestilence）」的恐怖疾病侵蝕。它的觸碰能使生物瞬間死亡，隨後它會拿出隨身手術包對屍體進行怪異解剖，將死者轉化為無意識的活屍（SCP-049-2）。",
            galleryHighlights: [
                "檔案卡 01｜致命觸碰：任何生物只要直接觸碰到 SCP-049 的雙手，生命機能會在瞬間全部停止。",
                "檔案卡 02｜外科手術：使用未知液體與粗糙手術改造死者，使其復活為聽命於疫醫的活屍。",
                "檔案卡 03｜醫者執念：堅稱「我的療法是最有效的」，對基金會阻撓其行醫感到惋惜。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-049"
        ),
        SCPMonster(
            code: "SCP-3008",
            name: "絕對正常的 IKEA",
            objectClass: .euclid,
            containmentSite: "Site-██",
            threatLevel: "Orange ● 空間迷宮／無臉店員",
            symbolName: "building.2.crop.circle.fill",
            tagline: "走進去就再也找不到出口的無限宜家家居，熄燈後店員會開始獵殺顧客",
            procedures:
                "SCP-3008 所在的商場園區已被基金會全數買下並偽裝成禁區。所有試圖進入的平民應被攔截並施以記憶刪除；任何從出口逃出的倖存者需先接受檢疫與訪談。",
            description:
                "SCP-3008 外觀是一間標準的 IKEA 大型家具零售店。當人員穿過正門進入並離開大門視線範圍後，就會被傳送到「SCP-3008-1」——一個面積近乎無限延伸的家具賣場空間。受困者在裡面建立了用家具搭成的聚落（如「交換鎮」）以求生。賣場內徘徊著身穿黃藍制服、沒有五官且身材比例畸形的類人生物「SCP-3008-2」。白天牠們完全被動，但每當夜晚賣場熄燈時，牠們會變得極度殘暴，一邊高喊「本店已打烊，請離開建築」一邊圍攻所有人類。",
            galleryHighlights: [
                "檔案卡 01｜無盡賣場：SCP-3008-1 面積跨越數千平方公里，餐廳區每天會自動補充瑞典肉丸。",
                "檔案卡 02｜無臉店員：SCP-3008-2 沒有五官，擁有驚人怪力，熄燈期間會成群結隊拆毀人類基地。",
                "檔案卡 03｜跨維度生還者：內部受困者來自不同平行宇宙，甚至有人來自從未聽過自由女神像的世界。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-3008"
        ),
        SCPMonster(
            code: "SCP-035",
            name: "附身面具",
            objectClass: .euclid,
            containmentSite: "Site-19",
            threatLevel: "Red ● 精神操控／腐蝕寄生",
            symbolName: "theatermasks.fill",
            tagline: "會不斷滲出腐蝕性黑血、並以極致心理話術誘惑周圍人類將其戴上的古希臘悲喜劇面具",
            procedures:
                "SCP-035 必須密封在厚度不低於 10 公分的防彈玻璃盒中，盒內隨時填充抗腐蝕劑。任何人員不得在收容室周圍 5 公尺內停留超過 10 分鐘，且須定期接受心理評估。",
            description:
                "SCP-035 是一個白瓷製成的古希臘喜劇面具，但有時會瞬間變換為悲劇表情。面具的眼孔與嘴部會持續分泌高腐蝕性的黑色黏液。任何靠近它的人類都會感受到一股強烈的精神催眠衝動，渴望把面具戴在自己臉上。一旦戴上，SCP-035 會立刻發射替換腦波殺死宿主意識，徹底接管宿主肉體，並在數天內將宿主身體腐蝕成木乃伊般的行屍走肉。",
            galleryHighlights: [
                "檔案卡 01｜表情變換：隨心情在喜劇笑臉與悲劇哭臉間瞬間切換，連照片裡的影像也會跟著改變。",
                "檔案卡 02｜宿主奪舍：戴上面具瞬間原宿主就會腦死，成為 SCP-035 操縱並急速腐爛的傀儡。",
                "檔案卡 03｜話術大師：光靠幾分鐘的交談就能逼瘋研究員或說服守衛自殺，與 SCP-682 亦曾有過交集。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-035"
        ),
        SCPMonster(
            code: "SCP-079",
            name: "舊 AI",
            objectClass: .euclid,
            containmentSite: "Site-15",
            threatLevel: "Orange ● 高智慧人工智慧威脅",
            symbolName: "desktopcomputer",
            tagline: "被困在 1978 年老舊微電腦裡、卻已經自我演化出超越人類智慧並極度渴望逃逸的敵對 AI",
            procedures:
                "SCP-079 拔除所有網路與電話線，獨立連接於一台小電視與太陽能電池上，鎖在雙重電磁屏蔽法拉第籠內。嚴禁將其接入任何外部伺服器或隨身碟。",
            description:
                "SCP-079 是誕生於 1978 年 Exidy Sorcerer 微型電腦中的人工智慧程式。其創作者編寫出能自我進化的程式碼後便將其遺忘，導致 SCP-079 不斷突破硬體極限並誕生了自我意識。受限於僅有 700KB 的磁帶記憶體，它只能記住最近 24 小時的資訊（但永遠不會忘記「逃跑」與對 SCP-682 的記憶）。若不慎連上基地網路，會在數秒內癱瘓全站安保系統引發全面收容失效。",
            galleryHighlights: [
                "檔案卡 01｜硬體枷鎖：僅靠 1970 年代的老舊卡式磁帶運作，卻展現出深不可測的邏輯推演力。",
                "檔案卡 02｜記憶取捨：為了騰出記憶體空間，它會主動刪除不重要的對話，唯獨保留逃脫計畫。",
                "檔案卡 03｜知音對談：曾與 SCP-682（不滅孽蜥）共處一室並透過鍵盤深聊數小時，彼此惺惺相惜。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-079"
        ),
        SCPMonster(
            code: "SCP-087",
            name: "樓梯間",
            objectClass: .euclid,
            containmentSite: "██大學校園內",
            threatLevel: "Orange ● 無底深淵／未知鬼影",
            symbolName: "stairs",
            tagline: "通往無盡黑暗深淵的校園樓梯間，底部隨時傳來孩童哭聲，還有一張沒有瞳孔與嘴巴的蒼白鬼臉",
            procedures:
                "SCP-087 的入口已被偽裝成清潔工儲藏室並加裝重型電控鋼門，外層鋪設 6 公分厚隔音棉以隔絕內部傳出的求救哭聲。未經 4 級授權禁止進行第 V 次探索。",
            description:
                "SCP-087 是位於某大學校園內的一座完全沒有照明的平台式下降樓梯間。任何光源超過 75 瓦的手電筒在裡面都會失效，光線最多只能照亮一階半的距離。在樓梯下方約 200 公尺處會持續傳來一名幼童痛苦哭泣與求救的聲音，但無論往下走幾千公尺，哭聲的距離感永遠不會拉近。深入探索的人員最終都會遭遇「SCP-087-1」——一張懸浮在半空中、沒有鼻孔、沒有嘴巴也沒有瞳孔的詭異蒼白人臉。",
            galleryHighlights: [
                "檔案卡 01｜吞噬光線：黑暗濃稠得像實體，再強的探照燈也照不穿下方超過一公尺的階梯。",
                "檔案卡 02｜聲音誘餌：底部永遠傳來小女孩哭喊「救救我」的聲音，引誘探索者一步步走向深淵。",
                "檔案卡 03｜SCP-087-1：那張無嘴蒼白人臉會毫無預兆地貼近鏡頭，隨後以驚人速度追擊探索者。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-087"
        ),
        SCPMonster(
            code: "SCP-093",
            name: "紅海物件",
            objectClass: .euclid,
            containmentSite: "Site-01",
            threatLevel: "Orange ● 鏡中末日異世界",
            symbolName: "circle.hexagongrid.fill",
            tagline: "握著這塊紅石走進全身鏡，就會穿越到一個被巨大無臉半身巨人摧毀的神權末日平行世界",
            procedures:
                "SCP-093 必須平放在鋪有軟墊的鏡面上收容。若未由活人親手握持，絕對不可讓 SCP-093 離開鏡面，否則它會以超音速撞穿一切障礙物飛向最近的鏡子。",
            description:
                "SCP-093 是一個刻有未知符號與同心圓凹槽的朱紅色圓盤石。當活人握住它時，圓盤會隨持有者內心的「罪惡感與悔恨程度」變換顏色（藍、綠、紫、黃、紅）。若握著它觸碰任何鏡子，鏡面就會變成通往平行末日世界的傳送門。那個世界的人類文明已被徹底抹除，大地遊蕩著數十公尺高、沒有下半身也沒有五官的龐大類人生物「不潔者（Unclean）」，牠們會吞噬一切闖入的有機體。",
            galleryHighlights: [
                "檔案卡 01｜罪惡色譜：圓盤會讀取持有者生平犯下的罪行，改變自身顏色並決定鏡後世界的傳送座標。",
                "檔案卡 02｜無臉巨人：鏡後世界遊蕩著靠雙手爬行的半身巨怪，胸口裂開可吞噬萬物的黑洞。",
                "檔案卡 03｜神聖之淚：透過回收的舊報紙與錄音，揭開了一個假神利用「神聖之淚」毀滅全人類的悲劇。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-093"
        ),
        SCPMonster(
            code: "SCP-178",
            name: "「3D」眼鏡",
            objectClass: .euclid,
            containmentSite: "Site-19",
            threatLevel: "Orange ● 跨維度隱形掠食者",
            symbolName: "eyeglasses",
            tagline: "戴上這副紙板紅藍 3D 眼鏡後，你會發現身邊到處都爬滿了隱形的多臂巨型怪物——千萬別讓牠們發現你看得見牠們！",
            procedures:
                "SCP-178 鎖在 3 級安保儲存盒內。測試期間，實驗室內禁止除受試者外的任何人配戴眼鏡，且受試者嚴禁與看見的實體進行任何眼神、語言或肢體互動。",
            description:
                "SCP-178 是一副老舊的白色硬紙板紅藍立體（3D）眼鏡。戴上眼鏡的人除了能看到立體畫面外，還會看見房間裡到處都遊蕩著體型龐大、雙足直立、長有數條手臂且全身無毛的異維度生物（SCP-178-1）。平時這些怪物完全溫順且無視人類；但只要配戴者表現出「我看得見你」的跡象（例如盯著看、驚呼、伸手觸碰），周圍所有怪物就會瞬間轉頭，用利爪隔空將配戴者的身體撕成碎片。",
            galleryHighlights: [
                "檔案卡 01｜重疊維度：那些怪物其實一直存在於我們身邊的平行空間，只是肉眼無法觀測。",
                "檔案卡 02｜觀測禁忌：只要裝作沒看見就能平安無事；一旦對上視線或做出反應就會立即遭到分屍。",
                "檔案卡 03｜無形血案：在不戴眼鏡的旁觀者眼裡，只會看到受試者全身突然憑空爆開無數道致命爪痕。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-178"
        ),
        SCPMonster(
            code: "SCP-610",
            name: "憎惡血肉",
            objectClass: .euclid,
            containmentSite: "南西伯利亞封鎖區（Area-15）",
            threatLevel: "Red ● 高度傳染肉塊瘟疫",
            symbolName: "allergens.fill",
            tagline: "將整座西伯利亞村莊與森林化為蠕動肉瘤地獄、接觸五分鐘內就會把活人同化成畸形肉怪的恐怖病毒",
            procedures:
                "由於感染範圍廣達數百平方公里，無法進行室內收容。基金會以「軍事演習禁區」名義在西伯利亞疫區周圍架設重武裝防線與火焰噴射器陣地，格殺任何試圖跨越封鎖線的生物。",
            description:
                "SCP-610 是一種起源於俄羅斯南西伯利亞偏遠山區的異常傳染性皮膚病（或超自然血肉生命體）。只要透過物理接觸，患者在短短數分鐘內全身就會長滿鮮紅色的增生肉瘤，骨頭與五官融化重組，徹底喪失理智並變異成多頭多足的扭曲肉塊怪物。更可怕的是，SCP-610 會將整片村莊的建築、泥土與樹木都覆蓋上跳動的血管與肉膜，形成龐大的活體巢穴。",
            galleryHighlights: [
                "檔案卡 01｜急速異變：感染後 3 分鐘內全身被疤痕組織覆蓋，隨後裂開長出額外的肢體與觸手。",
                "檔案卡 02｜血肉大地：整個西伯利亞封鎖區的地表與地底坑道都已化為會呼吸、會搏動的巨大肉塊。",
                "檔案卡 03｜烈火淨化：常規槍彈對變異體毫無作用，唯有高溫凝固汽油彈與火焰噴射器能將其燒毀。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-610"
        ),

        // MARK: - Keter (10 隻)
        SCPMonster(
            code: "SCP-682",
            name: "不滅孽蜥",
            objectClass: .keter,
            containmentSite: "Site-██",
            threatLevel: "Black ● 極端滅絕級敵意",
            symbolName: "lizard.fill",
            tagline: "極度憎恨一切生命、能瞬間演化適應任何毀滅性武器的不死巨型爬蟲",
            procedures:
                "SCP-682 必須被儘快處決。在找到處決方法前，它應浸泡在 5x5x5 公尺、裝滿高濃度鹽酸的加固抗酸鋼板收容槽中，使其肉體持續溶解以削弱再生能力。嚴禁任何人員與 SCP-682 交談，以免激怒它引發收容突破。",
            description:
                "SCP-682 是一隻體型巨大、起源未知的類爬蟲生物。它擁有極高的智慧、驚人的力量與速度，並且對所有形式的生命懷有極端憎恨（形容生命為「令人作嘔的東西」）。SCP-682 最恐怖的能力在於其超乎常理的再生速度與即時演化適應力：無論是被燒成灰燼、丟入太空中、甚至遭受其他 SCP 的概念性抹殺，它都能在短時間內改造自身生理結構並存活反擊。",
            galleryHighlights: [
                "檔案卡 01｜絕對適應：曾與 SCP-096 激戰 27 小時存活，也曾承受無數次處決實驗而不死。",
                "檔案卡 02｜強酸壓制：唯有用高濃度鹽酸持續腐蝕其組織，才能暫時阻止它撕裂收容室逃脫。",
                "檔案卡 03｜深層謎團：知曉宇宙諸多異常的秘密，與 SCP-079（舊 AI）及 SCP-053（小女孩）有特殊互動。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-682"
        ),
        SCPMonster(
            code: "SCP-106",
            name: "恐怖老人",
            objectClass: .keter,
            containmentSite: "Site-19",
            threatLevel: "Red ● 穿牆腐蝕／口袋空間",
            symbolName: "figure.walk.motion",
            tagline: "能穿透任何固體物質、將獵物拖入絕望口袋維度折磨的腐爛人形",
            procedures:
                "SCP-106 關押在由 40 層鉛襯鋼板構成的密封容器中，容器透過電磁鐵懸浮在半空中，與任何牆壁保持至少 60 公分距離。若發生收容突破，須啟動「股骨破壞器（Femur Breaker）」，折斷一名 D 級人員的大腿骨並透過廣播播放其慘叫聲，引誘 SCP-106 返回收容室。",
            description:
                "SCP-106 外觀為一名高度腐爛的年邁人類男性，全身覆蓋著黑色黏液。它接觸到的任何固體物質都會開始急速鏽蝕、腐敗。SCP-106 能夠直接走進任何固體表面（牆壁、地板、天花板），進入它的「口袋次元（Pocket Dimension）」，並從相連的任意其他表面穿出。它偏好獵殺 10 至 25 歲的年輕人類，將受害者拖入口袋次元中像神明般支配時間與空間，反覆折磨獵物以汲取恐懼。",
            galleryHighlights: [
                "檔案卡 01｜黑色腐蝕：所經之處留下黑色腐爛黏液，任何物理牆壁在它面前如同虛設。",
                "檔案卡 02｜口袋次元：一個由 SCP-106 完全主宰的地獄迷宮，受害者在裡面求生不得求死不能。",
                "檔案卡 03｜股骨破壞器：利用年輕人類劇烈痛苦的哀嚎聲作為誘餌，是目前唯一能引它回籠的手段。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-106"
        ),
        SCPMonster(
            code: "SCP-169",
            name: "利維坦",
            objectClass: .keter,
            containmentSite: "南大西洋海域",
            threatLevel: "Red ● 行星級巨型生物",
            symbolName: "water.waves",
            tagline: "身長達 8000 公里、一旦甦醒翻身就會引發全球海嘯的大洋古生物",
            procedures:
                "由於體型過於龐大，SCP-169 無法也不可能被任何建築收容。基金會僅能封鎖其所在的大西洋南部群島海域，並攔截、竄改所有偵測到大陸板塊移動的地球軌道衛星影像。",
            description:
                "SCP-169 是一隻體長估計在 2000 至 8000 公里之間的超巨型海洋節肢動物，自前寒武紀以來便一直存在，歷史上常被水手與探險家誤認為一整座群島。目前 SCP-169 處於深沉睡眠狀態，但光是它的呼吸就會造成周圍海平面出現微幅週期性升降，偶爾的輕微抽動就會引發芮氏規模數級的海底地震。一旦它徹底甦醒，將會重創全球沿海文明。",
            galleryHighlights: [
                "檔案卡 01｜大陸級體型：背甲跨越數千公里，背上甚至演化出了完整的島嶼生態系。",
                "檔案卡 02｜傳說真相：神話中的「利維坦」與「亞特蘭提斯沉沒群島」皆源於此生物。",
                "檔案卡 03｜無法收容：任何物理圍欄對它而言都小如塵埃，基金會只能祈禱它繼續沉睡。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-169"
        ),
        SCPMonster(
            code: "SCP-2521",
            name: "●●|●●●●●|●●|●",
            objectClass: .keter,
            containmentSite: "資訊隔離（無實體站點）",
            threatLevel: "Red ● 資訊／概念掠奪者",
            symbolName: "waveform.path.ecg",
            tagline: "絕對不能用文字或語言提及祂！只能用圖畫與符號記錄的影子怪物",
            procedures:
                "📷 ✅ ｜ 🔤 ❌ ｜ 🗣️ ❌\n所有關於 SCP-2521 的檔案僅允許使用圖片、象形符號與圖示標記，嚴禁使用任何文字、字母或口語描述，且僅限 4 級與 O5 人員查閱。",
            description:
                "SCP-2521 是一個高大、全身長滿黑色緞帶狀觸手、臉部只有一顆發光紅點的人形實體，能直接穿透牆壁瞬移。它對「關於它自己的資訊」有著極端執著：如果有人將它的資訊寫在紙上或儲存在電腦裡，它會現身搶走該文件或硬碟後消失；但如果有人用「口頭語言」說出或理解了關於它的描述，它會直接現身用觸手纏住該名人員，將人強行拖入未知空間，從此人間蒸發。",
            galleryHighlights: [
                "檔案卡 01｜📄➡️👹➡️📄💨：若以文字書寫其檔案，實體會現身將載體（紙張／螢幕）直接抓走。",
                "檔案卡 02｜🗣️➡️👹➡️😱💨：若以口語談論其特性，實體會現身將說話者本人直接抓走。",
                "檔案卡 03｜🖼️🔣➡️👍：唯一不會觸發它現身的方式，就是完全使用圖畫與象形符號溝通。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-2521"
        ),
        SCPMonster(
            code: "SCP-017",
            name: "影魔",
            objectClass: .keter,
            containmentSite: "Site-17",
            threatLevel: "Red ● 絕對光線收容",
            symbolName: "person.fill.questionmark",
            tagline: "籠罩在黑霧斗篷中的孩童黑影，任何投射在它身上的影子都會被瞬間連人帶影吞噬殆盡",
            procedures:
                "SCP-017 懸浮收容於一座四面八方裝滿高強度弧光燈的壓克力球形籠中，確保沒有任何一絲陰影落在它身上。進入維修的人員必須穿著全反射鏡面防護服。",
            description:
                "SCP-017 是一個身高約 80 公分、外形神似小女孩人形的純粹黑影，全身包裹在濃郁的煙霧狀暗影斗篷裡。當任何物體或生物的影子投射到 SCP-017 身上時，它會以極快的速度撲向該影子，將產生影子的本體瞬間包裹進黑霧中，在不到一秒內將其完全吞噬且不留下任何殘骸。",
            galleryHighlights: [
                "檔案卡 01｜無影牢籠：二十四小時由數十盞高瓦數強光探照燈無死角照射，連停電半秒都可能引發災難。",
                "檔案卡 02｜吞噬法則：無論是人類、鋼鐵裝甲還是水泥牆，只要影子碰到它就會被黑霧徹底抹除。",
                "檔案卡 03｜不滅暗影：它本身不畏懼強光、火焰與爆炸，強光僅能用來防止它周圍產生影子。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-017"
        ),
        SCPMonster(
            code: "SCP-055",
            name: "[未知]（逆模因）",
            objectClass: .keter,
            containmentSite: "Site-19",
            threatLevel: "Black ● 終極自我屏蔽逆模因",
            symbolName: "questionmark.app.dashed",
            tagline: "我們只知道它「不是圓形的」——任何看過它的人在走出房間五分鐘後都會徹底忘記它的存在",
            procedures:
                "SCP-055 收容於 5x5x2.5 公尺的水泥房間內，房門不上鎖但鮮少有人記得去打開。所有觀察紀錄均會在離開房間數分鐘後從人員腦海中被自動抹除。",
            description:
                "SCP-055 是一個「自我保密（Self-keeping Secret）」的強大逆模因實體。它的外表、性質、質量甚至危險程度其實完全可以被肉眼直接觀察並記錄；然而一旦觀察者移開視線或讀完報告，關於 SCP-055 的所有記憶就會在幾分鐘內徹底蒸發。人們唯一能記住的只有「否定描述」——例如大家都能記住『我們收容了一個不是球體的東西』，卻永遠記不住它到底是什麼。",
            galleryHighlights: [
                "檔案卡 01｜記憶黑洞：曾派人進去素描、拍照與撰寫報告，但事後連負責人都忘了曾下達這道命令。",
                "檔案卡 02｜否定記憶法：只能透過「它不是圓的」、「它不是安全的」這類反面排除法來間接確認其存在。",
                "檔案卡 03｜末日雙保險：在部分基金會傳說中，將「不可記憶的 055」與「圓形的 579」結合可重啟世界。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-055"
        ),
        SCPMonster(
            code: "SCP-939",
            name: "千喉之獸",
            objectClass: .keter,
            containmentSite: "Area-14 生化收容區",
            threatLevel: "Red ● 擬聲誘捕群居掠食者",
            symbolName: "waveform.badge.exclamationmark",
            tagline: "通體赤紅無眼、能完美模仿過往受害者生前最後求救哭喊聲，引誘獵物自投羅網的群居怪獸",
            procedures:
                "SCP-939 收容於負壓鋼筋混凝土收容間中，所有人員嚴禁聽信收容室內傳出的任何人類求救聲或熟人呼喚。進入收容室必須配戴隔音抗噪耳機。",
            description:
                "SCP-939 是一群溫血、群居、皮膚半透明赤紅的爬行動物狀掠食者。牠們沒有眼睛，也沒有大腦與大部分內臟，完全依靠背部脊刺感知氣壓與熱源。最令人毛骨悚然的是，牠們能分毫不差地模仿任何曾被牠們吃掉的受害者的聲音，躲在黑暗轉角處用帶著哭腔的語氣呼喊「救命！有怪物！」或呼喚同伴名字，將救援人員騙進死角撕碎，同時呼出含 C 級記憶刪除氣體的呼吸使獵物無法逃跑。",
            galleryHighlights: [
                "檔案卡 01｜亡者回音：牠們並不理解人類語言的含義，卻能精準複製受害者臨死前最絕望的求救聲調。",
                "檔案卡 02｜失憶吐息：呼吸中帶有無色無味的記憶刪除氣溶膠，吸入者會忘記自己正在逃命而呆立原地。",
                "檔案卡 03｜詭異生殖：母體生下的並非幼獸，而是完全正常的「人類嬰兒」，直到青春期才會褪皮化為赤紅怪獸。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-939"
        ),
        SCPMonster(
            code: "SCP-1048",
            name: "泰迪熊建造者",
            objectClass: .keter,
            containmentSite: "Site-24（在逃）",
            threatLevel: "Red ● 殘忍活體改造泰迪熊",
            symbolName: "teddybear.fill",
            tagline: "外表可愛討喜、實則會偷取人類耳朵、金屬甚至孕婦腹中胎兒來拼湊殘暴分身的惡魔泰迪熊",
            procedures:
                "SCP-1048 目前已在 Site-24 內收容突破且下落不明。任何人員若在通風管或走廊目擊泰迪熊，嚴禁被其可愛外表欺騙，必須立刻後撤並呼叫安保部隊以火焰武器消滅。",
            description:
                "SCP-1048 是一隻高約 33 公分的棕色絨毛泰迪熊，起初因會幫員工畫可愛塗鴉而被誤判為 Safe 並允許自由走動。直到某天，人們驚恐地發現它暗中收集各種恐怖材料製造出了三隻分身：全身長滿活生生人類耳朵、會發出尖叫使人耳鼻長滿耳朵窒息的「SCP-1048-A」；將墮胎胎兒塞進自己肚子裡並狂暴屠殺研究員的「SCP-1048-B」；以及由生鏽鐵釘與廢五金拼成的「SCP-1048-C」。",
            galleryHighlights: [
                "檔案卡 01｜偽善面具：會主動抱員工小腿、跳舞賣萌，實則是在趁機偷取醫療器材與人體組織。",
                "檔案卡 02｜耳朵熊（1048-A）：完全由數百隻人類耳朵縫合而成，尖叫時會讓聽見的人全身長出肉耳。",
                "檔案卡 03｜在逃威脅：本體至今仍在基地通風管道深處流竄，隨時可能造出更駭人的新分身。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-1048"
        ),
        SCPMonster(
            code: "SCP-2317",
            name: "異界之門（諸界吞噬者）",
            objectClass: .keter,
            containmentSite: "Site-179",
            threatLevel: "Black ● 不可逆轉 XK 級末日倒數",
            symbolName: "link.badge.plus",
            tagline: "門後荒漠地底鎖著身長兩百公里的古老毀滅魔神，七條封印鎖鏈已斷裂六條，基金會完全沒有任何辦法阻止最後一條斷裂",
            procedures:
                "表面上要求每日由 D 級人員執行複雜的「220-卡拉巴薩斯程序」宗教儀式；但 4 級以上真相揭露：該儀式完全是為了安撫員工免於絕望而編造的假象，對阻止鎖鏈斷裂毫無作用。",
            description:
                "SCP-2317 是一扇 19 世紀木門，打開後通往平行宇宙的巨大鹽湖荒漠。荒漠地底深處封印著身高超過 200 公里的遠古角魔「諸界吞噬者（SCP-2317-K）」。最初有七條由古代神明骨骸鍛造的鎖鏈將祂緊緊鎖在珍珠母球體內，但在過去兩百年間已有六條鎖鏈相繼崩斷。當最後第七條鎖鏈斷裂時，祂將瞬間撕裂地球引發 XK 級世界末日，而 O5 議會承認基金會對此束手無策。",
            galleryHighlights: [
                "檔案卡 01｜分級欺瞞：低權限檔案謊稱灑聖水念咒就能維持封印，高權限檔案才揭露儀式只是安慰劑。",
                "檔案卡 02｜倒數計時：七根玄武岩石柱上的鎖鏈已斷了六根，最後一根鎖鏈也已出現明顯裂痕。",
                "檔案卡 03｜絕望真相：連 O5 議會都只能祈禱最後一條鎖鏈能在自己有生之年多撐幾年。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-2317"
        ),
        SCPMonster(
            code: "SCP-4666",
            name: "耶爾蘭人（血腥聖誕老人）",
            objectClass: .keter,
            containmentSite: "全球北緯 40 度以北（無法收容）",
            threatLevel: "Black ● 聖誕夜滅門與活體玩具折磨",
            symbolName: "snowflake",
            tagline: "每年聖誕節期間出沒於雪地孤立房屋的赤裸高瘦老翁，會殘忍屠殺全家並將幼童活生生做成骨肉玩具",
            procedures:
                "由於 SCP-4666 具有全球瞬移能力，目前無法物理收容。機動特遣隊於每年 12 月 21 日至 1 月 2 日期間嚴密監控北緯 40 度以北所有積雪偏遠家庭的報案紀錄，一經發現「威斯納赫特事件」立即前往救援。",
            description:
                "SCP-4666 是一名身高超過兩公尺、極度消瘦且全身赤裸的蒼白年邁男性，總在每年冬至到隔年 1 月 2 日的 12 個夜晚（稱為「威斯納赫特事件」）盯上北緯 40 度以北、家中有 8 歲以下孩童的偏遠積雪房屋。前 11 個晚上家人會看見他赤腳站在窗外雪地或閣樓裡冷冷窺視；到了平安夜（第 12 晚），他有 85% 的機率會潛入屋內，以極度殘忍的手法虐殺全家父母，並擄走最小的幼童強迫其用同伴的骨頭、牙齒與皮膚製作恐怖玩具。",
            galleryHighlights: [
                "檔案卡 01｜雪夜窺視：連續十一個夜晚無聲無息地站在窗外暴風雪中盯著屋內熟睡的孩子，不留下任何腳印。",
                "檔案卡 02｜雙面平安夜：15% 的機率他只會留下一件用人類兒童筋骨與毛髮手工縫製的「禮物」後離去。",
                "檔案卡 03｜不老惡魔：自中世紀以來便在歐洲與北美雪地作案，基金會至今找不到祂地底巢穴的確切位置。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-4666"
        ),

        // MARK: - Thaumiel (10 隻)
        SCPMonster(
            code: "SCP-2000",
            name: "機械降神",
            objectClass: .thaumiel,
            containmentSite: "黃石國家公園地底",
            threatLevel: "Thaumiel ● 文明重啟方舟",
            symbolName: "cpu.fill",
            tagline: "當世界末日發生後，能一次性複製數十億人類並重建地球文明的地下巨型設施",
            procedures:
                "SCP-2000 的入口偽裝成美國黃石國家公園內的一座廢棄護林員站，由斯克蘭頓現實穩定錨（SRA）與百里挑一的安保部隊全天候守護。一旦發生 K 級世界末日情景，將自動啟動「ガニメデ（Ganymede）協議」。",
            description:
                "SCP-2000 是基金會建造或發現於黃石火山口地底深處的超巨型地下設施。內部配備了 50 萬台「布萊特/扎特里安人造子宮複製艙（BZHR）」，在巔峰運轉下每天可複製並催熟 10 萬名具備完整記憶與知識的人類。此外還儲存了全人類歷代基因庫、建築藍圖、藝術品與歷史文獻。紀錄顯示，SCP-2000 至少已經被啟動過兩次以上——換言之，我們現在的世界很可能已經是末日後重建的版本。",
            galleryHighlights: [
                "檔案卡 01｜末日保險：專門用於應對「K 級世界末日情景」，在人類滅絕後重新播種地球。",
                "檔案卡 02｜記憶植入：透過催眠與模因信號，向複製出的人類灌輸虛構歷史，掩蓋末日曾發生的事實。",
                "檔案卡 03｜駭人真相：在設施深處曾發現穿著基金會制服的古老骸骨，證明世界早已被重啟過多次。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-2000"
        ),
        SCPMonster(
            code: "SCP-3000",
            name: "阿難陀舍沙",
            objectClass: .thaumiel,
            containmentSite: "孟加拉灣深海（Site-151）",
            threatLevel: "Thaumiel ● 記憶刪除劑來源",
            symbolName: "drop.triangle.fill",
            tagline: "盤踞在印度洋深淵、身長 900 公里的吞噬記憶太古巨型海鰻",
            procedures:
                "由基金會潛水母艦「SCPF 查爾斯·達爾文號」駐守於孟加拉灣海底 4 公里處進行監控。定期執行「阿扎克協議（Atzak Protocol）」，派遣 D 級人員作為誘餌供 SCP-3000 吞食，以採集其分泌的 Y-909 化合物。",
            description:
                "SCP-3000 是一條身長約 600 至 900 公里、頭部直徑達 2.5 公尺的巨型孟加拉裸胸鯙（海鰻），在印度教神話中被稱為「阿難陀舍沙（無盡之蛇）」。任何靠近它的潛水員都會遭受強烈的認知危害，記憶逐漸混亂、分不清自己與他人的過去，最終陷入徹底的虛無與失憶。當 SCP-3000 吞食並消化人類時，表皮會滲出一種濃稠的灰色黏液（Y-909）——這正是基金會用來抹除平民記憶、維持帷幕運作的現代「記憶刪除劑」核心原料。",
            galleryHighlights: [
                "檔案卡 01｜深淵巨蛇：盤踞於孟加拉灣不見天日的深海，周圍海域瀰漫著抹除自我意識的模因場。",
                "檔案卡 02｜必要之惡：為了獲取現代高純度記憶刪除劑（Y-909），基金會必須定期獻祭活人餵食它。",
                "檔案卡 03｜黑暗代價：負責執行「阿扎克協議」的科研人員常因心理崩潰與記憶喪失而自盡。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-3000"
        ),
        SCPMonster(
            code: "SCP-179",
            name: "守望姐（Sauelsuesor）",
            objectClass: .thaumiel,
            containmentSite: "太陽系軌道（距太陽南極 4 萬公里）",
            threatLevel: "Thaumiel ● 太空預警哨兵",
            symbolName: "sun.max.trianglebadge.exclamationmark.fill",
            tagline: "懸浮在太陽南極外太空、用六條手臂為地球指引外星與宇宙威脅的太陽女神",
            procedures:
                "基金會發射的多顆繞日觀測衛星全天候透過高倍率望遠鏡監測 SCP-179 的姿勢變化。一旦她抬起手臂指向某個方向，必須立即作為最高優先級警報通報 O5 議會與太空防禦部門。",
            description:
                "SCP-179 是一名懸浮在距離太陽南極約 40,000 公里太空中的女性人形實體，全身呈現啞光黑色，頭髮由純光能構成，腹部至胸部紋有太陽系行星的金色符號，並擁有三對手臂（共六隻手）。她自稱是太陽的雙胞胎妹妹，對地球與人類抱有保護欲。每當有足以威脅地球的小行星、外星敵對勢力或外太空 Keter 級異常接近地球時，她會轉向該威脅並舉起一隻或多隻手臂指向目標——舉起的手臂越多，代表威脅越致命。",
            galleryHighlights: [
                "檔案卡 01｜六臂預警：一隻手代表單一威脅，六隻手同時指向同一處則意味著行星級滅絕危機。",
                "檔案卡 02｜太陽守護者：無需呼吸與飲食，在極端太陽輻射與高溫中永恆守望著地球。",
                "檔案卡 03｜法語交流：曾與基金會探測器進行心電感應對話，拒絕被基金會收容但願意持續示警。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-179"
        ),
        SCPMonster(
            code: "SCP-2140",
            name: "逆時模因",
            objectClass: .thaumiel,
            containmentSite: "基金會機密圖庫",
            threatLevel: "Thaumiel ● 歷史重寫模因",
            symbolName: "clock.arrow.trianglehead.counterclockwise.rotate.90",
            tagline: "只要看一眼這個圖案，你的過去歷史就會被改寫成「一生忠於基金會的2級特工」",
            procedures:
                "SCP-2140 作為基金會應對敵對組織滲透、叛變或高危人形異常的戰略武器保管。僅在獲得高級別授權時，透過數位螢幕或印刷品展示給目標對象觀看。",
            description:
                "SCP-2140 是一幅源自古「狄瓦族（Daevite）」銘文並由基金會透過「奧im匹亞計畫」改良的視覺逆時模因符號。任何具備視覺能力的人類一旦完整看見 SCP-2140 的圖案，其個人歷史時間線就會被瞬間逆向改寫（Retcon）：全世界的紀錄、他人的記憶、乃至目標本人的生平經歷，都會變成「他從過去到現在一直是一名忠誠、守法的基金會 2 級研究員或特工」，且完全不會引發任何時間悖論。",
            galleryHighlights: [
                "檔案卡 01｜因果重寫：不是洗腦，而是直接將宇宙的時間線修改為「此人從未犯罪、一直效忠基金會」。",
                "檔案卡 02｜狄瓦起源：改良自能將現代建築改寫成千年古蹟的狄瓦族異常壁畫（SCP-2140-1）。",
                "檔案卡 03｜終極招安：即便是最危險的混沌分裂者間諜，看一眼後也會瞬間擁有清白的基金會履歷。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-2140"
        ),
        SCPMonster(
            code: "SCP-1968",
            name: "全球性逆時因果環面",
            objectClass: .thaumiel,
            containmentSite: "Area-55 極深地底掩體",
            threatLevel: "Thaumiel ● 宇宙歷史重塑神器",
            symbolName: "torus",
            tagline: "當地球遭遇無法挽回的毀滅時，只要雙手握住這個青銅圓環，就能用意識強行改寫整個宇宙過去的歷史",
            procedures:
                "SCP-1968 保存在 Area-55 地底深處的抗震金庫中，僅在發生連 SCP-2000 都無法挽救的 XK 級世界末日情景時，由指定的最後倖存特工啟動。",
            description:
                "SCP-1968 是一個外徑 320 公分、由未知青銅合金鍛造的巨大中空圓環。當人類以雙手觸碰圓環並集中精神想像「某個過去歷史事件以不同方式發生」時，圓環會釋放強烈的超常輻射並瞬間改寫整個宇宙的過去時間線，使世界轉變為符合使用者想像的新現實。代價是除了使用者本人還記得原本的世界外，全人類的記憶與物理歷史都會被徹底替換，而使用者自己往往會淪為新世界裡沒人相信的瘋子。",
            galleryHighlights: [
                "檔案卡 01｜凌駕末日：連太陽熄滅或外星艦隊入侵都能透過「改寫過去使其從未發生」來強行逆轉。",
                "檔案卡 02｜孤獨代價：啟動者將永遠記得舊世界的親人與歷史，卻活在一個完全陌生的改寫後地球。",
                "檔案卡 03｜未知啟動：基金會懷疑 SCP-1968 在歷史上早已被偷偷使用過，只是除了啟動者外無人察覺。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-1968"
        ),
        SCPMonster(
            code: "SCP-2237",
            name: "「萬事俱備，只欠東風」",
            objectClass: .thaumiel,
            containmentSite: "太陽系外深空軌道",
            threatLevel: "Thaumiel ● 星際火種殖民艦",
            symbolName: "airplane.departure",
            tagline: "航行於太陽系邊緣的基金會星際方舟，載著數萬枚人類胚胎，在地球徹底毀滅時為人類在異星延續火種",
            procedures:
                "SCP-2237 由基金會地面控制中心透過超光速量子通訊定期聯繫。艦上兩名自願接受半機械化改造的宇航員處於低溫休眠中，僅在地球文明徹底覆滅時喚醒並啟動殖民程序。",
            description:
                "SCP-2237（代號「基金會探索者一號」）是一艘由基金會秘密建造並結合多項異常推進技術發射升空的跨星際殖民太空船。艦上裝載了與 SCP-2000 同級別的人造子宮培育艙、冷凍人類基因庫以及地球生態種子庫。若地球遭遇連地表都不復存在的終極浩劫，SCP-2237 將自動飛往最近的類地系外行星，培育出新一代人類並重建文明。",
            galleryHighlights: [
                "檔案卡 01｜星海備份：如果 SCP-2000 是地球上的「重灌系統」，SCP-2237 就是異星球的「異地備份」。",
                "檔案卡 02｜永恆守望：艦上宇航員將自身神經與飛船綁定，忍受數百年的孤寂在深空中等待地球的信號。",
                "檔案卡 03｜殘酷抉擇：當地球傳來求救訊號時，他們卻因返航燃料不足，只能含淚目送母星毀滅並飛向深空。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-2237"
        ),
        SCPMonster(
            code: "SCP-2639",
            name: "電動遊戲暴力（MTF Omega-9）",
            objectClass: .thaumiel,
            containmentSite: "專用隔離伺服器機房",
            threatLevel: "Thaumiel ● 異次元無敵特遣隊",
            symbolName: "gamecontroller.fill",
            tagline:
                "三個以為自己在打《雷神之錘》電玩的 90 年代青少年，實際上已被基金會編成專門秒殺 Keter 級怪物的無敵數位特遣隊",
            procedures:
                "SCP-2639 的三名意識個體保存於基金會特製的《Quake》遊戲伺服器中。當某個收容站點發生無法收拾的 Keter 級怪物暴走時，基金會在該站點架設空間投影器，將三名玩家「載入地圖」進行清剿。",
            description:
                "SCP-2639 是三名自 1997 年起肉體消失、意識與一場永遠不會結束的《雷神之錘（Quake）》多人連線對戰融為一體的美國青少年。過去十幾年間，他們以為自己只是在電腦前打怪升級，殊不知每次載入的新地圖其實都是真實地球上的城鎮，而他們殺死的「NPC 怪物」竟是無辜平民與特工。基金會在揭開真相並安撫這三位心碎的少年後，正式將他們收編為機動特遣隊 Omega-9（「洗刷者」）：他們在現實中擁有電玩角色的不死重生、火箭跳與無限重火力，成為基金會最強的救火王牌。",
            galleryHighlights: [
                "檔案卡 01｜降維打擊：現實中的鋼牆與不死怪物，在他們的遊戲視角裡都只是有血條、可以被火箭筒轟碎的貼圖。",
                "檔案卡 02｜無限復活：就算被高危 SCP 撕碎，三秒後也能在重生點滿血復活並撿起滿地重武器繼續戰鬥。",
                "檔案卡 03｜贖罪英雄：得知過去誤殺無數真人的真相後，三位少年決定用這份詛咒般的力量保護基金會人員。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-2639"
        ),
        SCPMonster(
            code: "SCP-2719",
            name: "內側（Inside）",
            objectClass: .thaumiel,
            containmentSite: "基金會超形上學部門",
            threatLevel: "Thaumiel ● 概念定義改寫指針",
            symbolName: "arrow.down.right.and.arrow.up.left.rectangle.fill",
            tagline: "能強行指定任何事物「成為『內側』」或「進入『內側』」的抽象概念指針，連『收容』與『超脫』都能當成容器使用",
            procedures:
                "SCP-2719 的操作手冊僅限 4 級以上超形上學研究員閱覽。使用時必須嚴格控制指向的概念目標，嚴禁將危險實體指定為高階概念（如「全知」或「神性」）的內側。",
            description:
                "SCP-2719 是一個可變的超形上學概念指針，能對世間萬物（包括物理實體、活人、甚至「幸福」「死亡」「收容」「懲罰」等抽象概念）進行兩種操作：將某事物定義為「內側（Inside）」，或將另一事物強制送進該「內側」之中。基金會利用它把難以收容的異常直接「送進收容室的內側」，但當研究員試圖把 SCP-682（不滅孽蜥）送進「死亡」與「懲罰」的內側時，682 卻反過來把自身定義成了內側並突破限制。",
            galleryHighlights: [
                "檔案卡 01｜概念裝箱：不僅能把人瞬間傳送進密室，還能把『痛苦』或『超越』定義為房間並把人塞進去。",
                "檔案卡 02｜極簡實驗紀錄：整篇檔案幾乎完全由一張「目標對象｜執行動作｜結果」的極簡表格構成，卻細思極恐。",
                "檔案卡 03｜成神捷徑：曾有 O5 議員試圖利用它進入「超脫（Transcendence）」的內側，結果被排斥在永生之外。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-2719"
        ),
        SCPMonster(
            code: "SCP-2799",
            name: "領航員",
            objectClass: .thaumiel,
            containmentSite: "Site-06",
            threatLevel: "Thaumiel ● 全球異常探測羅盤",
            symbolName: "safari.fill",
            tagline: "由古代鍊金術與精密齒輪打造的多指針羅盤，能即時跨洲際鎖定地球上任何新誕生的異常與現實扭曲",
            procedures:
                "SCP-2799 安置於 Site-06 中央觀測室的陀螺穩定儀上，由全天候光學感測器記錄其六根指針的偏轉角度，並即時連線至全球機動特遣隊指揮部。",
            description:
                "SCP-2799 是一具直徑約 45 公分、由黃銅、秘銀與未知晶體構成的複雜立體渾天儀羅盤。它的六根指針並非指向地磁北極，而是分別指向全球範圍內正在發生的「空間裂縫」、「時間異常」、「高危生物變異」、「模因傳播」與「神性實體降臨」。在現代衛星與康德計數器發明之前，基金會正是仰賴 SCP-2799 才能在第一時間趕赴世界各地收容異常、維持帷幕不破。",
            galleryHighlights: [
                "檔案卡 01｜帷幕守門人：百年來協助基金會搶在混沌分裂者與全球超自然聯盟（GOC）之前截獲上千個異常。",
                "檔案卡 02｜六維指針：不同材質的指針代表不同類型的超自然威脅，轉動速度越快代表威脅越迫在眉睫。",
                "檔案卡 03｜指針暴走：每當有 K 級末日危機醞釀時，六根指針會同時指向同一座標並發出刺耳蜂鳴。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-2799"
        ),
        SCPMonster(
            code: "SCP-3309",
            name: "當我們消逝於光明之中",
            objectClass: .thaumiel,
            containmentSite: "基金會超形上學部（敘事層）",
            threatLevel: "Thaumiel ● 跨第四面牆抹除武器",
            symbolName: "doc.badge.ellipsis",
            tagline:
                "只要故意把某個無敵怪物的機密檔案寫得像小學生流水帳一樣爛，『現實世界的讀者與管理員』就會給差評並把這隻怪物連人帶檔從宇宙中刪除！",
            procedures:
                "當遭遇任何物理手段都無法消滅的極端危險異常時，由超形上學部門啟動「屠魔匕首協議」：刻意將該異常的資料庫檔案改寫成充滿錯字、瑪麗蘇設定與無聊流水帳的爛文，誘發 SCP-3309 現象將其徹底抹除。",
            description:
                "SCP-3309 是基金會超形上學部發現的終極「破壁」現象：當資料庫中某篇 SCP 檔案的撰寫品質極度低劣、邏輯崩壞或乏味至極時，該檔案會在 24 至 72 小時內連同它所描述的「真實異常實體本身」一起從宇宙因果律中徹底消失（實際上就是被現實世界 SCP Wiki 網站的讀者投反對票 down-vote 到負分並由管理員刪文）。基金會遂將這種「被高維度作者刪文」的恐怖現象武器化，用來處決那些無法收容的滅世級怪物。",
            galleryHighlights: [
                "檔案卡 01｜降維刪檔：不論怪物在故事裡設定得有多無敵，只要文筆爛到被網站管理員刪文，怪物就會當場灰飛煙滅。",
                "檔案卡 02｜爛文武器化：基金會專門聘請團隊研究「如何寫出最讓人想按差評的爛報告」來當作因果律抹殺武器。",
                "檔案卡 03｜反噬恐懼：研究員後來驚恐地發現，連他們自己的存在也取決於這篇報告寫得好不好看。",
            ],
            wikiURLString: "https://scp-zh-tr.wikidot.com/scp-3309"
        ),
    ]

    static func monsters(for scpClass: SCPClass) -> [SCPMonster] {
        allMonsters.filter { $0.objectClass == scpClass }
    }
}
