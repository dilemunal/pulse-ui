import SwiftUI
import Combine
import UIKit


let API_URL = "http://localhost:8000/api/sales-opportunities/1"
let VODAFONE_RED = Color(red: 230/255, green: 0, blue: 0)


struct PulseData: Codable {
    let customer_id: Int?
    let name: String?
    let persona_label: String?
    let current_intent: String?
    let suggested_product: String?
    let marketing_headline: String?
    let marketing_content: String?
    let ai_reasoning: AIReasoning?
    let created_at: String?

    static let dummy = PulseData(
        customer_id: 1,
        name: "Merve Kaya",
        persona_label: "[Veri Tutkunu ve Seyahat Meraklısı] Yüksek ARPU ve veri kullanımı, düşük sözleşme süresi risk oluşturur.",
        current_intent: "General Browsing",
        suggested_product: "Sınırsız Video Pass",
        marketing_headline: "Yağışlı günlerde dizi keyfi, Merve!",
        marketing_content: "Merhaba Merve, İstanbul’da yağışlı ve soğuk bir gün geçirirken, Sınırsız Video Pass ile Netflix, Amazon Prime ve daha fazlasında sınırsız video keyfini sürdürebilirsin.",
        ai_reasoning: AIReasoning(
            customer_facts_used: [
                "Yağışlı soğuk hava ve evde kalma eğilimi",
                "YouTube Premium üyeliği",
                "Kalan veri miktarı düşük"
            ],
            product_facts_used: [
                "Sınırsız Video Pass: YouTube, Netflix, Amazon Prime gibi uygulamalarda sınırsız izleme",
                "Aylık geçerlilik"
            ],
            why_this_product_now: [
                "Yağışlı havada evde kalma ihtimali yüksek, video izleme isteği artar",
                "Kalan veri düşük, sınırsız paket rahatlatır"
            ],
            strategist_reasoning: "Müşteri video tüketiyor; yağışlı hava ev içi eğlenceyi artırır. Video Pass, veri endişesini ortadan kaldırır.",
            grounding: Grounding(
                selected_news: "İstanbul hava durumu: Yağışlı/Soğuk",
                search_query: "sınırsız video pass",
                chosen_product_code: "ADD-0034"
            )
        ),
        created_at: "2026-01-17T22:23:41.802640"
    )

        static let dummySchoolBreak = PulseData(
            customer_id: 4,
            name: "Efe",
            persona_label: "[Öğrenci / Aile Hattı] Tatilde evde geçirilen süre artar; oyun + video tüketimi yükselir.",
            current_intent: "School Break",
            suggested_product: "Tatil Modu: Yüksek GB / Sınırsız Sosyal-Video",
            marketing_headline: "Tatil başladıysa internet bitmez.",
            marketing_content: "15 tatilde oyun + dizi maratonu tam gaz. İnternetin yarıda kesilmesin diye Tatil Modu’nu hazırladık; evde de dışarıda da rahat et.",
            ai_reasoning: AIReasoning(
                customer_facts_used: [
                    "Yarıyıl tatili başlıyor (Sömestır)",
                    "Evde kalma + içerik tüketimi artar",
                    "Oyun/streaming kullanımı yükselir"
                ],
                product_facts_used: [
                    "Yüksek GB: tatil boyunca kesintisiz kullanım",
                    "Sosyal/Video odaklı paket: eğlence tüketimini kapsar"
                ],
                why_this_product_now: [
                    "Tatil başlangıcı: tüketim pik yapar",
                    "Kota bitmesi ‘tatil keyfini’ bozar"
                ],
                strategist_reasoning: "Tatil sinyali geldiği an teklif vermek, kullanıcının ‘Pulse beni benden çok düşünüyor’ demesini sağlar.",
                grounding: Grounding(
                    selected_news: "2026-01-19 – 2026-01-30: Yarıyıl Tatili (15 Tatil)",
                    search_query: "yarıyıl tatili internet paketi",
                    chosen_product_code: "HOLIDAY-MODE"
                )
            ),
            created_at: "2026-01-18T01:09:17"
        )
    static let dummyFreezoneStorm = PulseData(
           customer_id: 2,
           name: "Zeynep",
           persona_label: "[FreeZone Öğrencisi] Kota kritik seviyede; eğlence tüketimi yüksek (Netflix/YouTube).",
           current_intent: "Weekend Entertainment",
           suggested_product: "Günlük Sınırsız Video Pass (29₺)",
           marketing_headline: "Zeynep, hafta sonu planını senin için yaptım!",
           marketing_content: "Dışarıda fırtına koparken evde keyfin kaçmasın. Kotan bitmek üzere ama dert etme; dizilerin yarıda kalmasın diye sana özel günlük sınırsız video tanımladık.",
           ai_reasoning: AIReasoning(
               customer_facts_used: [
                   "Kota: %90 kullanılmış (kritik)",
                   "Netflix/YouTube ağırlıklı tüketim",
                   "Hafta sonu eğlence tüketimi artar"
               ],
               product_facts_used: [
                   "Günlük Sınırsız Video Pass: video uygulamalarında kota derdi olmadan kullanım",
                   "Kısa süreli ihtiyaç için hızlı aktive olur"
               ],
               why_this_product_now: [
                   "Fırtına/yağmur nedeniyle evde kalma olasılığı yüksek",
                   "Kota kritik; video tüketimi yarıda kalabilir"
               ],
               strategist_reasoning: "Hava sinyali + kritik kota birleşince en büyük acı nokta 'sıkılmak + izleyememek'. Anında çözüm: günlük sınırsız video.",
               grounding: Grounding(
                   selected_news: "İstanbul: Şiddetli fırtına/yağmur uyarısı (hafta sonu)",
                   search_query: "günlük sınırsız video pass 29",
                   chosen_product_code: "VPA-DAILY-29"
               )
           ),
           created_at: "2026-01-18T01:09:17"
       )
    static let dummyDerby = PulseData(
            customer_id: 3,
            name: "Emir",
            persona_label: "[Taraftar / Sosyal Aktif] Derbi günlerinde paylaşım ve canlı takip yoğun; stadyum/kalabalık ağ riski.",
            current_intent: "Match Day",
            suggested_product: "Günlük Taraftar Paket 10 GB",
            marketing_headline: "Derbide tek donan şey rakip olsun.",
            marketing_content: "Bugün GS- FB derbisi var, sevdiğini biliyoruz ! Maç günü story, canlı yayın, skor… İnternetin kesilmesin diye Maç Modu’nu açtık. Kalabalık ağda bile paylaşımın akıcı kalsın.",
            ai_reasoning: AIReasoning(
                customer_facts_used: [
                    "Spor içerik tüketimi",
                    "Derbi günleri sosyal medya kullanımı yükseliyor",
                    "Stadyum/kalabalık ağ → hız düşüş riski"
                ],
                product_facts_used: [
                    "Maç Modu: yoğun saatlerde daha stabil bağlantı deneyimi",
                    "Ek GB: canlı yayın/story/harita kullanımını rahatlatır"
                ],
                why_this_product_now: [
                    "Derbi günü: data patlaması ve ağ yoğunluğu beklenir",
                    "Kullanıcı için 'an' önemli: kaçırma korkusu yüksek"
                ],
                strategist_reasoning: "Maç gününde en küçük kesinti kullanıcıyı sinirlendirir. 'Pulse aklı senden önce' hissi için maç özelinde hız+GB önerisi.",
                grounding: Grounding(
                    selected_news: "Derbi günü / yoğun etkinlik saatleri (takvim sinyali)",
                    search_query: "stadyum internet yoğunluk maç günü paket",
                    chosen_product_code: "MATCH-MODE-GB"
                )
            ),
            created_at: "2026-01-18T01:09:17"
        )

