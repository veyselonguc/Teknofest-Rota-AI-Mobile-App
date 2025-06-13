import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/api_provider.dart';
import 'city_selection_page.dart';

class VisitHistoryPage extends StatefulWidget {
  const VisitHistoryPage({super.key});

  @override
  State<VisitHistoryPage> createState() => _VisitHistoryPageState();
}

class _VisitHistoryPageState extends State<VisitHistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadVisitHistory();
    });
  }

  Future<void> _loadVisitHistory() async {
    try {
      final apiProvider = context.read<ApiProvider>();
      await apiProvider.getVisitHistory();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = context.watch<ApiProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Geçmiş Ziyaretlerim',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(
                  'Ziyaret Ettiğiniz Mekanlar',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tüm ziyaretlerinizi burada görebilirsiniz',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                if (apiProvider.isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (apiProvider.error != null)
                  Center(
                    child: Text(
                      apiProvider.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                else if (apiProvider.visitHistory.isEmpty)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 64,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Henüz ziyaret kaydınız bulunmuyor',
                          style: TextStyle(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: apiProvider.visitHistory.length,
                      itemBuilder: (context, index) {
                        final visit = apiProvider.visitHistory[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  visit['placeName'] ?? 'İsimsiz Mekan',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  visit['cityName'] ?? 'İsimsiz Şehir',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    const Text(
                                      'Puanınız: ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          (visit['point'] ?? 0) > index
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                          size: 20,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CitySelectionPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Yeni Ziyaret Ekle',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
