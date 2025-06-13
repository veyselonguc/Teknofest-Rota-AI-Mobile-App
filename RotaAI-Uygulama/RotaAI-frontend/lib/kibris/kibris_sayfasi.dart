import 'package:flutter/material.dart';
import 'package:ornek003/kibris/kibris_mutfagi_detay_sayfasi.dart';
import 'package:ornek003/kibris/tarihi_yerler_detay_sayfasi.dart';
import 'package:ornek003/kibris/detay_sayfasi.dart';

class KibrisSayfasi extends StatefulWidget {
  const KibrisSayfasi({super.key});

  @override
  State<KibrisSayfasi> createState() => _KibrisSayfasiState();
}

class _KibrisSayfasiState extends State<KibrisSayfasi> {
  final List<bool> _isExpanded = [false, false, false];
  final List<bool> _showMore = [false, false];

  final List<Map<String, dynamic>> _tarihiYerlerEk = [
    {
      'title': 'Salamis Antik Kenti',
      'description':
          'Kıbrıs\'ın en önemli antik kentlerinden biri olan Salamis, M.Ö. 11. yüzyılda kurulmuştur.',
      'image': 'assets/images/salamis.jpg',
      'location': 'Gazimağusa',
    },
    {
      'title': 'St.Hilarion Kalesi',
      'description':
          'Kıbrıs\'ın en iyi korunmuş ortaçağ kalelerinden biri olan St.Hilarion Kalesi, 10. yüzyılda inşa edilmiştir.',
      'image': 'assets/images/hilarion.jpeg',
      'location': 'Girne',
    },
    {
      'title': 'Bellapais Manastırı',
      'description':
          '13. yüzyılda inşa edilen Bellapais Manastırı, Gotik mimarinin güzel bir örneğidir.',
      'image': 'assets/images/bellapais.jpeg',
      'location': 'Girne',
    },
  ];

  final List<Map<String, dynamic>> _yoreselTatlarEk = [
    {
      'title': 'Molehiya',
      'description':
          'Kıbrıs\'ın geleneksel yemeği olan Molehiya, yeşil yapraklı bir bitkiden yapılan çorbadır.',
      'image': 'assets/images/molehiya.jpeg',
      'location': 'Kıbrıs',
    },
    {
      'title': 'Kolakas',
      'description':
          'Kıbrıs\'ın meşhur yemeği olan Kolakas, taro bitkisinin kökünden yapılan bir yemektir.',
      'image': 'assets/images/kolakas.jpg',
      'location': 'Kıbrıs',
    },
    {
      'title': 'Hellim',
      'description':
          'Kıbrıs\'ın meşhur peyniri olan Hellim, keçi ve koyun sütünden yapılan bir peynir türüdür.',
      'image': 'assets/images/hellim.jpg',
      'location': 'Kıbrıs',
    },
  ];

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
          'Kıbrıs',
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
                                  "assets/images/kktcbayrakk.jpg",
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
}

MaterialPageRoute yonlendirelecekSayfaBelirle(
    String? bigtitle,
    String? title,
    String? summary,
    String? content,
    String? region,
    String? locationForEat,
    String? locationInformation) {
  if (bigtitle == "Tarihi Yerler") {
    final Map<String, String> imageMap = {
      'Salamis Antik Kenti': 'assets/images/salamis.jpg',
      'St.Hilarion Kalesi': 'assets/images/hilarion.jpeg',
      'Bellapais Manastırı': 'assets/images/bellapais.jpeg',
    };

    return MaterialPageRoute(
      builder: (context) => TarihiYerlerDetaySayfasi(
        title: title.toString(),
        bigtitle: bigtitle.toString(),
        content: content.toString(),
        imagePath: imageMap[title] ?? 'assets/images/tarihi.jpg',
      ),
    );
  } else if (bigtitle == "Yöresel Tatlar") {
    final Map<String, String> imageMap = {
      'Molehiya': 'assets/images/molehiya.jpeg',
      'Kolakas': 'assets/images/kolakas.jpg',
      'Hellim': 'assets/images/hellim.jpg',
    };

    return MaterialPageRoute(
      builder: (context) => KibrisMutfagiDetaySayfasi(
        title: title.toString(),
        bigtitle: bigtitle.toString(),
        content: content.toString(),
        imagePath: imageMap[title] ?? 'assets/images/yoresel_tat.jpg',
      ),
    );
  } else {
    final Map<String, String> imageMap = {
      'Ülke Tarihçesi': 'assets/images/tarihce.jpg',
      'Ülke Genel Tanıtım': 'assets/images/kktcbayrakk.jpg',
    };

    return MaterialPageRoute(
      builder: (context) => DetaySayfasi(
        title: title.toString(),
        content: content.toString(),
        imagePath: imageMap[title] ?? 'assets/images/tarihi.jpg',
      ),
    );
  }
}
