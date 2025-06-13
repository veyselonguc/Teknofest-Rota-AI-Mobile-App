import 'package:flutter/material.dart';
import 'package:ornek003/hamza/main.dart';

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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QuestionPage1()),
            );
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
}
