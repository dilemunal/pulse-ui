

# 📱 Vodafone Pulse UI - iOS Demo App

**Pulse UI**, Vodafone Pulse Contextual Sales AI motorunun müşteri tarafındaki yüzüdür. **SwiftUI** ile geliştirilen bu iOS uygulaması, arka planda çalışan karmaşık yapay zeka süreçlerini (Trend analizi, Persona eşleşmesi, RAG) müşteriye **basit, akıcı ve "sihirli"** bir deneyim olarak sunar.

Bu proje, bir CRM panelinden ziyade, son kullanıcının (Vodafone müşterisinin) **"Yanımda"** uygulaması içinde yaşayacağı hiper-kişiselleştirilmiş deneyimi simüle eder.

## ✨ Özellikler ve Deneyim

Uygulama, standart bir telekom uygulamasından farklı olarak **"Pulse Magic Flow"** adı verilen özel bir akışa sahiptir:

1. **Smart Dashboard:** Müşteriyi ismiyle karşılayan, dinamik hikayeler (Stories) ve kişiselleştirilmiş kısayollar sunan ana Yanımda ekranı.
2. **3 Aşamalı AI Görselleştirme (Magic Flow):**
* **Wake (Uyanış):** AI'ın dış dünyadaki sinyalleri (hava durumu, haberler) taradığını gösterir.
* **Match (Eşleşme):** Müşterinin alışkanlıkları ile dış sinyallerin eşleştiği anı görselleştirir (Örn: "🏟️ Derbi Günü" + "📱 Sosyal Medya Tutkunu").
* **Reveal (Teklif):** Müşteriye özel üretilen, samimi satış metnini ve ürünü sunar.



## 🛠️ Teknik Gereksinimler

* **IDE:** Xcode 15.0+
* **Dil:** Swift 5.0+
* **Minimum iOS Sürümü:** iOS 16.0+
* **Bağımlılık:** `pulse-hackaton` (Backend) projesinin çalışıyor olması gerekir.

## 🚀 Kurulum ve Çalıştırma

### 1. Backend'i Başlatın

Bu uygulama verileri `pulse-hackaton` projesinden çeker. Öncelikle backend servisinin (Docker veya Python) çalıştığından ve API'nin yanıt verdiğinden emin olun.

* Beklenen API: `http://localhost:8000/api/sales-opportunities/{id}`

### 2. Projeyi Açın

`pulse-ui.xcodeproj` dosyasını Xcode ile açın.

### 3. API Bağlantısını Yapılandırın

Uygulama varsayılan olarak `localhost` üzerinden simülatörle haberleşecek şekilde ayarlanmıştır. Eğer backend farklı bir portta veya sunucuda çalışıyorsa:

* **Dosya:** `pulse-ui/ContentView.swift`
* **Satır:** 6 (yaklaşık)

```swift
// Backend adresini buraya girin.
// iOS Simülatör için "localhost" genellikle çalışır.
// Gerçek cihaz için bilgisayarınızın yerel IP'sini (örn: 192.168.1.x) kullanın.
let API_URL = "http://localhost:8000/api/sales-opportunities/1"

```

*[Not: Demo amaçlı olarak `customer_id: 1` hardcoded olarak ayarlanmıştır. Farklı müşterileri test etmek için URL sonundaki ID'yi değiştirebilirsiniz.]*

### 4. Derleyin ve Çalıştırın

Xcode üzerinden hedef cihazı seçip (Örn: iPhone 15 Pro Simulator) **Run (Cmd+R)** tuşuna basın.

4. Farklı Müşteri Senaryolarını Test Etme
Pulse arka planda binlerce farklı müşteri için üretim yapar. iOS uygulamasında farklı bir müşteri personasını (Örn: Bir "Gamer" yerine "Seyahatsever" birini) simüle etmek için müşteri ID'sini değiştirmeniz yeterlidir.

Xcode'da ContentView.swift dosyasını açın.

En üstteki API_URL satırını bulun:

Swift

// Mevcut (Müşteri ID: 1 - Genellikle "Video/Eğlence" ağırlıklı profil)
let API_URL = "http://localhost:8000/api/sales-opportunities/1"
URL'in sonundaki rakamı değiştirin:

.../2: Farklı bir profil (Örn: FreeZone Öğrenci)

.../3: Farklı bir profil (Örn: İş İnsanı / Roaming)

.../4: Farklı bir profil (Örn: Ev İnterneti Odaklı)

Uygulamayı tekrar çalıştırın (Cmd+R).

İpucu: Backend veritabanında (seed_customers.py ile üretilen) 1500'den fazla rastgele müşteri bulunur. ai_segmentation_label != 'Not Processed' olan rastgele ID'ler deneyerek Pulse'un farklı durumlara (Hava durumu, Kalan Kota, Cihaz Modeli) nasıl tepki verdiğini gözlemleyebilirsiniz.

---

## 📂 Proje Yapısı

* **`pulse_uiApp.swift`**: Uygulamanın giriş noktası (@main).
* **`ContentView.swift`**: Tüm UI mantığını barındıran ana dosya.
* `PulseData` & `PulseViewModel`: Backend'den gelen JSON verisini işleyen model katmanı.
* `HomeView`: Ana sayfa tasarımı ve Story bileşenleri.
* `PulseMagicFlowView`: AI işlem animasyonlarının (Orb, Sparkles, Chips) yönetildiği katman.
* `PulseOfferCardView`: Sonuç ekranı kart tasarımı.



---

**Pixel**
