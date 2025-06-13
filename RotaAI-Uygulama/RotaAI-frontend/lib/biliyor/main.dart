import 'package:flutter/material.dart';
import 'package:ornek003/main.dart';
import 'package:ornek003/anasayfa/menu.dart';

class Biliyor extends StatelessWidget {
  const Biliyor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bunu Biliyor Muydunuz?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.8),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildFactCard(
              context,
              "Girne Kalesi'nin Tarihi",
              "Girne Kalesi, Bizans İmparatoru II. Justinianus tarafından inşa ettirilmiştir.",
              "assets/images/girnekale.jpg",
              Icons.castle,
              Colors.blue,
            ),
            _buildFactCard(
              context,
              "Ayasofya'nın Çok Yönlü Kullanımı",
              "Ayasofya, hem camii, hem kilise, hem de müze olarak kullanılmıştır.",
              "assets/images/ayasofya.jpg",
              Icons.church,
              Colors.purple,
            ),
            _buildFactCard(
              context,
              "Kıbrıs Adası'nın Büyüklüğü",
              "Kıbrıs Adası, Akdeniz'in üçüncü büyük adasıdır.",
              "assets/images/ada.jpeg",
              Icons.landscape,
              Colors.green,
            ),
            _buildFactCard(
              context,
              "Lefkoşa'nın Özel Durumu",
              "Lefkoşa, dünyanın en büyük ikiye bölünmüş başkentlerinden biridir.",
              "assets/images/lefkosa.jpeg",
              Icons.location_city,
              Colors.orange,
            ),
            _buildFactCard(
              context,
              "Türkiye'nin Gölleri",
              "Türkiye'de 180'den fazla göl bulunur.",
              "assets/images/goller.jpeg",
              Icons.water,
              Colors.cyan,
            ),
            _buildFactCard(
              context,
              "Kız Kulesi'nin Konumu",
              "Kız Kulesi, İstanbul Boğazı'nda Asya ve Avrupa arasında yer alır.",
              "assets/images/kizkulesi.jpeg",
              Icons.architecture,
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFactCard(
    BuildContext context,
    String title,
    String content,
    String imagePath,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          content,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Kapat',
                      style: TextStyle(color: color),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(icon, color: color, size: 24),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      content,
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
      ),
    );
  }
}
