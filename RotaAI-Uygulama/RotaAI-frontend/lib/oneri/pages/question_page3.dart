import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';
import '../../providers/api_provider.dart';

class QuestionPage3 extends StatefulWidget {
  const QuestionPage3({super.key});

  @override
  _QuestionPage3State createState() => _QuestionPage3State();
}

class _QuestionPage3State extends State<QuestionPage3> {
  String? selectedLocation;
  bool _isLoading = false;

  final List<Map<String, dynamic>> locations = [
    {'name': 'Sahil', 'icon': '🏖️'},
    {'name': 'Şehir', 'icon': '🌆'},
    {'name': 'Dağ', 'icon': '⛰️'},
    {'name': 'Orman', 'icon': '🌳'},
    {'name': 'Göl', 'icon': '💧'},
    {'name': 'Ada', 'icon': '🏝️'},
  ];

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
  }

  Future<void> _loadRecommendations() async {
    setState(() => _isLoading = true);
    try {
      await context.read<ApiProvider>().getPlaceRecommendations();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Öneriler yüklenirken hata oluştu: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final selectedMood = args['mood'];
    final selectedActivity = args['activity'];
    final recommendations = context.watch<ApiProvider>().recommendations;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Konum Seçin',
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Size Özel Öneriler',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (recommendations.isEmpty)
                  const Center(
                    child: Text(
                      'Henüz öneri bulunmuyor',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: recommendations.length,
                      itemBuilder: (context, index) {
                        final place = recommendations[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text(place['name'] ?? 'İsimsiz Mekan'),
                            subtitle:
                                Text(place['description'] ?? 'Açıklama yok'),
                            trailing: Text(
                              '${place['point'] ?? 0} ⭐',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              setState(() => selectedLocation = place['name']);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 20),
                Center(
                  child: CustomButton(
                    text: 'Devam Et',
                    isEnabled: selectedLocation != null,
                    onPressed: () {
                      if (selectedLocation != null) {
                        Navigator.pushNamed(context, '/recommendations',
                            arguments: {
                              'mood': selectedMood,
                              'activity': selectedActivity,
                              'location': selectedLocation,
                            });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