        static let dummyMertTravel = PulseData(
            customer_id: 2,
            name: "Mert Yılmaz",
            persona_label: "[Konfor Odaklı Seyahatçi] Aile paketi, iPhone kullanıcısı, roaming harcaması yüksek. Tatil dönemlerinde yurt dışı kullanımı artar.",
            current_intent: "Trip Planning",
            suggested_product: "Her Şey Dahil Pasaport",
            marketing_headline: "Mert Bey, valizinizde tek bir eksik kaldı.",
            marketing_content: "Sömestr geldi! Ailenizle tatil rotanız belli oldu mu? Nereye giderseniz gidin, telefonunuzu Türkiye'deymiş gibi kullanın diye Her Şey Dahil Pasaport'unuzu hazırladık.",
            ai_reasoning: AIReasoning(
                customer_facts_used: [
                    "Sömestr / okul tatili dönemi yaklaşıyor",
                    "Aile paketi kullanıyor",
                    "iPhone kullanıcısı",
                    "Roaming harcaması geçmişte yüksek"
                ],
                product_facts_used: [
                    "Yurt dışında fatura şokunu engeller",
                    "Türkiye'deymiş gibi kullanım deneyimi",
                    "Tatil döneminde kesintisiz bağlantı"
                ],
                why_this_product_now: [
                    "Tatil planı yapılmadan önce güven hissi verir",
                    "Yüksek bütçeli seyahat döneminde en büyük risk roaming",
                    "Aile ile kullanımda veri/iletişim ihtiyacı artar"
                ],
                strategist_reasoning: "Mert Bey'in okul tatillerinde yurt dışına çıkma alışkanlığı ve yüksek roaming harcaması, tatil takvimi sinyaliyle birleşince 'fatura şoku' riskini öne çıkarır. Her Şey Dahil Pasaport, seyahat gibi yüksek bütçeli bir konuda güven ve konfor satar; kullanıcı daha plan aşamasındayken Pulse'un bir adım önde olduğunu hissettirir.",
                grounding: Grounding(
                    selected_news: "Sömestr / okul tatili yaklaşıyor",
                    search_query: "Her Şey Dahil Pasaport",
                    chosen_product_code: "ADD-PASSPORT-001"
                )
            ),
            created_at: "2026-01-18T03:55:00.000000"
        )
    

}

struct AIReasoning: Codable {
    let customer_facts_used: [String]?
    let product_facts_used: [String]?
    let why_this_product_now: [String]?
    let strategist_reasoning: String?
    let grounding: Grounding?
}

struct Grounding: Codable {
    let selected_news: String?
    let search_query: String?
    let chosen_product_code: String?
}

// --- 3. VIEWMODEL ---
final class PulseViewModel: ObservableObject {
    @Published var data: PulseData = PulseData.dummyMertTravel
    @Published var isLoading = false

    func fetchData() {
        guard let url = URL(string: API_URL) else { return }
        DispatchQueue.main.async { self.isLoading = true }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            DispatchQueue.main.async {
                self?.isLoading = false
                guard let data else { return }
                do {
                    self?.data = try JSONDecoder().decode(PulseData.self, from: data)
                } catch {
                    print("JSON Error: \(error)")
                }
            }
        }.resume()
    }
}

// --- 4. BACKGROUND ---
struct CleanTechBackground: View {
    @State private var drift: CGFloat = 0

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            GeometryReader { geo in
                Path { path in
                    path.move(to: CGPoint(x: 0, y: geo.size.height * 0.40))
                    path.addLine(to: CGPoint(x: geo.size.width * 0.22, y: geo.size.height * 0.40))
                    path.addLine(to: CGPoint(x: geo.size.width * 0.32, y: geo.size.height * 0.46))
                    path.addLine(to: CGPoint(x: geo.size.width * 0.82, y: geo.size.height * 0.46))
                }
                .stroke(
                    VODAFONE_RED.opacity(0.12),
                    style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: [10, 6], dashPhase: drift)
                )
                .onAppear {
                    withAnimation(.linear(duration: 2.2).repeatForever(autoreverses: false)) {
                        drift = -36
                    }
                }
            }

            RadialGradient(colors: [.black.opacity(0.04), .clear], center: .center, startRadius: 60, endRadius: 520)
                .ignoresSafeArea()
        }
    }
}

// --- 5. EFFECTS ---
struct Shimmer: ViewModifier {
    @State private var phase: CGFloat = -0.85
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo in
                    LinearGradient(
                        colors: [.white.opacity(0.0), .white.opacity(0.33), .white.opacity(0.0)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .rotationEffect(.degrees(18))
                    .offset(x: geo.size.width * phase)
                    .blendMode(.screen)
                    .onAppear {
                        withAnimation(.linear(duration: 1.35).repeatForever(autoreverses: false)) {
                            phase = 1.9
                        }
                    }
                }
            )
            .mask(content)
    }
}
extension View { func shimmer() -> some View { modifier(Shimmer()) } }

