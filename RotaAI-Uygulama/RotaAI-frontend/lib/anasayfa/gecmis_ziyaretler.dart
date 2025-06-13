import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:ornek003/onboarding/previous_visits_page.dart';

class GecmisZiyaretlerPage extends StatefulWidget {
  const GecmisZiyaretlerPage({super.key});

  @override
  State<GecmisZiyaretlerPage> createState() => _GecmisZiyaretlerPageState();
}

class _GecmisZiyaretlerPageState extends State<GecmisZiyaretlerPage> {
  Map<String, List<Map<String, dynamic>>> ziyaretler = {};

  @override
  void initState() {
    super.initState();
    _ziyaretleriYukle();
  }

  Future<void> _ziyaretleriYukle() async {
    final prefs = await SharedPreferences.getInstance();
    final ziyaretlerJson = prefs.getString('ziyaretler');
    if (ziyaretlerJson != null) {
      setState(() {
        ziyaretler = Map<String, List<Map<String, dynamic>>>.from(
          json.decode(ziyaretlerJson).map(
                (key, value) => MapEntry(
                  key,
                  List<Map<String, dynamic>>.from(value.map(
                    (x) => Map<String, dynamic>.from(x),
                  )),
                ),
              ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geçmiş Ziyaretlerim'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PreviousVisitsPage(),
            ),
          ).then((_) => _ziyaretleriYukle());
        },
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.add),
        label: const Text('Yeni Ziyaret Ekle'),
      ),
      body: ziyaretler.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Henüz ziyaret edilen yer bulunmuyor',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PreviousVisitsPage(),
                        ),
                      ).then((_) => _ziyaretleriYukle());
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Yeni Ziyaret Ekle'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ziyaretler.length,
              itemBuilder: (context, index) {
                final city = ziyaretler.keys.elementAt(index);
                final places = ziyaretler[city]!;

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
                          children: places.map((place) {
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        place['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(5, (starIndex) {
                                        return Icon(
                                          starIndex < (place['rating'] ?? 0)
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                          size: 20,
                                        );
                                      }),
                                    ),
                                  ],
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
    );
  }
}
