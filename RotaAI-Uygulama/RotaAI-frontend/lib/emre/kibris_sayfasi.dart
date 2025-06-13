import 'package:flutter/material.dart';
import 'package:ornek003/emre/kibris_gerekli_metodlar.dart';
import 'package:ornek003/emre/tarihi_yerler_detay_sayfasi.dart';
import 'package:ornek003/emre/kibris_mutfagi_detay_sayfasi.dart';
// import 'package:teknofest_turizm_projesi/gerekli_metodlar.dart';
// import 'package:teknofest_turizm_projesi/yonlendirilen_ayrinti_sayfalari.dart';
// import 'package:teknofest_turizm_projesi/yoresel_tatlar_ayrinti_sayfasi.dart';

class KKTC extends StatelessWidget {
  const KKTC({super.key});

  @override
  Widget build(BuildContext context) {
    return const KKTCSayfasi();
  }
}

class KKTCSayfasi extends StatefulWidget {
  const KKTCSayfasi({super.key});

  @override
  State<KKTCSayfasi> createState() => _KKTCSayfasiState();
}

class _KKTCSayfasiState extends State<KKTCSayfasi> {
  final List<bool> _isExpanded = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'KKTC',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
              Colors.white,
              Colors.white,
            ],
            stops: const [0.0, 0.2, 0.2, 1.0],
          ),
        ),
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 8,
          radius: const Radius.circular(12),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  // Bayrak ve Başlık Bölümü
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  "assets/images/kktcbayrakk.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.6),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Kuzey Kıbrıs Türk Cumhuriyeti",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Akdeniz'in İncisi",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Kategoriler
                  Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                      colorScheme: ColorScheme.fromSwatch().copyWith(
                        primary: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        // KKTC'yi Tanıyalım Kategorisi
                        Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ExpansionTile(
                            onExpansionChanged: (expanded) {
                              setState(() {
                                _isExpanded[0] = expanded;
                              });
                            },
                            initiallyExpanded: _isExpanded[0],
                            backgroundColor: _isExpanded[0]
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1)
                                : Colors.white,
                            collapsedBackgroundColor:
                                Theme.of(context).primaryColor,
                            title: Text(
                              "KKTC'yi Tanıyalım",
                              style: TextStyle(
                                color: _isExpanded[0]
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                fontSize: _isExpanded[0] ? 20 : 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: _isExpanded[0] ? 0.5 : 0,
                              ),
                            ),
                            leading: Icon(
                              Icons.library_books_outlined,
                              color: _isExpanded[0]
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              size: _isExpanded[0] ? 28 : 24,
                            ),
                            children: [
                              _buildInfoCard(
                                context,
                                "KKTC'yi Tanıyalım",
                                Icons.library_books_outlined,
                                "assets/images/kktctarih.jpg",
                                [
                                  _buildInfoSection(
                                    context,
                                    "KKTC Tanıtımı",
                                    "Ülke Tarihçesi",
                                    "KKTC, Kıbrıs adasının kuzeyinde yer alan genç ve dinamik bir cumhuriyettir...",
                                    "- Osmanlı Dönemi (1571-1878): Kıbrıs, 1571 yılında Osmanlı İmparatorluğu tarafından fethedildi ve yaklaşık 300 yıl Osmanlı yönetimi altında kaldı...",
                                    cardImage: "assets/images/kktctarih.jpg",
                                  ),
                                  _buildInfoSection(
                                    context,
                                    "KKTC Tanıtımı",
                                    "Ülke Genel Tanıtım",
                                    "KKTC, Akdeniz'in doğusunda stratejik konuma sahip bir ada ülkesidir...",
                                    "- Kuzey Kıbrıs Türk Cumhuriyeti (KKTC)'nin yüzölçümü yaklaşık 3.355 km²'dir...",
                                    cardImage: "assets/images/kktcbayrakk.png",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Tarihi Yerler Kategorisi
                        Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ExpansionTile(
                            onExpansionChanged: (expanded) {
                              setState(() {
                                _isExpanded[1] = expanded;
                              });
                            },
                            initiallyExpanded: _isExpanded[1],
                            backgroundColor: _isExpanded[1]
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1)
                                : Colors.white,
                            collapsedBackgroundColor:
                                Theme.of(context).primaryColor,
                            title: Text(
                              "Tarihi Yerler",
                              style: TextStyle(
                                color: _isExpanded[1]
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                fontSize: _isExpanded[1] ? 20 : 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: _isExpanded[1] ? 0.5 : 0,
                              ),
                            ),
                            leading: Icon(
                              Icons.location_on,
                              color: _isExpanded[1]
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              size: _isExpanded[1] ? 28 : 24,
                            ),
                            children: [
                              _buildInfoCard(
                                context,
                                "Tarihi Yerler",
                                Icons.location_on,
                                "assets/images/tarihiyer.jpg",
                                [
                                  _buildInfoSection(
                                    context,
                                    "Tarihi Yerler",
                                    "Girne Kalesi",
                                    "Girne Kalesi, KKTC'nin en önemli tarihi yapılarından biridir...",
                                    "Girne Kalesi, 7. yüzyılda Bizanslılar tarafından inşa edilmiş ve günümüze kadar korunmuştur...",
                                    cardImage: "assets/images/girnekale.jpg",
                                  ),
                                  _buildInfoSection(
                                    context,
                                    "Tarihi Yerler",
                                    "Salamis Harabeleri",
                                    "Salamis, KKTC'nin en önemli antik kentlerinden biridir...",
                                    "Salamis antik kenti, MÖ 11. yüzyılda kurulmuş ve önemli bir ticaret merkezi olmuştur...",
                                    cardImage: "assets/images/lefkosa.jpeg",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Yöresel Tatlar Kategorisi
                        Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ExpansionTile(
                            onExpansionChanged: (expanded) {
                              setState(() {
                                _isExpanded[2] = expanded;
                              });
                            },
                            initiallyExpanded: _isExpanded[2],
                            backgroundColor: _isExpanded[2]
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1)
                                : Colors.white,
                            collapsedBackgroundColor:
                                Theme.of(context).primaryColor,
                            title: Text(
                              "Yöresel Tatlar",
                              style: TextStyle(
                                color: _isExpanded[2]
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                fontSize: _isExpanded[2] ? 20 : 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: _isExpanded[2] ? 0.5 : 0,
                              ),
                            ),
                            leading: Icon(
                              Icons.restaurant_menu,
                              color: _isExpanded[2]
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              size: _isExpanded[2] ? 28 : 24,
                            ),
                            children: [
                              _buildInfoCard(
                                context,
                                "Kıbrıs Mutfağı",
                                Icons.restaurant_menu,
                                "assets/images/yoresel_tat.jpg",
                                [
                                  _buildInfoSection(
                                    context,
                                    "Kıbrıs Mutfağı",
                                    "Hellim",
                                    "Hellim, KKTC'nin en ünlü peynir çeşididir...",
                                    "Hellim, keçi ve koyun sütünden yapılan geleneksel bir Kıbrıs peyniridir...",
                                    cardImage: "assets/images/yoresel_tat.jpg",
                                  ),
                                  _buildInfoSection(
                                    context,
                                    "Kıbrıs Mutfağı",
                                    "Molehiya",
                                    "Molehiya, KKTC mutfağının vazgeçilmez yemeklerinden biridir...",
                                    "Molehiya, yaprakları kullanılan bir bitki türüdür ve genellikle et ile pişirilir...",
                                    cardImage: "assets/images/yemekler.jpg",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Biliyor Muydunuz? Kategorisi
                        Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ExpansionTile(
                            onExpansionChanged: (expanded) {
                              setState(() {
                                _isExpanded[3] = expanded;
                              });
                            },
                            initiallyExpanded: _isExpanded[3],
                            backgroundColor: _isExpanded[3]
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1)
                                : Colors.white,
                            collapsedBackgroundColor:
                                Theme.of(context).primaryColor,
                            title: Text(
                              "Biliyor Muydunuz?",
                              style: TextStyle(
                                color: _isExpanded[3]
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                fontSize: _isExpanded[3] ? 20 : 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: _isExpanded[3] ? 0.5 : 0,
                              ),
                            ),
                            leading: Icon(
                              Icons.lightbulb_outline,
                              color: _isExpanded[3]
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              size: _isExpanded[3] ? 28 : 24,
                            ),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    _buildFactCard(
                                      context,
                                      "Kıbrıs'ın En Eski Yerleşimi",
                                      "Kıbrıs'taki ilk yerleşim MÖ 10.000 yıllarına dayanmaktadır. Adada bulunan en eski yerleşim yeri olan Khirokitia, UNESCO Dünya Mirası Listesi'nde yer almaktadır.",
                                      Icons.history,
                                      Colors.blue.shade100,
                                      Colors.blue,
                                    ),
                                    _buildFactCard(
                                      context,
                                      "Endemik Türler",
                                      "KKTC'de 19 endemik bitki türü bulunmaktadır. Bu bitkilerden bazıları dünyada sadece Kıbrıs'ta yetişmektedir.",
                                      Icons.eco,
                                      Colors.green.shade100,
                                      Colors.green,
                                    ),
                                    _buildFactCard(
                                      context,
                                      "Caretta Carettalar",
                                      "KKTC sahilleri, nesli tükenmekte olan Caretta Caretta kaplumbağalarının en önemli üreme alanlarından biridir.",
                                      Icons.pets,
                                      Colors.orange.shade100,
                                      Colors.orange,
                                    ),
                                    _buildFactCard(
                                      context,
                                      "St. Hilarion Kalesi",
                                      "Walt Disney'in Pamuk Prenses ve Yedi Cüceler filmindeki şatonun, St. Hilarion Kalesi'nden esinlenilerek çizildiği söylenir.",
                                      Icons.castle,
                                      Colors.purple.shade100,
                                      Colors.purple,
                                    ),
                                    _buildFactCard(
                                      context,
                                      "Hellim'in Coğrafi İşareti",
                                      "Hellim peyniri, KKTC'nin coğrafi işaret tescili almış en önemli ürünüdür ve dünyaca ünlüdür.",
                                      Icons.verified,
                                      Colors.red.shade100,
                                      Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    IconData icon,
    String imagePath,
    List<Widget> sections,
  ) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: sections,
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    String bigtitle,
    String title,
    String summary,
    String fullText, {
    String? cardImage,
    String? region,
    String? locationForEat,
    String? locationInformation,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              cardImage ?? "",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => yonlendirelecekSayfaBelirle(
                    bigtitle,
                    title,
                    fullText,
                    cardImage ?? "",
                    region,
                    locationForEat,
                    locationInformation,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    summary,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Detaylar",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget yonlendirelecekSayfaBelirle(
    String bigtitle,
    String title,
    String fullText,
    String cardImage,
    String? region,
    String? locationForEat,
    String? locationInformation,
  ) {
    if (bigtitle == "Kıbrıs Mutfağı") {
      return KibrisMutfagiDetaySayfasi(
        title: title,
        bigtitle: bigtitle,
        content: fullText,
        region: region ?? "",
        locationForEat: locationForEat ?? "",
        locationInformation: locationInformation ?? "",
      );
    } else {
      return TarihiYerlerDetaySayfasi(
        title: title,
        bigtitle: bigtitle,
        content: fullText,
      );
    }
  }

  Widget _buildFactCard(
    BuildContext context,
    String title,
    String content,
    IconData icon,
    Color backgroundColor,
    Color iconColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Tıklandığında animasyonlu bir şekilde içeriği göster
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Row(
                  children: [
                    Icon(icon, color: iconColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                content: Text(
                  content,
                  style: const TextStyle(fontSize: 16),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Kapat',
                      style: TextStyle(color: iconColor),
                    ),
                  ),
                ],
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: iconColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