struct PulseRing: View {
    @State private var scale: CGFloat = 0.86
    @State private var opacity: CGFloat = 0.55

    var body: some View {
        Circle()
            .stroke(VODAFONE_RED.opacity(opacity), lineWidth: 2)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.easeOut(duration: 1.2).repeatForever(autoreverses: false)) {
                    scale = 1.48
                    opacity = 0.0
                }
            }
            .allowsHitTesting(false)
    }
}

struct FuturisticSparkles: View {
    @State private var animate = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0..<22, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.white.opacity(0.65))
                        .frame(width: CGFloat.random(in: 2...5), height: CGFloat.random(in: 2...7))
                        .blur(radius: 0.4)
                        .rotationEffect(.degrees(Double.random(in: 0...360)))
                        .position(
                            x: CGFloat.random(in: 0...geo.size.width),
                            y: animate ? CGFloat.random(in: 0...geo.size.height) : geo.size.height + 30
                        )
                        .opacity(animate ? 1 : 0)
                        .animation(
                            .easeOut(duration: Double.random(in: 1.0...2.0))
                                .repeatForever(autoreverses: true)
                                .delay(Double(i) * 0.03),
                            value: animate
                        )
                }
            }
            .onAppear { animate = true }
        }
        .allowsHitTesting(false)
    }
}

struct GlowBorder: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.25),
                                VODAFONE_RED.opacity(0.35),
                                Color.white.opacity(0.12)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.2
                    )
                    .shadow(color: VODAFONE_RED.opacity(0.18), radius: 16, y: 8)
                    .opacity(0.9)
            )
    }
}
extension View { func glowBorder() -> some View { modifier(GlowBorder()) } }

struct AIOrb: View {
    var symbol: String
    @State private var rotate = false
    @State private var pulse = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    LinearGradient(colors: [VODAFONE_RED.opacity(0.0), VODAFONE_RED.opacity(0.35), VODAFONE_RED.opacity(0.0)],
                                   startPoint: .top, endPoint: .bottom),
                    lineWidth: 2
                )
                .frame(width: 150, height: 150)
                .rotationEffect(.degrees(rotate ? 360 : 0))
                .blur(radius: 0.2)
                .onAppear {
                    withAnimation(.linear(duration: 2.4).repeatForever(autoreverses: false)) { rotate = true }
                }

            Circle()
                .fill(
                    RadialGradient(colors: [VODAFONE_RED.opacity(0.35), .clear],
                                   center: .center,
                                   startRadius: 10,
                                   endRadius: 90)
                )
                .frame(width: 160, height: 160)
                .scaleEffect(pulse ? 1.05 : 0.95)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.1).repeatForever(autoreverses: true)) { pulse = true }
                }

            Circle()
                .fill(LinearGradient(colors: [VODAFONE_RED, Color(hex: "b30000")],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .frame(width: 110, height: 110)
                .shadow(color: VODAFONE_RED.opacity(0.45), radius: 18, y: 10)

            Image(systemName: symbol)
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.15), radius: 2)
        }
        .accessibilityHidden(true)
    }
}
// --- 6. AI PROCESSING VIEW ---
struct AIProcessingView: View {
    let name: String
    @Binding var isCompleted: Bool

    @State private var stage = 0
    @State private var progress: CGFloat = 0.0
    @State private var glow: CGFloat = 0.14

    private var titleText: String {
        switch stage {
        case 0: return "Yapay zekamız PULSE sinyallerini tarıyor"
        case 1: return "PULSE, senin için en iyi teklifi eşleştiriyor"
        default: return "Hazır ✨ Teklif kilidi açıldı"
        }
    }

    private var subtitleText: String {
        switch stage {
        case 0: return "Anlık ipuçları toplanıyor…"
        case 1: return "Kişisel eşleşme hesaplanıyor…"
        default: return "Tek dokunuşla inceleyebilirsin."
        }
    }

    private var symbol: String {
        switch stage {
        case 0: return "wave.3.right"
        case 1: return "brain.head.profile"
        default: return "gift.fill"
        }
    }

    var body: some View {
        ZStack {
            CleanTechBackground()

            RadialGradient(colors: [VODAFONE_RED.opacity(glow), .clear], center: .center, startRadius: 20, endRadius: 520)
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                        glow = 0.22
                    }
                }

            VStack(spacing: 24) {
                ZStack {
                    FuturisticSparkles().opacity(stage == 2 ? 1 : 0.55)

                    VStack(spacing: 14) {
                        AIOrb(symbol: symbol)

                        VStack(spacing: 6) {
                            Text(titleText)
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundColor(.black)

                            Text(subtitleText)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 18)

                        VStack(spacing: 10) {
                            ZStack(alignment: .leading) {
                                Capsule().fill(Color.gray.opacity(0.12)).frame(width: 260, height: 10)
                                Capsule().fill(VODAFONE_RED).frame(width: 260 * progress, height: 10)
                                    .animation(.linear(duration: 1.35), value: progress)
                                    .shimmer()
                            }

                            Text("\(name.uppercased()) • PULSE AKTİF")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .tracking(1.6)
                        }
                        .padding(.top, 6)
                    }
                    .padding(.vertical, 22)
                    .padding(.horizontal, 18)
                    .background(Color.white.opacity(0.90).background(.ultraThinMaterial))
                    .cornerRadius(28)
                    .glowBorder()
                    .shadow(color: .black.opacity(0.08), radius: 20, y: 12)
                }
                .padding(.horizontal, 22)
            }
        }
        .onAppear { startSequence() }
    }

    private func startSequence() {

        // Stage 0 — WAKE
        stage = 0
        progress = 0.08
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

        // ➜ Stage 0 → Stage 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            withAnimation(.easeInOut(duration: 0.85)) {
                stage = 1
                progress = 0.52
            }

        }

        // ➜ Stage 1 → Stage 2 (burada okunuyor artık)
        DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            withAnimation(.easeInOut(duration: 0.95)) {
                stage = 2
                progress = 1.0
            }

        }

        // ➜ Final kapanış (acele etmesin)
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.6) {
            withAnimation(.easeInOut(duration: 0.35)) {
                isCompleted = true
            }
        }
    }


}

