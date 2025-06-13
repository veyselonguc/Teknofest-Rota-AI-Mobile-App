import 'package:flutter/material.dart';
import 'package:ornek003/services/api_service.dart';
import 'package:ornek003/onboarding/visit_question_page.dart';

class PlaceDetailPage extends StatefulWidget {
  final int placeId;
  final String placeName;
  final String description;
  final String imageUrl;
  final double rating;

  const PlaceDetailPage({
    Key? key,
    required this.placeId,
    required this.placeName,
    required this.description,
    required this.imageUrl,
    required this.rating,
  }) : super(key: key);

  @override
  _PlaceDetailPageState createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    _rating = widget.rating.toInt();
  }

  Future<void> _onNext() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Önce ziyaret kaydını yap
      print('Ziyaret kaydediliyor: ${widget.placeId}');
      await _apiService.saveVisitedPlace(widget.placeId);

      // Sonra puanlamayı kaydet
      if (_rating > 0) {
        print('Puanlama kaydediliyor: ${widget.placeId} - $_rating yıldız');
        await _apiService.savePlaceRating(widget.placeId, _rating);
      }

      // Başarılı mesajı göster
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ziyaret ve puanlama kaydedildi'),
            backgroundColor: Colors.green,
          ),
        );
      }

      // İleri git
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const VisitQuestionPage(),
          ),
        );
      }
    } catch (e) {
      print('İleri gitme hatası: $e');
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.placeName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.placeName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(widget.description),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Puanınız: '),
                      ...List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              _rating = index + 1;
                            });
                          },
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _onNext,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text('İleri'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
