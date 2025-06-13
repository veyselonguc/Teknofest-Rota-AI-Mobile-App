import 'package:flutter/material.dart';
import 'tarihi_yerler_sayfasi.dart';
import 'kibris_mutfagi_sayfasi.dart';
import 'yonlendirilen_ayrinti_sayfalari.dart';
import 'tarihi_yerler_detay_sayfasi.dart';
import 'kibris_mutfagi_detay_sayfasi.dart';
import 'detay_sayfasi.dart';

class KKTCSayfasi extends StatefulWidget {
  const KKTCSayfasi({super.key});

  @override
  State<KKTCSayfasi> createState() => _KKTCSayfasiState();
}

class _KKTCSayfasiState extends State<KKTCSayfasi> {
  final List<bool> _showMore = [false, false];
  final List<bool> _isExpanded = [false, false, false];

  final List<Map<String, dynamic>> _tarihiYerlerEk = [
    {
      'title': 'Salamis Antik Kenti',
      'description':
          'KKTC\'nin en önemli antik kentlerinden biri olan Salamis, MÖ 11. yüzyılda kurulmuştur.',
      'image': 'assets/images/salamis.jpg',
      'location': 'Gazimağusa',
    },
    {
      'title': 'St. Hilarion Kalesi',
      'description':
          'Beş Parmak Dağları\'nın zirvesinde yer alan St. Hilarion Kalesi, Bizans döneminden kalmıştır.',
      'image': 'assets/images/hilarion.jpeg',
      'location': 'Girne',
    },
    {
      'title': 'Bellapais Manastırı',
      'description':
          'Gotik mimarinin en güzel örneklerinden biri olan Bellapais Manastırı, 13. yüzyılda inşa edilmiştir.',
      'image': 'assets/images/bellapais.jpeg',
      'location': 'Girne',
    },
  ];

  final List<Map<String, dynamic>> _kibrisMutfagi = [
    {
      'title': 'Molehiya',
      'description':
          'Kıbrıs mutfağının en önemli yemeklerinden biri olan Molehiya, bamya benzeri bir bitkinin yapraklarından yapılır.',
      'image': 'assets/images/molehiya.jpeg',
    },
    {
      'title': 'Kolakas',
      'description':
          'Gölevez olarak da bilinen Kolakas, patates benzeri bir kök sebzeden yapılan geleneksel bir Kıbrıs yemeğidir.',
      'image': 'assets/images/kolakas.jpg',
    },
    {
      'title': 'Hellim',
      'description':
          'Kıbrıs\'ın dünyaca ünlü peyniri Hellim, keçi ve koyun sütünden yapılır ve ızgarada pişirilerek tüketilir.',
      'image': 'assets/images/hellim.jpg',
    },
  ];

  // Yöresel tatlar için ek veriler
  final List<Map<String, dynamic>> _yoreselTatlarEk = [
    {
      'title': 'Hellim Peyniri',
      'description':
          'Kıbrıs\'ın meşhur peyniri olan Hellim, özel bir süt peyniridir.',
      'image': 'assets/images/hellim.jpg',
      'location': 'Kıbrıs',
    },
    {
      'title': 'Şeftali Kebabı',
      'description':
          'Kıbrıs\'ın özel kebabı olan Şeftali Kebabı, kıyma ve baharatlarla yapılır.',
      'image': 'assets/images/molehiya.jpeg',
      'location': 'Kıbrıs',
    },
    {
      'title': 'Künefe',
      'description':
          'Kıbrıs\'ın meşhur tatlısı olan Künefe, kadayıf ve peynir ile yapılır.',
      'image': 'assets/images/kolakas.jpg',
      'location': 'Kıbrıs',
    },
  ];

