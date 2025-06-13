import 'package:flutter/material.dart';
import 'kibris_mutfagi_detay_sayfasi.dart';

class KibrisMutfagiSayfasi extends StatelessWidget {
  final List<Map<String, dynamic>> _tumYemekler = [
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
    {
      'title': 'Pilavuna',
      'description':
          'Paskalya döneminde yapılan geleneksel bir hamur işi olan Pilavuna, hellim peyniri ve kuru üzüm ile hazırlanır.',
      'image': 'assets/images/pilavuna.jpg',
    },
    {
      'title': 'Şeftali Kebabı',
      'description':
          'Kıbrıs\'a özgü bir kebap çeşidi olan Şeftali Kebabı, kuzu kıymasının kuzu zarına sarılmasıyla yapılır.',
      'image': 'assets/images/molehiya.jpeg',
    },
  ];

  KibrisMutfagiSayfasi({super.key});

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
          'Kıbrıs Mutfağı',
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
            itemCount: _tumYemekler.length,
            itemBuilder: (context, index) {
              final yemek = _tumYemekler[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KibrisMutfagiDetaySayfasi(
                        bigtitle: "Kıbrıs Mutfağı",
                        title: yemek['title'],
                        content: yemek['description'],
                        imagePath: yemek['image'],
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
                            Text(
                              yemek['title'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
