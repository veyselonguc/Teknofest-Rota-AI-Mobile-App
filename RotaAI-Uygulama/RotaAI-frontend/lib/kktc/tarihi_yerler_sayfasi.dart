import 'package:flutter/material.dart';
import 'tarihi_yerler_detay_sayfasi.dart';

class TarihiYerlerSayfasi extends StatelessWidget {
  final List<Map<String, dynamic>> _tumTarihiYerler = [
    {
      'title': 'Salamis Antik Kenti',
      'description':
          'M.Ö. 11. yüzyılda kurulan antik kent, Roma döneminde en parlak çağını yaşamıştır.',
      'image': 'assets/images/tarihi.jpg',
    },
    {
      'title': 'Bellapais Manastırı',
      'description':
          '1198-1205 yılları arasında inşa edilen manastır, Gotik mimarinin en güzel örneklerinden biridir.',
      'image': 'assets/images/tarihi.jpg',
    },
    {
      'title': 'Girne Kalesi',
      'description':
          '7. yüzyılda Bizanslılar tarafından inşa edilen kale, Venedik döneminde önemli değişiklikler geçirmiştir.',
      'image': 'assets/images/tarihi.jpg',
    },
    {
      'title': 'St. Hilarion Kalesi',
      'description':
          '10. yüzyılda inşa edilen kale, Kıbrıs\'ın en iyi korunmuş ortaçağ kalelerinden biridir.',
      'image': 'assets/images/tarihi.jpg',
    },
    {
      'title': 'Kantara Kalesi',
      'description':
          '10. yüzyılda Bizanslılar tarafından inşa edilen kale, stratejik konumu sayesinde önemli bir savunma noktası olmuştur.',
      'image': 'assets/images/tarihi.jpg',
    },
  ];

  TarihiYerlerSayfasi({super.key});

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
          'Tarihi Yerler',
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
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _tumTarihiYerler.length,
            itemBuilder: (context, index) {
              final yer = _tumTarihiYerler[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TarihiYerlerDetaySayfasi(
                        bigtitle: "Tarihi Yerler",
                        title: yer['title'],
                        content: yer['description'],
                        imagePath: yer['image'],
                      ),
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
                            Text(
                              yer['title'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTarihiYerCard(
    BuildContext context,
    String title,
    String description,
    String location,
    String fullText, {
    String? cardImage,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TarihiYerlerDetaySayfasi(
              title: title,
              bigtitle: 'Tarihi Yerler',
              content: fullText,
              imagePath: cardImage ?? 'assets/images/kktcbayrakk.jpg',
            ),
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
                cardImage ?? 'assets/images/kktcbayrakk.jpg',
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
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
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
      ),
    );
  }
}