  Widget _buildTarihiYerCard(Map<String, dynamic> yer) {
    Color cardColor = const Color(0xFFE8F5E9); // Açık yeşil tonu
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: Image.asset(
              yer['image'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        yer['title'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  yer['description'],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYemekCard(Map<String, dynamic> yemek) {
    Color cardColor = const Color(0xFFE3F2FD); // Açık mavi tonu
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: Image.asset(
              yemek['image'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        yemek['title'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  yemek['description'],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
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
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          yonlendirelecekSayfaBelirle(
            bigtitle,
            title,
            summary,
            fullText,
            cardImage: cardImage,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                cardImage ?? 'assets/images/kktcbayrakk.png',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Resim yükleme hatası: $error');
                  print('Resim yolu: $cardImage');
                  return Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    summary,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  MaterialPageRoute yonlendirelecekSayfaBelirle(
    String bigtitle,
    String title,
    String summary,
    String fullText, {
    String? cardImage,
  }) {
    if (bigtitle == 'Tarihi Yerler') {
      return MaterialPageRoute(
        builder: (context) => TarihiYerlerDetaySayfasi(
          title: title,
          bigtitle: bigtitle,
          content: fullText,
          imagePath: cardImage ?? 'assets/images/kktcbayrakk.jpg',
        ),
      );
    } else if (bigtitle == 'Kıbrıs Mutfağı') {
      return MaterialPageRoute(
        builder: (context) => KibrisMutfagiDetaySayfasi(
          title: title,
          bigtitle: bigtitle,
          content: fullText,
          imagePath: cardImage ?? 'assets/images/kktcbayrakk.jpg',
        ),
      );
    } else {
      return MaterialPageRoute(
        builder: (context) => DetaySayfasi(
          title: title,
          content: fullText,
          imagePath: cardImage ?? 'assets/images/kktcbayrakk.jpg',
        ),
      );
    }
  }

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
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/kktcbayrakk.png',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Kuzey Kıbrıs Türk Cumhuriyeti',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Akdeniz\'in İncisi',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ExpansionTile(
                onExpansionChanged: (expanded) {
                  setState(() {
                    _isExpanded[0] = expanded;
                  });
                },
                initiallyExpanded: _isExpanded[0],
                backgroundColor: _isExpanded[0]
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Colors.white,
                collapsedBackgroundColor: Theme.of(context).primaryColor,
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
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildInfoSection(
                          context,
                          "KKTC'yi Tanıyalım",
                          "KKTC Tanıtımı",
                          "Kuzey Kıbrıs Türk Cumhuriyeti'nin tarihi ve genel özellikleri",
                          "Kuzey Kıbrıs Türk Cumhuriyeti (KKTC), Akdeniz'in üçüncü büyük adası olan Kıbrıs'ın kuzeyinde yer alan, 3.355 km²'lik yüzölçümüne sahip bir ülkedir. 15 Kasım 1983 tarihinde bağımsızlığını ilan etmiştir.\n\n- Başkenti Lefkoşa olan KKTC'nin diğer önemli şehirleri Gazimağusa, Girne ve Güzelyurt'tur. Ülkenin resmi dili Türkçe, para birimi ise Türk Lirası'dır.\n\n- KKTC'nin tarihi, adanın genel tarihiyle iç içe geçmiştir. Kıbrıs, tarih boyunca birçok medeniyete ev sahipliği yapmıştır. Hitit, Fenike, Asur, Mısır, Pers, Roma, Bizans, Lüzinyan, Venedik ve Osmanlı gibi medeniyetler adada hüküm sürmüştür.\n\n- 1571 yılında Osmanlı İmparatorluğu tarafından fethedilen ada, 1878 yılında İngiliz yönetimine bırakılmıştır. 1960 yılında Kıbrıs Cumhuriyeti kurulmuş, ancak 1963 yılında başlayan toplumlar arası çatışmalar sonucunda Türk toplumu izole edilmiştir.\n\n- 1974 yılında Türkiye'nin Garantörlük Antlaşması'ndan doğan haklarını kullanarak gerçekleştirdiği Barış Harekatı sonrasında, adanın kuzeyi Türk yönetimine geçmiştir. 1983 yılında ise KKTC'nin bağımsızlığı ilan edilmiştir.",
                          cardImage: "assets/images/kktctarih.jpg",
                        ),
                        _buildInfoSection(
                          context,
                          "KKTC'yi Tanıyalım",
                          "Genel Bilgiler",
                          "KKTC'nin coğrafyası, ekonomisi ve kültürel özellikleri",
                          "Kuzey Kıbrıs Türk Cumhuriyeti, Akdeniz'in eşsiz güzelliklerini barındıran bir ülkedir.\n\n- Coğrafya ve İklim: KKTC, tipik Akdeniz iklimine sahiptir. Yazları sıcak ve kurak, kışları ılık ve yağışlıdır. Beş Parmak Dağları ve Mesarya Ovası başlıca coğrafi oluşumlardır. 396 km uzunluğundaki sahil şeridi, muhteşem plajlara ev sahipliği yapar.\n\n- Ekonomi: Ülke ekonomisi hizmet sektörüne dayanır. Turizm, yükseköğretim, inşaat ve tarım başlıca gelir kaynaklarıdır. Özellikle üniversite eğitimi için dünyanın dört bir yanından öğrenciler KKTC'yi tercih etmektedir.\n\n- Kültür: KKTC kültürü, Türk kültürü ile Akdeniz kültürünün benzersiz bir karışımıdır. Geleneksel el sanatları, halk oyunları ve mutfak kültürü bu zenginliği yansıtır. Lefkara işi danteli, seramik sanatı ve dokumacılık önemli el sanatlarındandır.\n\n- Eğitim: KKTC'de eğitime büyük önem verilir. Ülkede çok sayıda üniversite bulunmakta ve uluslararası öğrencilere ev sahipliği yapmaktadır. Bu özelliği ile bir eğitim adası olarak anılmaktadır.\n\n- Turizm: Tarihi yerler, plajlar, kumarhaneler ve oteller turizmin temelini oluşturur. Salamis Antik Kenti, St. Hilarion Kalesi, Bellapais Manastırı gibi tarihi yerler, turistlerin ilgisini çeken başlıca mekanlardır.",
                          cardImage: "assets/images/kktcbayrakk.png",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ExpansionTile(
                onExpansionChanged: (expanded) {
                  setState(() {
                    _isExpanded[1] = expanded;
                  });
                },
                initiallyExpanded: _isExpanded[1],
                backgroundColor: _isExpanded[1]
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Colors.white,
                collapsedBackgroundColor: Theme.of(context).primaryColor,
                title: Text(
                  'Tarihi Yerler',
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
                  Icons.location_city,
                  color: _isExpanded[1]
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  size: _isExpanded[1] ? 28 : 24,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ..._tarihiYerlerEk
                            .map((yer) => _buildTarihiYerCard(yer))
                            .toList(),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TarihiYerlerSayfasi(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add_circle_outline),
                          label: const Text('Daha Fazla Göster'),
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ExpansionTile(
                onExpansionChanged: (expanded) {
                  setState(() {
                    _isExpanded[2] = expanded;
                  });
                },
                initiallyExpanded: _isExpanded[2],
                backgroundColor: _isExpanded[2]
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Colors.white,
                collapsedBackgroundColor: Theme.of(context).primaryColor,
                title: Text(
                  'Kıbrıs Mutfağı',
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
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ..._kibrisMutfagi
                            .map((yemek) => _buildYemekCard(yemek))
                            .toList(),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KibrisMutfagiSayfasi(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add_circle_outline),
                          label: const Text('Daha Fazla Göster'),
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
