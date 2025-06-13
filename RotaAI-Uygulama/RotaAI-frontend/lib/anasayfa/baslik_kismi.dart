import 'package:flutter/material.dart';

class BaslikKismi extends StatelessWidget {
  const BaslikKismi({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ROTA AI',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Türkiye ve KKTC\'yi Keşfet',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 24),
          child: Image.asset(
            'assets/images/logomuz_beyaz.png',
            height: 70,
            width: 70,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