// --- 7. REVEAL VIEW ---
struct RevealView: View {
    @ObservedObject var viewModel: PulseViewModel
    @Binding var showReveal: Bool
    @State private var floaty = false

    var firstName: String {
        if let fullName = viewModel.data.name {
            return fullName.components(separatedBy: " ").first ?? fullName
        }
        return "Müşteri"
    }

    var body: some View {
        ZStack {
            CleanTechBackground()

            FuturisticSparkles()
                .mask(LinearGradient(colors: [.black, .black, .clear], startPoint: .top, endPoint: .bottom))
                .opacity(0.85)

            RadialGradient(colors: [VODAFONE_RED.opacity(0.18), .clear],
                           center: .top,
                           startRadius: 10,
                           endRadius: 520)
            .ignoresSafeArea()
            .opacity(floaty ? 1 : 0.85)
            .offset(y: floaty ? -10 : 10)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) { floaty = true }
            }

            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
                            showReveal = false
                        }
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 6)
                    }
                }
                .padding(.top, 50)
                .padding(.horizontal)

                Spacer(minLength: 12)

                ZStack {
                    AIOrb(symbol: "sparkles")
                    PulseRing().frame(width: 190, height: 190).opacity(0.75)
                    PulseRing().frame(width: 240, height: 240).opacity(0.45)
                }
                .frame(height: 210)

                Spacer(minLength: 8)

                VStack(spacing: 0) {
                    Text("Selam \(firstName)! 👋")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(VODAFONE_RED)
                        .padding(.top, 26)

                    Text("Yapay zekamız PULSE senin için bir fırsat yakaladı.")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(hex: "333333"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .padding(.top, 8)

                    Text(viewModel.data.marketing_content ?? "PULSE senin için bir fırsat yakaladı. Tek dokunuşla incele.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hex: "333333"))
                        .lineSpacing(5)
                        .padding(.horizontal, 25)
                        .padding(.top, 14)
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer(minLength: 16)

                    Divider().padding(.horizontal, 40).opacity(0.5)

                    VStack(spacing: 10) {
                        Text("✨ KİŞİSEL TEKLİFİN")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .tracking(1.5)
                            .padding(.top, 18)

                        Text(viewModel.data.suggested_product ?? "...")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)

                        Button(action: { UIImpactFeedbackGenerator(style: .medium).impactOccurred() }) {
                            HStack(spacing: 10) {
                                Text("Teklifi İncele")
                                Image(systemName: "arrow.right")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(colors: [VODAFONE_RED, Color(hex: "b30000")],
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            )
                            .cornerRadius(14)
                            .shadow(color: VODAFONE_RED.opacity(0.45), radius: 10, y: 5)
                            .shimmer()
                        }
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom, 28)
                }
                .background(Color.white.opacity(0.86).background(.ultraThinMaterial))
                .cornerRadius(30)
                .glowBorder()
                .shadow(color: .black.opacity(0.06), radius: 24, y: 12)
                .padding(.horizontal, 20)
                .padding(.bottom, 120)
            }
        }
    }
}

// --- 8. STORIES ---
struct StoryItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String?
    let icon: String
    let gradient: [Color]
    let badgeText: String?
    let showStar: Bool
}

struct StoryBubble: View {
    let item: StoryItem

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle().stroke(VODAFONE_RED, lineWidth: 3).frame(width: 66, height: 66)

                Circle()
                    .fill(LinearGradient(colors: item.gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 58, height: 58)
                    .overlay(Circle().stroke(Color.white.opacity(0.75), lineWidth: 1))
                    .shadow(color: .black.opacity(0.10), radius: 6, y: 3)

                Image(systemName: item.icon)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.18), radius: 2)

                if let badge = item.badgeText {
                    Text(badge)
                        .font(.system(size: 9, weight: .heavy))
                        .foregroundColor(.white)
                        .padding(.vertical, 3)
                        .padding(.horizontal, 6)
                        .background(VODAFONE_RED)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.white.opacity(0.6), lineWidth: 1))
                        .offset(x: 20, y: -22)
                }

                if item.showStar {
                    Image(systemName: "star.circle.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.yellow)
                        .background(Color.white.clipShape(Circle()))
                        .offset(x: 18, y: 22)
                        .shadow(color: .black.opacity(0.12), radius: 4, y: 2)
                }
            }

            VStack(spacing: 2) {
                Text(item.title)
                    .font(.system(size: 11.5, weight: .semibold))
                    .foregroundColor(Color(hex: "333333"))
                    .lineLimit(1)

                if let sub = item.subtitle {
                    Text(sub)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }
        }
        .frame(width: 82)
    }
}
// ===========================
//  MAGIC FLOW (3 STAGE)
// ===========================

enum PulseStage: Int {
    case wake = 0
    case match = 1
    case reveal = 2
}

struct PulseMagicFlowView: View {
    let data: PulseData
    @Binding var isPresented: Bool

    @State private var stage: PulseStage = .wake
    @State private var energy: CGFloat = 0.10
    @State private var glow: CGFloat = 0.10

    // chip animasyonu
    @State private var showChips: [Bool] = Array(repeating: false, count: 4)

    // content expand
    @State private var expandText = false

    private var firstName: String {
        (data.name?.components(separatedBy: " ").first ?? "Müşteri")
    }

    private var facts: [String] {
        let raw = data.ai_reasoning?.customer_facts_used ?? []
        let cleaned = raw.map { compactFact($0) }.filter { !$0.isEmpty }
        return Array(cleaned.prefix(4))
    }

    private var stageTitle: String {
        switch stage {
        case .wake: return "Pulse düşünüyor… ✨"
        case .match: return "Sinyaller eşleşiyor…"
        case .reveal: return "Sana özel fırsat hazır!"
        }
    }

    private var stageSubtitle: String {
        switch stage {
        case .wake: return "Anlık sinyaller yakalanıyor"
        case .match: return "Gündem,katalog ve alışkanlıklar birleştiriliyor"
        case .reveal: return "Tek dokunuşla inceleyebilirsin"
        }
    }

