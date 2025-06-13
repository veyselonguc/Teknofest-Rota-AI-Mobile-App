import 'package:flutter/material.dart';
import 'package:ornek003/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class VisitedPlacesPage extends StatefulWidget {
  final List<String> selectedCities;

  const VisitedPlacesPage({
    super.key,
    required this.selectedCities,
  });

  @override
  State<VisitedPlacesPage> createState() => _VisitedPlacesPageState();
}

class _VisitedPlacesPageState extends State<VisitedPlacesPage> {
  final Map<String, List<String>> cityPlaces = {
    'İstanbul': [
      'Ayasofya',
      'Topkapı Sarayı',
      'Sultanahmet Camii',
      'Galata Kulesi',
      'Dolmabahçe Sarayı',
      'Kapalı Çarşı',
    ],
    'Ankara': [
      'Anıtkabir',
      'Kocatepe Camii',
      'Ankara Kalesi',
      'TBMM',
      'Atakule',
      'Anadolu Medeniyetleri Müzesi',
    ],
    'İzmir': [
      'Saat Kulesi',
      'Kemeraltı Çarşısı',
      'Efes Antik Kenti',
      'Kordon',
      'Asansör',
      'Efes Müzesi',
    ],
    'Antalya': [
      'Kaleiçi',
      'Düden Şelalesi',
      'Aspendos',
      'Konyaaltı Plajı',
      'Hadrian Kapısı',
      'Antalya Müzesi',
    ],
    'Lefkoşa': [
      'Selimiye Camii',
      'Büyük Han',
      'Girne Kapısı',
      'Lefkoşa Surları',
      'Derviş Paşa Konağı',
      'Lefkoşa Kalesi',
    ],
    'Girne': [
      'Girne Kalesi',
      'Bellapais Manastırı',
      'Girne Limanı',
      'St. Hilarion Kalesi',
      'Girne Antik Liman',
      'Girne Kalesi Müzesi',
    ],
  };

  final Map<String, List<bool>> selectedPlaces = {};
  final Map<String, List<int>> placeRatings = {};

  @override
  void initState() {
    super.initState();
    for (var city in widget.selectedCities) {
      if (cityPlaces.containsKey(city)) {
        selectedPlaces[city] = List.generate(
          cityPlaces[city]!.length,
          (index) => false,
        );
        placeRatings[city] = List.generate(
          cityPlaces[city]!.length,
          (index) => 0,
        );
      }
    }
  }

  void _handleContinue() async {
    final prefs = await SharedPreferences.getInstance();
    final ziyaretlerJson = prefs.getString('ziyaretler');
    Map<String, List<Map<String, dynamic>>> mevcutZiyaretler = {};

    // Önceki ziyaretleri yükle
    if (ziyaretlerJson != null) {
      mevcutZiyaretler = Map<String, List<Map<String, dynamic>>>.from(
        json.decode(ziyaretlerJson).map(
              (key, value) => MapEntry(
                key,
                List<Map<String, dynamic>>.from(value.map(
                  (x) => Map<String, dynamic>.from(x),
                )),
              ),
            ),
      );
    }

    // Yeni ziyaretleri ekle
    for (var city in widget.selectedCities) {
      if (selectedPlaces[city] != null) {
        final List<Map<String, dynamic>> cityPlacesList = [];
        for (var i = 0; i < selectedPlaces[city]!.length; i++) {
          if (selectedPlaces[city]![i]) {
            final yeniYer = {
              'name': cityPlaces[city]![i],
              'rating': placeRatings[city]?[i] ?? 0,
            };

            // Eğer şehir zaten varsa ve yer daha önce eklenmemişse ekle
            if (mevcutZiyaretler.containsKey(city)) {
              bool yerVar = false;
              for (var yer in mevcutZiyaretler[city]!) {
                if (yer['name'] == yeniYer['name']) {
                  yerVar = true;
                  break;
                }
              }
              if (!yerVar) {
                mevcutZiyaretler[city]!.add(yeniYer);
              }
            } else {
              // Şehir yoksa yeni liste oluştur
              mevcutZiyaretler[city] = [yeniYer];
            }
          }
        }
      }
    }

    await prefs.setString('ziyaretler', json.encode(mevcutZiyaretler));
    Navigator.pushReplacementNamed(context, '/home');
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
                        'Ziyaret Edilen Yerler',
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
                              Icons.place,
                              size: 32,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Hangi yerleri ziyaret ettiniz?',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Her şehir için ziyaret ettiğiniz yerleri seçin',
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
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.selectedCities.length,
                          itemBuilder: (context, cityIndex) {
                            final city = widget.selectedCities[cityIndex];
                            final places = cityPlaces[city] ?? [];

                            return Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 2,
                              child: ExpansionTile(
                                leading: Icon(
                                  Icons.location_city,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: Text(
                                  city,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children:
                                          places.asMap().entries.map((entry) {
                                        final index = entry.key;
                                        final place = entry.value;
                                        final isSelected = selectedPlaces[city]
                                                ?[index] ??
                                            false;

                                        return Card(
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            side: BorderSide(
                                              color: isSelected
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.transparent,
                                              width: 2,
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (selectedPlaces[city] !=
                                                    null) {
                                                  selectedPlaces[city]![index] =
                                                      !isSelected;
                                                }
                                              });
                                            },
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              padding: const EdgeInsets.all(12),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      place,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: isSelected
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : Colors.black87,
                                                        fontWeight: isSelected
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                  if (isSelected)
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: List.generate(5,
                                                          (starIndex) {
                                                        return IconButton(
                                                          icon: Icon(
                                                            starIndex <
                                                                    (placeRatings[city]
                                                                            ?[
                                                                            index] ??
                                                                        0)
                                                                ? Icons.star
                                                                : Icons
                                                                    .star_border,
                                                            color: Colors.amber,
                                                            size: 20,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              if (placeRatings[
                                                                      city] !=
                                                                  null) {
                                                                placeRatings[
                                                                            city]![
                                                                        index] =
                                                                    starIndex +
                                                                        1;
                                                              }
                                                            });
                                                          },
                                                        );
                                                      }),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
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
