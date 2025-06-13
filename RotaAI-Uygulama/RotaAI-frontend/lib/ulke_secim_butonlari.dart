import 'package:flutter/material.dart';
import 'package:ornek003/emre/kibris_sayfasi.dart';
import 'package:ornek003/furkan/turkiye_sayfasi.dart' as furkan;

class UlkeSecimButonlari extends StatelessWidget {
  const UlkeSecimButonlari({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildCountryCard(
            context: context,
            title: 'TÜRKİYE',
            imagePath: 'assets/images/türkiyee.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => furkan.Sayfam3()),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildCountryCard(
            context: context,
            title: 'KKTC',
            imagePath: 'assets/images/kıbrıs.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const KKTC()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCountryCard({
    required BuildContext context,
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    width: 100,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Keşfet',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
