import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/api_provider.dart';
import 'place_selection_page.dart';

class CitySelectionPage extends StatefulWidget {
  const CitySelectionPage({super.key});

  @override
  State<CitySelectionPage> createState() => _CitySelectionPageState();
}

class _CitySelectionPageState extends State<CitySelectionPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredCities = [];

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    try {
      final apiProvider = context.read<ApiProvider>();
      await apiProvider.getCities();
      _filteredCities = apiProvider.cities;
      setState(() {});
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

  void _filterCities(String query) {
    final apiProvider = context.read<ApiProvider>();
    setState(() {
      if (query.isEmpty) {
        _filteredCities = apiProvider.cities;
      } else {
        _filteredCities = apiProvider.cities
            .where((city) => city['cityName']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = context.watch<ApiProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Şehir Seçimi',
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
                  'Hangi şehirleri ziyaret ettin?',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ziyaret ettiğiniz şehirleri seçin',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterCities,
                    decoration: InputDecoration(
                      hintText: 'Şehir ara...',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
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
                else
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _filteredCities.length,
                      itemBuilder: (context, index) {
                        final city = _filteredCities[index];
                        return InkWell(
                          onTap: () {
                            print('Seçilen şehir: ${city['cityName']}');
                            print('Şehir ID: ${city['cityId']}');
                            print('Şehir verisi: $city');

                            if (city['cityId'] != null) {
                              final cityId =
                                  int.tryParse(city['cityId'].toString());
                              if (cityId != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlaceSelectionPage(
                                      cityId: cityId,
                                      cityName: city['cityName']?.toString() ??
                                          'İsimsiz Şehir',
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Geçersiz şehir ID'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Şehir bilgisi bulunamadı'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                city['cityName'],
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
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
