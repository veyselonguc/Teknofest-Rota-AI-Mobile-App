import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../auth/login_page.dart';

class VisitHistoryPage extends StatefulWidget {
  const VisitHistoryPage({super.key});

  @override
  State<VisitHistoryPage> createState() => _VisitHistoryPageState();
}

class _VisitHistoryPageState extends State<VisitHistoryPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> _visitHistory = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadVisitHistory();
    });
  }

  Future<void> _loadVisitHistory() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final history = await _apiService.getVisitHistory();
      setState(() {
        _visitHistory = history;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      if (mounted) {
        if (e.toString().contains('Oturum süresi dolmuş') ||
            e.toString().contains('Kullanıcı girişi yapılmamış')) {
          // Kullanıcıyı giriş sayfasına yönlendir
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Hata: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geçmiş Ziyaretlerim'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadVisitHistory,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hata: $_error',
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadVisitHistory,
                        child: const Text('Tekrar Dene'),
                      ),
                    ],
                  ),
                )
              : _visitHistory.isEmpty
                  ? const Center(
                      child:
                          Text('Henüz ziyaret ettiğiniz bir yer bulunmuyor.'),
                    )
                  : ListView.builder(
                      itemCount: _visitHistory.length,
                      itemBuilder: (context, index) {
                        final visit = _visitHistory[index];
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(visit['placeName'] ?? 'İsimsiz Mekan'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(visit['cityName'] ?? 'Şehir Bilgisi Yok'),
                                if (visit['rating'] != null)
                                  Text('Puanınız: ${visit['rating']}'),
                                Text(
                                    'Ziyaret Tarihi: ${visit['visitDate'] ?? 'Tarih Bilgisi Yok'}'),
                              ],
                            ),
                            trailing: visit['rating'] == null
                                ? IconButton(
                                    icon: const Icon(Icons.star_border),
                                    onPressed: () {
                                      // TODO: Puanlama dialogunu göster
                                    },
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
    );
  }
}
