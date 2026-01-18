import SwiftUI
import Combine
import UIKit

// --- 1. CONFIG ---
let API_URL = "http://localhost:8000/api/sales-opportunities/1"
let VODAFONE_RED = Color(red: 230/255, green: 0, blue: 0)

// --- 2. MODELS ---
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
    @Published var data: PulseData = PulseData.dummy
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
                                    .animation(.linear(duration: 0.45), value: progress)
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
        stage = 0
        progress = 0.12

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.15) {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            withAnimation(.spring(response: 0.55, dampingFraction: 0.82)) {
                stage = 1
                progress = 0.66
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.75) {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            withAnimation(.spring(response: 0.55, dampingFraction: 0.78)) {
                stage = 2
                progress = 1.0
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.6) {
            withAnimation(.easeInOut(duration: 0.25)) {
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
    @Binding var showProcessing: Bool

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
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                        showProcessing = true
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
    @Binding var showProcessing: Bool
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
                                showProcessing = true
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

            BottomNavBar(selected: $selectedTab, showProcessing: $showProcessing)
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
            case 0: return "🎬 \(text)"
            case 1: return "🌧️ \(text)"
            default: return "🗓️ \(text)"
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
    @State private var showProcessing = false
    @State private var showReveal = false 

    var body: some View {
        ZStack {
            HomeView(viewModel: viewModel, showProcessing: $showProcessing)

            if showProcessing {
                AIProcessingView(
                    name: viewModel.data.name?.components(separatedBy: " ").first ?? "MİSAFİR",
                    isCompleted: Binding(
                        get: { showReveal },
                        set: { if $0 { showProcessing = false; showReveal = true } }
                    )
                )
                .transition(.opacity)
                .zIndex(2)
            }

            if showReveal {
                RevealView(viewModel: viewModel, showReveal: $showReveal)
                    .transition(.move(edge: .bottom))
                    .zIndex(3)
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

