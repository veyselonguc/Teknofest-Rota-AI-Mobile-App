import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final selectedMood = args['mood'];
    final selectedActivity = args['activity'];
    final selectedLocation = args['location'];

    final suggestion =
        getSuggestion(selectedMood, selectedActivity, selectedLocation);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Önerilen Rota',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
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
            stops: const [0.0, 0.3, 0.3, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          suggestion['placeName'] ?? 'Bilinmeyen Bir Yer',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            suggestion['imageUrl'] ?? '',
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 250,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            suggestion['description'] ?? 'Bilgi bulunamadı.',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.6,
                              color: Colors.grey[800],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: CustomButton(
                      text: 'Daha Fazla Öneri',
                      onPressed: () {
                        Navigator.pushNamed(context, '/moreSuggestions');
                      },
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

  Map<String, String> getSuggestion(
      String mood, String activity, String location) {
    if (mood == 'Mutlu' && activity == 'Doğa' && location == 'Sahil') {
      return {
        'placeName': 'Kaputaş Plajı',
        'imageUrl': 'assets/images/kaputas.jpg',
        'description':
            "Kaputaş Plajı, turkuaz renkli suları ve muhteşem doğal güzellikleriyle tanınan, Türkiye'nin en gözde sahil destinasyonlarından biridir.",
      };
    } else {
      return {
        'placeName': 'Bilinmeyen Bir Yer',
        'imageUrl': '',
        'description':
            'Seçimlerinize uygun bir yer bulamadık. Lütfen diğer seçenekleri deneyin!',
      };
    }
  }
}
