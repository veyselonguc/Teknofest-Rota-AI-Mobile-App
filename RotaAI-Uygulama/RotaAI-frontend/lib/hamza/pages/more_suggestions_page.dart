import 'package:flutter/material.dart';

class MoreSuggestionsPage extends StatelessWidget {
  const MoreSuggestionsPage({super.key});

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
          'Daha Fazla Öneri',
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
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildSuggestionCard(
                context,
                'Patara Plajı',
                'assets/images/patara.jpg',
                'Patara, eşsiz plajı ve antik kalıntılarıyla ünlüdür.',
              ),
              _buildSuggestionCard(
                context,
                'Göbeklitepe',
                'assets/images/gobeklitepe.jpg',
                'Göbeklitepe, insanlık tarihinin en eski tapınak kompleksi olarak bilinir.',
              ),
              _buildSuggestionCard(
                context,
                'Kapadokya',
                'assets/images/kapadokya.jpg',
                'Kapadokya, peri bacaları ve sıcak hava balonları ile ünlüdür.',
              ),
              _buildSuggestionCard(
                context,
                'Efes Antik Kenti',
                'assets/images/efes.jpg',
                'Efes, antik Roma dönemi yapılarıyla oldukça ünlüdür.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionCard(
    BuildContext context,
    String title,
    String imageUrl,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey[200],
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