    var body: some View {
        ZStack {
            // Background
            MagicBackground(glow: glow)

            VStack(spacing: 18) {
                // Top bar
                HStack {
                    Text("✨ PULSE aktif")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white.opacity(0.90))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.black.opacity(0.22))
                        .cornerRadius(18)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.white.opacity(0.12), lineWidth: 1)
                        )

                    Spacer()

                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
                            isPresented = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white.opacity(0.85))
                            .padding(10)
                            .background(Color.white.opacity(0.14))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 18)
                .padding(.top, 18)

                Spacer(minLength: 6)

                // Center Orb Area
                ZStack {
                    MagicParticles()
                        .opacity(stage == .wake ? 0.55 : (stage == .match ? 0.75 : 1.0))

                    MagicOrbCore(stage: stage)
                        .frame(height: 240)

                    // Energy line (stage 1-2)
                    if stage != .wake {
                        EnergyLine(progress: energy)
                            .frame(height: 10)
                            .padding(.top, 250)
                            .padding(.horizontal, 36)
                            .transition(.opacity)
                    }
                }
                .frame(height: 260)

                // Titles
                VStack(spacing: 6) {
                    Text(stageTitle)
                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    Text(stageSubtitle)
                        .font(.system(size: 13.5, weight: .semibold, design: .rounded))
                        .foregroundColor(.white.opacity(0.80))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 22)

                // Match chips
                if stage == .match {
                    VStack(spacing: 10) {
                        Text("Sana özel ipuçları")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white.opacity(0.75))
                            .tracking(1.2)

                        WrapChips(
                            items: decoratedFacts(facts),
                            show: $showChips
                        )
                        .padding(.horizontal, 20)
                    }
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }

                // Reveal Card
                if stage == .reveal {
                    PulseOfferCardView(
                        firstName: firstName,
                        headline: data.marketing_headline ?? "Bu akşam için sana özel fırsat",
                        content: data.marketing_content ?? "PULSE senin için bir fırsat yakaladı.",
                        product: data.suggested_product ?? "—",
                        expandText: $expandText
                    )
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .padding(.horizontal, 18)
                }

                Spacer(minLength: 10)
            }
        }
        .ignoresSafeArea()
        .onAppear { startSequence() }
    }

    private func startSequence() {
        // background glow breathe
        withAnimation(.easeInOut(duration: 1.1).repeatForever(autoreverses: true)) {
            glow = 0.22
        }

        // Stage 0 (Wake) — biraz daha uzun kalsın
        stage = .wake
        energy = 0.12
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

        // ➜ Wake → Match (1.0s yerine 2.2s)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            withAnimation(.easeInOut(duration: 0.85)) {
                stage = .match
                energy = 0.64
            }
            animateChips()
        }

        // ➜ Match → Reveal (2.6s yerine 7.6s)
        // yani MATCH ekranda ~5.4 saniye kalacak (okunur)
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            withAnimation(.easeInOut(duration: 0.95)) {
                stage = .reveal
                energy = 1.0
            }
        }
    }

    private func animateChips() {
        showChips = Array(repeating: false, count: 4)

        let count = min(4, decoratedFacts(facts).count)
        for i in 0..<count {
            // 0.15 yerine 0.35: göz takip edebilsin
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15 * Double(i)) {
                withAnimation(.spring(response: 0.55, dampingFraction: 0.88)) {
                    showChips[i] = true
                }
            }
        }
    }


    private func decoratedFacts(_ facts: [String]) -> [String] {
        // max 4, emoji ekle
        let picked = Array(facts.prefix(4))
        var result: [String] = []
        for (idx, f) in picked.enumerated() {
            switch idx {
            case 0: result.append("🏟️ \(f)")
            case 1: result.append("📱 \(f)")
            case 2: result.append("📶\(f)")
            default: result.append("✨ \(f)")
            }
        }
        if result.isEmpty {
            result = ["🎬 Video eğilimi", "🌧️ Yağışlı hava", "✨ Hafta sonu"]
        }
        return result
    }

    private func compactFact(_ s: String) -> String {
        var t = s.trimmingCharacters(in: .whitespacesAndNewlines)

        // isim/özel ekleri kırp
        t = t.replacingOccurrences(of: "Merve’nin ", with: "")
        t = t.replacingOccurrences(of: "Merve'nin ", with: "")

        // yaygın kelime sadeleştirmeleri
        t = t.replacingOccurrences(of: " üyeliği", with: "")
        t = t.replacingOccurrences(of: " eğilimi", with: "")
        t = t.replacingOccurrences(of: " ihtimali", with: "")
        t = t.replacingOccurrences(of: " miktarı", with: "")

        // çok uzunsa kırp
        if t.count > 28 { t = String(t.prefix(28)) + "…" }
        return t
    }
}

// ===========================
//  MAGIC BACKGROUND
// ===========================

struct MagicBackground: View {
    let glow: CGFloat

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "2a0000"), Color(hex: "7a0000"), VODAFONE_RED],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // soft vignette
            RadialGradient(
                colors: [Color.black.opacity(0.55), Color.clear],
                center: .center,
                startRadius: 60,
                endRadius: 520
            )
            .ignoresSafeArea()

            // glow pulse
            RadialGradient(
                colors: [Color.white.opacity(glow * 0.55), Color.clear],
                center: .center,
                startRadius: 40,
                endRadius: 460
            )
            .ignoresSafeArea()
            .blendMode(.screen)
        }
    }
}

// ===========================
//  ORB CORE
// ===========================

struct MagicOrbCore: View {
    let stage: PulseStage
    @State private var rotate = false
    @State private var breathe = false

    private var symbol: String {
        switch stage {
        case .wake: return "sparkles"
        case .match: return "wand.and.stars"
        case .reveal: return "gift.fill"
        }
    }

    var body: some View {
        ZStack {
            // outer rotating ring
            Circle()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.0),
                            Color.white.opacity(0.35),
                            Color.white.opacity(0.0)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 2
                )
                .frame(width: 210, height: 210)
                .rotationEffect(.degrees(rotate ? 360 : 0))
                .blur(radius: 0.3)
                .opacity(stage == .reveal ? 0.55 : 0.40)
                .onAppear {
                    withAnimation(.linear(duration: 2.4).repeatForever(autoreverses: false)) {
                        rotate = true
                    }
                }

