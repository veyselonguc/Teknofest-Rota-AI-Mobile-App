import 'package:flutter/material.dart';
import 'package:ornek003/turkiye/turkiye_sayfasi.dart';

class YoreselTatlarSayfasi extends StatelessWidget {
  YoreselTatlarSayfasi({super.key});

  // Yöresel tatlar için ek veriler
  final List<Map<String, dynamic>> _yoreselTatlarEk = [
    {
      'title': 'İskender Kebap',
      'description':
          'Bursa\'nın meşhur yemeği olan İskender Kebap, ince döş etinden yapılan, domates sosu ve yoğurt ile servis edilen bir kebap türüdür.',
      'image': 'assets/images/iskender.jpg',
      'location': 'Bursa',
    },
    {
      'title': 'Mantı',
      'description':
          'Kayseri\'nin meşhur yemeği olan Mantı, küçük hamur parçalarının içine kıyma konularak yapılan ve yoğurt ile servis edilen bir yemektir.',
      'image': 'assets/images/manti.jpg',
      'location': 'Kayseri',
    },
    {
      'title': 'Künefe',
      'description':
          'Hatay\'ın meşhur tatlısı olan Künefe, kadayıf ve peynir ile yapılan, şerbetli bir tatlıdır.',
      'image': 'assets/images/kunefe.jpg',
      'location': 'Hatay',
    },
  ];

  Widget _buildYoreselTatCard(BuildContext context, Map<String, dynamic> tat) {
    return _buildInfoCard(
      context,
      tat['title'],
      Icons.restaurant_menu,
      tat['image'],
      [
        _buildInfoSection(
          context,
          "Yöresel Tatlar",
          tat['title'],
          tat['description'],
          tat['description'],
          region: tat['location'],
        ),
      ],
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
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sections,
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
    String? region,
    String? locationForEat,
    String? locationInformation,
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
            region,
            null,
            null,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FBFE),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (cardImage != null)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  cardImage,
                  height: 150,
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
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (region != null)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    region,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (region != null) const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withOpacity(0.8),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Devamını Oku",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.white,
                            ),
                          ],
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
    );
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
          'Yöresel Tatlar',
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Mevcut yöresel tatlar
                  ..._yoreselTatlarEk
                      .map((tat) => _buildYoreselTatCard(context, tat)),

                  // Ek yöresel tatlar
                  _buildYoreselTatCard(
                    context,
                    {
                      'title': 'Adana Kebap',
                      'description':
                          'Adana\'nın meşhur yemeği olan Adana Kebap, kıyma etten yapılan, özel baharatlarla hazırlanan ve şişte pişirilen bir kebap türüdür.',
                      'image': 'assets/images/adana_kebap.jpg',
                      'location': 'Adana',
                    },
                  ),
                  _buildYoreselTatCard(
                    context,
                    {
                      'title': 'Lahmacun',
                      'description':
                          'Türk mutfağının vazgeçilmez lezzetlerinden olan Lahmacun, ince hamur üzerine kıyma, soğan, maydanoz ve baharatlardan oluşan harç ile yapılır.',
                      'image': 'assets/images/lahmacun.jpg',
                      'location': 'Gaziantep',
                    },
                  ),
                  _buildYoreselTatCard(
                    context,
                    {
                      'title': 'Baklava',
                      'description':
                          'Türk mutfağının en meşhur tatlılarından olan Baklava, ince yufka katmanları arasına ceviz veya fıstık konularak yapılan ve şerbet dökülen bir tatlıdır.',
                      'image': 'assets/images/baklava.jpg',
                      'location': 'Gaziantep',
                    },
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
