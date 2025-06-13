import 'package:flutter/material.dart';

class DynamicContainer extends StatelessWidget {
  final String? text; // Yazı parametresi
  final String? imageUrl; // Resim URL'si parametresi
  final TextStyle? textStyle; // Yazı için stil (opsiyonel)

  const DynamicContainer({
    Key? key,
    this.text,
    this.imageUrl,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // İçerik çevresinde boşluk
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white), // Kenarlık (isteğe bağlı)
        borderRadius: BorderRadius.circular(45), // Köşeleri yuvarlat
        color: Colors.white30
        ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // İçerik boyutuna göre küçült
        children: [// Eğer resim varsa
            Row(
              children: [
                // Eğer yazı varsa
                Text(
                  text!,
                  style: textStyle ?? const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 20),
                Image.asset(
                  imageUrl!, // Yerel resim yükleme
                  width: 75,
                  height: 75
                ),
              ],
            ),
        ],
      ),
    );
  }
}