            // glow aura
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.white.opacity(0.22), Color.clear],
                        center: .center,
                        startRadius: 10,
                        endRadius: 120
                    )
                )
                .frame(width: 260, height: 260)
                .opacity(stage == .wake ? 0.30 : 0.40)
                .blendMode(.screen)

            // orb body
            Circle()
                .fill(
                    LinearGradient(
                        colors: [VODAFONE_RED, Color(hex: "b30000")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 140, height: 140)
                .shadow(color: Color.black.opacity(0.35), radius: 22, y: 14)
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.18), lineWidth: 1)
                )
                .scaleEffect(breathe ? 1.04 : 0.96)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.15).repeatForever(autoreverses: true)) {
                        breathe = true
                    }
                }

            // inner highlight
            Circle()
                .fill(Color.white.opacity(0.10))
                .frame(width: 54, height: 54)
                .offset(x: -26, y: -32)
                .blur(radius: 1.0)

            Image(systemName: symbol)
                .font(.system(size: 34, weight: .heavy))
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.22), radius: 3, y: 2)
        }
        .accessibilityHidden(true)
    }
}

// ===========================
//  PARTICLES
// ===========================

struct MagicParticles: View {
    @State private var animate = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0..<16, id: \.self) { i in
                    Circle()
                        .fill(Color.white.opacity(0.65))
                        .frame(width: CGFloat.random(in: 2...5), height: CGFloat.random(in: 2...5))
                        .blur(radius: 0.4)
                        .position(
                            x: CGFloat.random(in: 0...geo.size.width),
                            y: animate ? CGFloat.random(in: 0...geo.size.height) : geo.size.height + 30
                        )
                        .opacity(animate ? 1 : 0)
                        .animation(
                            .easeInOut(duration: Double.random(in: 1.2...2.4))
                                .repeatForever(autoreverses: true)
                                .delay(Double(i) * 0.05),
                            value: animate
                        )
                }
            }
            .onAppear { animate = true }
        }
        .allowsHitTesting(false)
    }
}

// ===========================
//  ENERGY LINE
// ===========================

struct EnergyLine: View {
    let progress: CGFloat
    @State private var shimmerPhase: CGFloat = -0.7

    var body: some View {
        ZStack(alignment: .leading) {
            Capsule().fill(Color.white.opacity(0.16))

            Capsule()
                .fill(Color.white.opacity(0.80))
                .frame(maxWidth: .infinity)
                .mask(
                    GeometryReader { geo in
                        Rectangle()
                            .frame(width: max(18, geo.size.width * progress))
                    }
                )
                .overlay(
                    GeometryReader { geo in
                        LinearGradient(
                            colors: [Color.white.opacity(0.0), Color.white.opacity(0.55), Color.white.opacity(0.0)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .rotationEffect(.degrees(18))
                        .offset(x: geo.size.width * shimmerPhase)
                        .blendMode(.screen)
                        .onAppear {
                            withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                                shimmerPhase = 1.9
                            }
                        }
                    }
                )
                .clipShape(Capsule())
        }
        .frame(height: 10)
        .padding(.horizontal, 12)
        .opacity(0.95)
    }
}

// ===========================
//  WRAP CHIPS (flow layout)
// ===========================

struct WrapChips: View {
    let items: [String]
    @Binding var show: [Bool]

    var body: some View {
        GeometryReader { geo in
            self.generateContent(in: geo)
        }
        .frame(height: 92)
    }

    private func generateContent(in geo: GeometryProxy) -> some View {
        var width: CGFloat = 0
        var height: CGFloat = 0

        return ZStack(alignment: .topLeading) {
            ForEach(items.indices, id: \.self) { idx in
                Chip(text: items[idx])
                    .opacity(show.indices.contains(idx) ? (show[idx] ? 1 : 0) : 1)
                    .offset(x: width, y: height)
                    .alignmentGuide(.leading) { d in
                        if (abs(width - d.width) > geo.size.width) {
                            width = 0
                            height -= d.height + 10
                        }
                        let result = width
                        width -= d.width + 10
                        return result
                    }
                    .alignmentGuide(.top) { _ in
                        let result = height
                        return result
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct Chip: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding(.vertical, 9)
            .padding(.horizontal, 12)
            .background(Color.white.opacity(0.14))
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
            )
    }
}

// ===========================
//  REVEAL CARD
// ===========================

struct PulseOfferCardView: View {
    let firstName: String
    let headline: String
    let content: String
    let product: String

    @Binding var expandText: Bool

    private var trimmedContent: String {
        // çok uzunsa 220 karakterde kırp (UX için)
        if content.count <= 220 { return content }
        return String(content.prefix(220)) + "…"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Text("✨")
                Text("PULSE AI ÖNERİSİ")
                    .font(.system(size: 11, weight: .bold))
                    .tracking(1.1)
            }
            .foregroundColor(.white.opacity(0.85))

            Text("Selam \(firstName)! 👋")
                .font(.system(size: 18, weight: .heavy, design: .rounded))
                .foregroundColor(.white)

            Text(headline)
                .font(.system(size: 20, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(2)

            Text(expandText ? content : trimmedContent)
                .font(.system(size: 14.5, weight: .semibold))
                .foregroundColor(.white.opacity(0.88))
                .lineSpacing(4)

            if content.count > 220 {
                Button {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    withAnimation(.easeInOut(duration: 0.2)) { expandText.toggle() }
                } label: {
                    Text(expandText ? "Daha az göster" : "Devamını oku")
                        .font(.system(size: 12.5, weight: .bold))
                        .foregroundColor(.white.opacity(0.90))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.white.opacity(0.14))
                        .cornerRadius(14)
                }
                .buttonStyle(.plain)
                .padding(.top, 2)
            }

            Divider().overlay(Color.white.opacity(0.18))

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("✨ Kişisel teklifin")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white.opacity(0.75))
                        .tracking(1.2)

                    Text(product)
                        .font(.system(size: 16, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .lineLimit(1)
                }

                Spacer()

                // TEK CTA
                Button {
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                    // demo: burada detay sayfasına gidebilirsin
                } label: {
                    HStack(spacing: 8) {
                        Text("Hemen Al!")
                    }
                    .font(.system(size: 13.5, weight: .heavy))
                    .foregroundColor(VODAFONE_RED)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 14)
                    .background(Color.white)
                    .cornerRadius(18)
                    .shadow(color: Color.black.opacity(0.25), radius: 10, y: 6)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.10))
        .background(.ultraThinMaterial)
        .cornerRadius(22)
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.white.opacity(0.12), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.28), radius: 18, y: 12)
    }
}


