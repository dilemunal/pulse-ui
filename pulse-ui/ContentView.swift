
import SwiftUI
import Combine
import UIKit

// --- 1. CONFIG ---
let API_URL = "http://localhost:8000/api/sales-opportunities/1"
let VODAFONE_RED = Color(red: 230/255, green: 0, blue: 0)

// --- 2. MODELS ---
struct PulseData: Codable {
    let name: String?
    let persona_label: String?
    let marketing_headline: String?
    let marketing_content: String?
    let suggested_product: String?

    static let dummy = PulseData(
        name: "Merve Kaya",
        persona_label: "Trabzonlu Dijital Gezgin",
        marketing_headline: "Yağmur Modu Açıldı: Evde Keyif + Ekstra GB",
        marketing_content: "İstanbul’da yağışlı ve soğuk bir gün… PULSE senin için tam şu an bir fırsat yakaladı. Tek dokunuşla incele.",
        suggested_product: "Günlük Video Pass"
    )
}

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

// --- 3. BACKGROUND ---
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

// --- 4. EFFECTS ---
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

/// More futuristic sparkles (tiny + soft) – looks less “emoji”
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
    @State private var t: CGFloat = 0
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

/// Reusable “AI Orb” (instead of emojis)
struct AIOrb: View {
    var symbol: String
    @State private var rotate = false
    @State private var pulse = false

    var body: some View {
        ZStack {
            // rotating halo
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

            // inner glow
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

            // core
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

// --- 5. AI PROCESSING VIEW (FUTURISTIC, NO EMOJIS) ---
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

                        // Progress
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

// --- 6. REVEAL VIEW (FULL TEXT INSTANT + MORE SPARKLY/FUTURISTIC) ---
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

            // More “sihirli” sparkles near top
            FuturisticSparkles()
                .mask(
                    LinearGradient(colors: [.black, .black, .clear], startPoint: .top, endPoint: .bottom)
                )
                .opacity(0.85)

            // Subtle floating glow
            RadialGradient(colors: [VODAFONE_RED.opacity(0.18), .clear],
                           center: .top,
                           startRadius: 10,
                           endRadius: 520)
            .ignoresSafeArea()
            .opacity(floaty ? 1 : 0.85)
            .offset(y: floaty ? -10 : 10)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                    floaty = true
                }
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

                // Orb header
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

                    // FULL TEXT INSTANT (no typewriter)
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

                        Button(action: {
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            // TODO: activation
                        }) {
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
                .padding(.bottom, 40)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}

// --- 7. HOME VIEW (BANNER SMALLER + SINGLE CTA TEXT + "Yapay zekamız PULSE" copy) ---
struct HomeView: View {
    @ObservedObject var viewModel: PulseViewModel
    @Binding var showProcessing: Bool

    var firstName: String {
        if let fullName = viewModel.data.name {
            return fullName.components(separatedBy: " ").first?.uppercased() ?? "MİSAFİR"
        }
        return "MİSAFİR"
    }

    var body: some View {
        ZStack {
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
                        // Story circles
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(0..<5, id: \.self) { _ in
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 62, height: 62)
                                        .overlay(Circle().stroke(VODAFONE_RED, lineWidth: 2.5))
                                        .shadow(radius: 1)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.top, 14)

                        // Smaller banner
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

                                // smaller rings
                                PulseRing()
                                    .frame(width: 180, height: 180)
                                    .offset(x: 210, y: -55)
                                    .blendMode(.screen)
                                    .opacity(0.70)

                                VStack(alignment: .leading, spacing: 10) {

                                    // Badge (now explicitly "Yapay zekamız PULSE")
                                    HStack(spacing: 8) {
                                        Image(systemName: "sparkles")
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(.white.opacity(0.95))

                                        Text("YAPAY ZEKÂMIZ PULSE • SANA ÖZEL")
                                            .font(.system(size: 10.5, weight: .bold))
                                            .tracking(1.0)
                                            .foregroundColor(.white)
                                    }
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .background(Color.black.opacity(0.24))
                                    .cornerRadius(18)
                                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.white.opacity(0.18), lineWidth: 1))

                                    // Headline (smaller)
                                    Text(viewModel.data.marketing_headline ?? "PULSE senin için bir fırsat yakaladı")
                                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                        .shadow(color: .black.opacity(0.22), radius: 2)

                                    // Single CTA text (no “Hem kilidi aç hem teklifi gör”)
                                    HStack {
                                        Spacer()
                                        HStack(spacing: 8) {
                                            Text("TEKLİFİ İNCELE")
                                                .font(.system(size: 12.5, weight: .bold))
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
                            .frame(minHeight: 150) // smaller banner height
                            .cornerRadius(22)
                            .shadow(color: VODAFONE_RED.opacity(0.36), radius: 10, y: 6)
                            .padding(.horizontal, 20)
                        }

                        // Placeholder grid
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            ForEach(0..<4, id: \.self) { _ in
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(height: 96)
                                    .cornerRadius(16)
                                    .shadow(color: .black.opacity(0.03), radius: 4, y: 2)
                            }
                        }
                        .padding(.horizontal, 20)
                        .opacity(0.7)
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

// --- 8. MAIN CONTENT ---
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

// --- 9. HEX HELPER ---
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


