import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/api_provider.dart';
import '../main.dart';

class PlaceSelectionPage extends StatefulWidget {
  final int cityId;
  final String cityName;

  const PlaceSelectionPage({
    super.key,
    required this.cityId,
    required this.cityName,
  });

  @override
  State<PlaceSelectionPage> createState() => _PlaceSelectionPageState();
}

class _PlaceSelectionPageState extends State<PlaceSelectionPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredPlaces = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPlaces();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadPlaces() async {
    try {
      final apiProvider = context.read<ApiProvider>();
      await apiProvider.getPlacesByCity(widget.cityId);
      setState(() {
        _filteredPlaces = apiProvider.places;
      });
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

  void _filterPlaces(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPlaces = context.read<ApiProvider>().places;
      } else {
        _filteredPlaces = context
            .read<ApiProvider>()
            .places
            .where((place) => (place['placeName'] ?? '')
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = context.watch<ApiProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.cityName} Mekanları',
          style: const TextStyle(
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
                  'Ziyaret ettiğiniz mekanları seçin',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Her mekan için puanınızı belirleyin',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _searchController,
                  onChanged: _filterPlaces,
                  decoration: InputDecoration(
                    hintText: 'Mekan ara...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
                const SizedBox(height: 16),
                if (apiProvider.isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (apiProvider.error != null)
                  Center(
                    child: Text(
                      apiProvider.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredPlaces.length,
                      itemBuilder: (context, index) {
                        final place = _filteredPlaces[index];
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
                                  place['placeName'] ?? 'İsimsiz Mekan',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Puanınız:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(5, (index) {
                                        return IconButton(
                                          icon: Icon(
                                            (place['rating'] ?? 0) > index
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: Colors.amber,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              place['rating'] = index + 1;
                                            });
                                          },
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
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          _isLoading = true;
                        });

                        // Puanlanan mekanları kaydet
                        final apiProvider = context.read<ApiProvider>();
                        final userId = await apiProvider.getUserId();
                        if (userId == null) {
                          throw Exception('Kullanıcı girişi yapılmamış');
                        }

                        for (var place in apiProvider.places) {
                          if (place['rating'] != null &&
                              place['placeId'] != null) {
                            print(
                                'Mekan kaydediliyor: ${place['placeName']} - ${place['rating']} yıldız');

                            // Önce ziyaret kaydı
                            await apiProvider.saveVisitedPlace(
                                userId, place['placeId'] as int);

                            // Sonra puanlama
                            await apiProvider.savePlaceRating(
                              place['placeId'] as int,
                              place['rating'] as int,
                            );
                          }
                        }

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Tüm ziyaretler ve puanlamalar kaydedildi'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }

                        // Ana sayfaya yönlendir
                        if (mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        }
                      } catch (e) {
                        print('Kaydetme hatası: $e');
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Hata: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'İleri',
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