// --- 9. SHORTCUT GRID ---
struct ShortcutItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}

struct ShortcutGrid: View {
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 12), count: 4)

    private let items: [ShortcutItem] = [
        .init(title: "Ayrıcalıklı\nAlışveriş", icon: "bag.fill"),
        .init(title: "Vodafone\nPay", icon: "creditcard.fill"),
        .init(title: "Happy", icon: "face.smiling.fill"),
        .init(title: "Flex Cihaz\nDünyası", icon: "headphones"),
        .init(title: "Hazır\nmısınız?", icon: "bolt.fill"),
        .init(title: "Ev İnterneti\nBaşvuru", icon: "house.fill"),
        .init(title: "Bana Ne Var", icon: "shippingbox.fill"),
        .init(title: "Tüm\nKategoriler", icon: "ellipsis")
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(items) { item in
                Button(action: { UIImpactFeedbackGenerator(style: .light).impactOccurred() }) {
                    VStack(spacing: 10) {
                        Image(systemName: item.icon)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(VODAFONE_RED)
                            .frame(height: 26)

                        Text(item.title)
                            .font(.system(size: 11.5, weight: .semibold))
                            .foregroundColor(Color(hex: "333333"))
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .minimumScaleFactor(0.85)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 92)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 6, y: 4)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 20)
    }
}

// --- 10. INTERNET BANNER ---
struct DomesticInternetBanner: View {
    let remainingGB: Double
    let totalGB: Double
    let subtitle: String

    private var progress: CGFloat {
        guard totalGB > 0 else { return 0 }
        return CGFloat(min(max(remainingGB / totalGB, 0), 1))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                HStack(spacing: 10) {
                    Image(systemName: "arrow.up.arrow.down.circle.fill")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(hex: "444444"))
                    Text("Yurt İçi İnternet")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(hex: "333333"))
                }

                Spacer()

                Text("\(Int(totalGB))GB")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.gray)
            }

            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Text(String(format: "%.2f", remainingGB).replacingOccurrences(of: ".", with: ","))
                    .font(.system(size: 34, weight: .heavy, design: .rounded))
                    .foregroundColor(Color(hex: "111111"))
                Text("GB kaldı")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.gray)
                Spacer()
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.gray.opacity(0.14)).frame(height: 8)
                    Capsule().fill(VODAFONE_RED).frame(width: max(8, geo.size.width * progress), height: 8)
                }
            }
            .frame(height: 8)

            HStack(spacing: 10) {
                Text(subtitle)
                    .font(.system(size: 12.5, weight: .semibold))
                    .foregroundColor(Color(hex: "333333"))
                    .lineLimit(2)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)

                Spacer()

                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(10)
            }
            .background(Color.white)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(VODAFONE_RED.opacity(0.18), lineWidth: 1))
        }
        .padding(18)
        .background(Color.white)
        .cornerRadius(22)
        .shadow(color: .black.opacity(0.06), radius: 10, y: 6)
        .padding(.horizontal, 20)
    }
}

// --- 11. BOTTOM NAV ---
enum BottomTab: String, CaseIterable {
    case home = "Ana Sayfa"
    case discover = "Keşfet"
    case pulse = "Tobi"
    case account = "Hesabım"

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .discover: return "square.grid.2x2.fill"
        case .pulse: return "face.smiling.fill"
        case .account: return "person.fill"
        }
    }
}

struct BottomNavBar: View {
    @Binding var selected: BottomTab
    @Binding var showMagicFlow: Bool

    var body: some View {
        VStack(spacing: 0) {
            Divider().opacity(0.15)

            HStack {
                tabButton(.home)
                tabButton(.discover)

                // Center Tobi (fixed, not floating)
                Button(action: {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    selected = .pulse
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.72)) {
                        showMagicFlow = true
                    }

                }) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 54, height: 54)
                            .shadow(color: .black.opacity(0.12), radius: 10, y: 6)

