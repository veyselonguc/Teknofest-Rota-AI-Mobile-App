import 'package:flutter/material.dart';
import 'package:ornek003/main.dart';
import 'package:ornek003/onboarding/visited_places_page.dart';

class PreviousVisitsPage extends StatefulWidget {
  const PreviousVisitsPage({super.key});

  @override
  State<PreviousVisitsPage> createState() => _PreviousVisitsPageState();
}

class _PreviousVisitsPageState extends State<PreviousVisitsPage> {
  final List<bool> _selectedPlaces = [];
  final List<String> _allPlaces = [
    // Türkiye Şehirleri
    'İstanbul',
    'Ankara',
    'İzmir',
    'Bursa',
    'Antalya',
    'Adana',
    'Konya',
    'Muğla',
    'Aydın',
    'Nevşehir',
    'Denizli',
    'Çanakkale',
    'Şanlıurfa',
    'Mardin',
    'Trabzon',
    // KKTC Şehirleri
    'Lefkoşa',
    'Girne',
    'Gazimağusa',
    'Güzelyurt',
    'İskele',
    'Lefke',
  ];

  List<String> _filteredPlaces = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedPlaces.addAll(
      List.generate(
        _allPlaces.length,
        (index) => false,
      ),
    );
    _filteredPlaces = _allPlaces;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPlaces(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPlaces = _allPlaces;
      } else {
        _filteredPlaces = _allPlaces
            .where((place) => place.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _handleContinue() {
    final selectedCities = _allPlaces
        .where((place) => _selectedPlaces[_allPlaces.indexOf(place)])
        .toList();

    if (selectedCities.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen en az bir şehir seçiniz.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VisitedPlacesPage(
          selectedCities: selectedCities,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Önceki Ziyaretleriniz',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), // Simetri için
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_city,
                              size: 32,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Hangi şehirleri ziyaret ettiniz?',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Daha iyi öneriler için lütfen ziyaret ettiğiniz yerleri seçin',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: _filterPlaces,
                          decoration: InputDecoration(
                            hintText: 'Şehir ara...',
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[600],
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _filteredPlaces.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search_off,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Aradığınız şehir bulunamadı',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                                itemCount: _filteredPlaces.length,
                                itemBuilder: (context, index) {
                                  final place = _filteredPlaces[index];
                                  final originalIndex =
                                      _allPlaces.indexOf(place);
                                  final isSelected =
                                      _selectedPlaces[originalIndex];
                                  return Card(
                                    elevation: isSelected ? 4 : 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      side: BorderSide(
                                        color: isSelected
                                            ? Theme.of(context).primaryColor
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedPlaces[originalIndex] =
                                              !_selectedPlaces[originalIndex];
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(16),
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          gradient: isSelected
                                              ? LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Theme.of(context)
                                                        .primaryColor,
                                                    Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(0.1),
                                                  ],
                                                )
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              place,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: isSelected
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black87,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _handleContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Devam Et',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
