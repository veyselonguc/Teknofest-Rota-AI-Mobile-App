import 'package:flutter/material.dart';
import 'package:ornek003/turkiye/turkiye_sayfasi.dart';

class TarihiYerlerSayfasi extends StatelessWidget {
  TarihiYerlerSayfasi({super.key});

  // Tarihi yerler için ek veriler
  final List<Map<String, dynamic>> _tarihiYerlerEk = [
    {
      'title': 'Sultanahmet Camii',
      'description':
          'İstanbul\'un en ünlü camilerinden biri olan Sultanahmet Camii, 1609-1616 yılları arasında Sultan I. Ahmed tarafından yaptırılmıştır.',
      'image': 'assets/images/sultanahmet.jpg',
      'location': 'İstanbul',
    },
    {
      'title': 'Topkapı Sarayı',
      'description':
          'Osmanlı İmparatorluğu\'nun 400 yıl boyunca yönetim merkezi olan Topkapı Sarayı, 15. yüzyılda Fatih Sultan Mehmet tarafından yaptırılmıştır.',
      'image': 'assets/images/topkapi.jpg',
      'location': 'İstanbul',
    },
    {
      'title': 'Dolmabahçe Sarayı',
      'description':
          '19. yüzyılda Sultan Abdülmecid tarafından yaptırılan Dolmabahçe Sarayı, Osmanlı\'nın son dönem saraylarından biridir.',
      'image': 'assets/images/dolmabahce.jpg',
      'location': 'İstanbul',
    },
  ];

  Widget _buildTarihiYerCard(BuildContext context, Map<String, dynamic> yer) {
    return _buildInfoCard(
      context,
      yer['title'],
      Icons.location_on,
      yer['image'],
      [
        _buildInfoSection(
          context,
          "Tarihi Yerler",
          yer['title'],
          yer['description'],
          yer['description'],
          region: yer['location'],
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
        color: const Color(0xFFE8F5E9),
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
            locationForEat,
            locationInformation,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5FBF6),
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Mevcut tarihi yerler
                  ..._tarihiYerlerEk
                      .map((yer) => _buildTarihiYerCard(context, yer)),

                  // Ek tarihi yerler
                  _buildTarihiYerCard(
                    context,
                    {
                      'title': 'Ayasofya',
                      'description':
                          'İstanbul\'un en önemli tarihi yapılarından biri olan Ayasofya, 537 yılında Bizans İmparatoru I. Justinianus tarafından yaptırılmıştır. Kilise, cami ve müze olarak hizmet vermiştir.',
                      'image': 'assets/images/ayasofya.jpg',
                      'location': 'İstanbul',
                    },
                  ),
                  _buildTarihiYerCard(
                    context,
                    {
                      'title': 'Efes Antik Kenti',
                      'description':
                          'UNESCO Dünya Mirası Listesi\'nde yer alan Efes Antik Kenti, Roma İmparatorluğu\'nun en önemli kentlerinden biriydi. Celsus Kütüphanesi ve Büyük Tiyatro gibi önemli yapıları barındırır.',
                      'image': 'assets/images/efes.jpg',
                      'location': 'İzmir',
                    },
                  ),
                  _buildTarihiYerCard(
                    context,
                    {
                      'title': 'Göbeklitepe',
                      'description':
                          'Dünyanın en eski tapınak merkezi olarak bilinen Göbeklitepe, MÖ 10.000 yılına tarihlenmektedir. Tarih öncesi döneme ait önemli arkeolojik bulgulara ev sahipliği yapar.',
                      'image': 'assets/images/gobeklitepe.jpg',
                      'location': 'Şanlıurfa',
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