                        ZStack {
                            Circle()
                                .fill(VODAFONE_RED.opacity(0.10))
                                .frame(width: 46, height: 46)

                            Image(systemName: "face.smiling.fill")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(VODAFONE_RED)
                        }
                    }
                }
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity)

                tabButton(.account)
                tabButton(.discover)
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
            .padding(.bottom, 16)
            .background(Color.white.opacity(0.98))
        }
        .frame(maxWidth: .infinity)
    }

    private func tabButton(_ tab: BottomTab) -> some View {
        Button(action: {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            selected = tab
        }) {
            VStack(spacing: 5) {
                Image(systemName: tab.icon)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(selected == tab ? VODAFONE_RED : .gray)

                Text(tab.rawValue)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(selected == tab ? VODAFONE_RED : .gray)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}
// --- 12. HOME VIEW ---
struct HomeView: View {
    @ObservedObject var viewModel: PulseViewModel
    @Binding var showMagicFlow: Bool
    @State private var selectedTab: BottomTab = .home

    var firstName: String {
        if let fullName = viewModel.data.name {
            return fullName.components(separatedBy: " ").first?.uppercased() ?? "MİSAFİR"
        }
        return "MİSAFİR"
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(UIColor.systemGroupedBackground).ignoresSafeArea()

            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Circle()
                        .fill(VODAFONE_RED)
                        .frame(width: 36, height: 36)
                        .overlay(Image(systemName: "sparkles").font(.system(size: 18, weight: .bold)).foregroundColor(.white))

                    Text("İyi Geceler, \(firstName)")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(hex: "333333"))
                        .padding(.leading, 5)

                    Spacer()

                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 22))
                        .foregroundColor(.gray)
                }
                .padding(15)
                .background(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 5, y: 5)

                ScrollView {
                    VStack(spacing: 18) {

                        // Story bubbles
                        let stories: [StoryItem] = [
                            .init(title: "Pulse", subtitle: "Bugün", icon: "sparkles",
                                  gradient: [VODAFONE_RED, Color(hex: "b30000")],
                                  badgeText: "AI", showStar: true),
                            .init(title: "Günün", subtitle: "Fırsatı", icon: "gift.fill",
                                  gradient: [Color(hex: "ff4d4d"), VODAFONE_RED],
                                  badgeText: "NEW", showStar: false),
                            .init(title: "10 GB", subtitle: "Hediye", icon: "antenna.radiowaves.left.and.right",
                                  gradient: [Color(hex: "6a00ff"), Color(hex: "b517ff")],
                                  badgeText: "10GB", showStar: true),
                            .init(title: "Flex", subtitle: "Cihaz", icon: "headphones",
                                  gradient: [Color(hex: "ff7a00"), Color(hex: "ff3d00")],
                                  badgeText: nil, showStar: true),
                            .init(title: "Happy", subtitle: "Kazan", icon: "face.smiling.fill",
                                  gradient: [Color(hex: "00c2ff"), Color(hex: "007aff")],
                                  badgeText: nil, showStar: false),
                            .init(title: "Oyun", subtitle: "Eğlence", icon: "gamecontroller.fill",
                                  gradient: [Color(hex: "111111"), Color(hex: "5a2cff")],
                                  badgeText: nil, showStar: false)
                        ]

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(stories) { item in
                                    Button(action: { UIImpactFeedbackGenerator(style: .light).impactOccurred() }) {
                                        StoryBubble(item: item)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.top, 14)

                        // PULSE RED BANNER (API-driven text, rozet+CTA fixed)
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.72)) {
                                showMagicFlow = true
                            }

                        }) {
                            ZStack(alignment: .leading) {
                                LinearGradient(colors: [VODAFONE_RED, Color(hex: "990000")],
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing)

                                PulseRing()
                                    .frame(width: 180, height: 180)
                                    .offset(x: 210, y: -55)
                                    .blendMode(.screen)
                                    .opacity(0.70)

                                VStack(alignment: .leading, spacing: 10) {

                                    // Rozet (fixed)
                                    HStack(spacing: 8) {
                                        Text("✨")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.white)

                                        Text("PULSE AI ÖNERİSİ")
                                            .font(.system(size: 10.8, weight: .bold))
                                            .tracking(1.1)
                                            .foregroundColor(.white)
                                    }
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .background(Color.black.opacity(0.24))
                                    .cornerRadius(18)
                                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.white.opacity(0.18), lineWidth: 1))

                                    // Headline (API)
                                    Text(viewModel.data.marketing_headline ?? "Bu akşam için yakalanan sana özel fırsat")
                                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                        .shadow(color: .black.opacity(0.22), radius: 2)

                                    // Reason line (API from customer_facts_used -> 3 items -> emojis)
                                    Text(reasonLine(from: viewModel.data.ai_reasoning?.customer_facts_used))
                                        .font(.system(size: 12.5, weight: .semibold, design: .rounded))
                                        .foregroundColor(.white.opacity(0.88))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.80)

                                    // CTA (fixed)
                                    HStack {
                                        Spacer()
                                        HStack(spacing: 8) {
                                            Text("Pulse ne öneriyor?")
                                                .font(.system(size: 12.8, weight: .bold))
                                            Image(systemName: "arrow.right")
                                                .font(.system(size: 12, weight: .bold))
                                        }
                                        .foregroundColor(VODAFONE_RED)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 16)
                                        .background(Color.white)
                                        .cornerRadius(22)
                                        .shadow(color: .black.opacity(0.22), radius: 7, y: 3)
                                        .shimmer()
                                    }
                                }
                                .padding(18)
                            }
                            .frame(minHeight: 150)
                            .cornerRadius(22)
                            .shadow(color: VODAFONE_RED.opacity(0.36), radius: 10, y: 6)
                            .padding(.horizontal, 20)
                        }

                        // Grid
                        ShortcutGrid()

                        // Internet banner
                        DomesticInternetBanner(
                            remainingGB: 34.20,
                            totalGB: 40,
                            subtitle: "Happy’de yeni yıla özel Anında Kazan devam ediyor. Hala sürpriz hediyeni almadıysan hemen tıklayın!"
                        )
                        .padding(.top, 6)
                    }
                    .padding(.bottom, 110)
                }
            }

            BottomNavBar(selected: $selectedTab, showMagicFlow: $showMagicFlow)
                .ignoresSafeArea(edges: .bottom)
        }
    }

    // --- Banner reason helpers ---
    private func reasonLine(from facts: [String]?) -> String {
        guard let facts, !facts.isEmpty else {
            return "🎬 Video + sosyal • 🌧️ yağışlı hava • 🗓️ hafta sonu"
        }

        let picked = Array(facts.prefix(3)).map { cleanFact($0) }
        let withEmoji: [String] = picked.enumerated().map { idx, text in
            switch idx {
            case 0: return "📅 \(text)"
            case 1: return "✈️  \(text)"
            default: return "🧳  \(text)"
            }
        }
        return withEmoji.joined(separator: " • ")
    }

    private func cleanFact(_ s: String) -> String {
        var t = s
            .replacingOccurrences(of: "Merve’nin ", with: "")
            .replacingOccurrences(of: "Merve'nin ", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        if t.count > 34 { t = String(t.prefix(34)) + "…" }
        return t
    }
}

// --- 13. MAIN CONTENT ---
struct ContentView: View {
    @StateObject var viewModel = PulseViewModel()
    @State private var showMagicFlow = false


    var body: some View {
        ZStack {
            HomeView(viewModel: viewModel, showMagicFlow: $showMagicFlow)

            if showMagicFlow {
                PulseMagicFlowView(data: viewModel.data, isPresented: $showMagicFlow)
                    .transition(.opacity)
                    .zIndex(50)
            }
        }
        .onAppear { viewModel.fetchData() }
    }

}

// --- 14. HEX HELPER ---
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View { ContentView() }
}

