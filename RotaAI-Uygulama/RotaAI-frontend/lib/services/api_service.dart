import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5007/api';
  static const String userIdKey = 'user_id';

  // Kullanıcı ID'sini kaydetme
  Future<void> saveUserId(int userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(userIdKey, userId);
      print('UserId kaydedildi: $userId');
    } catch (e) {
      print('UserId kaydetme hatası: $e');
      rethrow;
    }
  }

  // Kullanıcı ID'sini getirme
  Future<int?> getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt(userIdKey);
      print(
          'UserId getirildi: ${userId != null ? 'UserId var' : 'UserId yok'}');
      return userId;
    } catch (e) {
      print('UserId getirme hatası: $e');
      return null;
    }
  }

  // Kullanıcı ID'sini silme
  Future<void> deleteUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(userIdKey);
      print('UserId başarıyla silindi');
    } catch (e) {
      print('UserId silme hatası: $e');
      rethrow;
    }
  }

  // HTTP istekleri için header oluşturma
  Future<Map<String, String>> _getHeaders() async {
    return {
      'Content-Type': 'application/json',
    };
  }

  // Kullanıcı kaydı
  Future<Map<String, dynamic>> register(
      String username, String email, String password) async {
    try {
      print('Register Request: $baseUrl/User/register');
      print('Request Body: ${json.encode({
            'username': username,
            'email': email,
            'password': password,
          })}');

      final response = await http.post(
        Uri.parse('$baseUrl/User/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await saveUserId(data['userId']);
        return data;
      } else {
        final errorBody = json.decode(response.body);
        throw Exception(
            errorBody['message'] ?? 'Kayıt işlemi başarısız: ${response.body}');
      }
    } catch (e) {
      print('Register Error: $e');
      rethrow;
    }
  }

  // Tüm kullanıcıları getirme
  Future<List<dynamic>> getAllUsers() async {
    try {
      print('Tüm kullanıcılar için istek yapılıyor: $baseUrl/User');
      final response = await http.get(
        Uri.parse('$baseUrl/User'),
        headers: await _getHeaders(),
      );
      print('Kullanıcılar yanıtı: ${response.statusCode}');
      print('Kullanıcılar yanıt gövdesi: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Kullanıcılar getirilemedi: ${response.statusCode}');
      }
    } catch (e) {
      print('Kullanıcılar getirme hatası: $e');
      rethrow;
    }
  }

  // Kullanıcı girişi
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      print('Login Request: $baseUrl/User/login');
      print('Request Body: ${json.encode({
            'email': email,
            'password': password,
          })}');

      final response = await http.post(
        Uri.parse('$baseUrl/User/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Önce tüm kullanıcıları çek
        final users = await getAllUsers();

        // Email'e göre kullanıcıyı bul
        final user = users.firstWhere(
          (user) => user['email'] == email,
          orElse: () => throw Exception('Kullanıcı bulunamadı'),
        );

        final userId = user['userId'] as int;
        await saveUserId(userId);

        return {
          'userId': userId,
          'username': email.split('@')[0],
          'email': email,
        };
      } else {
        final errorBody = json.decode(response.body);
        throw Exception(
            errorBody['message'] ?? 'Giriş işlemi başarısız: ${response.body}');
      }
    } catch (e) {
      print('Login Error: $e');
      rethrow;
    }
  }

  // Şehirleri getirme
  Future<List<dynamic>> getCities() async {
    try {
      print('Get Cities Request: $baseUrl/City');
      final response = await http.get(
        Uri.parse('$baseUrl/City'),
        headers: await _getHeaders(),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Şehirler getirilemedi: ${response.body}');
      }
    } catch (e) {
      print('Get Cities Error: $e');
      rethrow;
    }
  }

  // Şehirdeki yerleri getirme
  Future<List<dynamic>> getPlacesByCity(int cityId) async {
    try {
      print('Mekanlar için istek yapılıyor: $baseUrl/Place/city/$cityId');
      final response = await http.get(
        Uri.parse('$baseUrl/Place/city/$cityId'),
        headers: await _getHeaders(),
      );
      print('Mekanlar yanıtı: ${response.statusCode}');
      print('Mekanlar yanıt gövdesi: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception(
            'Mekanlar yüklenirken hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      print('Mekanlar yüklenirken hata: $e');
      rethrow;
    }
  }

  // Yer detaylarını getirme
  Future<Map<String, dynamic>> getPlaceDetails(int placeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/places/$placeId'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Yer detayları getirilemedi: ${response.body}');
    }
  }

  // Ziyaret geçmişini getirme
  Future<List<dynamic>> getVisitHistory() async {
    try {
      final userId = await getUserId();
      if (userId == null) {
        print('UserId bulunamadı, ziyaret geçmişi yüklenemiyor');
        throw Exception('Kullanıcı girişi yapılmamış');
      }

      print(
          'Ziyaret geçmişi için istek yapılıyor: $baseUrl/VisitedPlace/user/$userId');
      final response = await http.get(
        Uri.parse('$baseUrl/VisitedPlace/user/$userId'),
        headers: await _getHeaders(),
      );

      print('Ziyaret geçmişi yanıtı: ${response.statusCode}');
      print('Ziyaret geçmişi yanıt gövdesi: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('Ziyaret geçmişi başarıyla yüklendi: ${data.length} kayıt');
        return data;
      } else {
        print('Ziyaret geçmişi yüklenirken hata: ${response.statusCode}');
        throw Exception(
            'Ziyaret geçmişi yüklenirken hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      print('Ziyaret geçmişi yüklenirken hata: $e');
      rethrow;
    }
  }

  // Ziyaret edilen yeri kaydetme
  Future<void> saveVisitedPlace(int placeId) async {
    try {
      final userId = await getUserId();
      if (userId == null) {
        throw Exception('Kullanıcı girişi yapılmamış');
      }

      final url = '$baseUrl/VisitedPlace/user/$userId/place/$placeId/visit';
      print('Ziyaret kaydediliyor: $url');

      final response = await http.post(
        Uri.parse(url),
        headers: await _getHeaders(),
      );

      print('Ziyaret yanıtı: ${response.statusCode}');
      print('Ziyaret yanıt gövdesi: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Ziyaret kaydedilemedi: ${response.statusCode}');
      }
    } catch (e) {
      print('Ziyaret kaydetme hatası: $e');
      rethrow;
    }
  }

  // Mekan puanlama
  Future<void> savePlaceRating(int placeId, int rating) async {
    try {
      final userId = await getUserId();
      if (userId == null) {
        throw Exception('Kullanıcı girişi yapılmamış');
      }

      final url = '$baseUrl/VisitedPlace/user/$userId/place/$placeId/rate';
      print('Puanlama kaydediliyor: $url');
      print('Puanlama değeri: $rating');

      final response = await http.post(
        Uri.parse(url),
        headers: await _getHeaders(),
        body: json.encode({
          'point': rating,
        }),
      );

      print('Puanlama yanıtı: ${response.statusCode}');
      print('Puanlama yanıt gövdesi: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Puanlama kaydedilemedi: ${response.statusCode}');
      }
    } catch (e) {
      print('Puanlama hatası: $e');
      rethrow;
    }
  }

  // Mekan önerilerini getirme
  Future<List<dynamic>> getPlaceRecommendations() async {
    try {
      final userId = await getUserId();
      if (userId == null) {
        throw Exception('Kullanıcı girişi yapılmamış');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/placerecommendation/user/$userId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // Resim URL'lerini imgproxy üzerinden alacak şekilde dönüştür
        return data.map((place) {
          if (place['placeImage'] != null &&
              place['placeImage'].toString().startsWith('http')) {
            final encodedUrl =
                base64Url.encode(utf8.encode(place['placeImage']));
            place['placeImage'] =
                'https://wsrv.nl/?url=${place['placeImage']}&output=webp';
          }
          return place;
        }).toList();
      } else {
        throw Exception('Öneriler alınamadı: ${response.statusCode}');
      }
    } catch (e) {
      print('Öneriler alınırken hata oluştu: $e');
      rethrow;
    }
  }
}
