import 'package:flutter/material.dart';
import 'package:ornek003/oneri/oneriCalistir.dart';

class DuyguDurumuButonlari extends StatelessWidget {
  const DuyguDurumuButonlari({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDuyguButonu(context, '😃', 'Harika'),
          _buildDuyguButonu(context, '🙂', 'İyi'),
          _buildDuyguButonu(context, '😐', 'Orta'),
          _buildDuyguButonu(context, '😕', 'Kötü'),
          _buildDuyguButonu(context, '☹️', 'Berbat'),
        ],
      ),
    );
  }

  Widget _buildDuyguButonu(BuildContext context, String emoji, String text) {
    return Container(
      height: 80,
      width: 65,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _showMoodDialog(context, text, emoji);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 26),
              ),
              const SizedBox(height: 4),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMoodDialog(BuildContext context, String mood, String emoji) {
    String title = '';
    String message = '';
    Color titleColor = Colors.blue;

    switch (mood) {
      case 'Harika':
        title = 'Harika bir gün!';
        message =
            'Bugün kendini harika hissediyorsun! Bu pozitif enerjiyi değerlendirmek için sana harika önerilerimiz var. Birlikte keşfedelim!';
        titleColor = Colors.amber;
        break;
      case 'İyi':
        title = 'Güzel bir gün!';
        message =
            'İyi hissettiğin bu günü daha da güzelleştirebiliriz! Sana özel hazırladığımız önerileri görmek ister misin?';
        titleColor = Colors.green;
        break;
      case 'Orta':
        title = 'Biraz mola zamanı!';
        message =
            'Gününü daha iyi hale getirmek için bazı önerilerimiz var. Birlikte moralini yükseltebiliriz!';
        titleColor = Colors.orange;
        break;
      case 'Kötü':
        title = 'Moralini yükseltelim!';
        message =
            'Kötü günler geçicidir. Sana kendini daha iyi hissettirecek özel önerilerimiz var. Hadi birlikte bu durumu değiştirelim!';
        titleColor = Colors.blue;
        break;
      case 'Berbat':
        title = 'Yanındayız!';
        message =
            'Zor zamanlar geçiriyor olabilirsin ama unutma ki her şey geçici. Sana özel hazırladığımız önerilerle kendini daha iyi hissetmene yardımcı olmak istiyoruz.';
        titleColor = Colors.purple;
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/question2', arguments: {
                  'mood': mood,
                });
              },
              child: const Text('Devam Et'),
            ),
          ],
        );
      },
    );
  }
}
