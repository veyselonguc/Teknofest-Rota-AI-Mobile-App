import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://localhost:5070';

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'passwordHash':
              password, // Not: Gerçek uygulamada şifreyi hash'lemeniz gerekir
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Kayıt işlemi başarısız: ${response.body}');
      }
    } catch (e) {
      throw Exception('Kayıt işlemi sırasında bir hata oluştu: $e');
    }
  }

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Login Response: $responseData'); // Debug log

        // Kullanıcı bilgilerini al
        final userResponse = await http.get(
          Uri.parse('$baseUrl/api/auth/users'),
          headers: {'Content-Type': 'application/json'},
        );

        print('User Response Status: ${userResponse.statusCode}'); // Debug log
        print('User Response Body: ${userResponse.body}'); // Debug log

        if (userResponse.statusCode == 200) {
          final users = jsonDecode(userResponse.body) as List;
          final user = users.firstWhere(
            (user) => user['username'] == username,
            orElse: () => null,
          );

          if (user != null) {
            return {
              'userId': user['id'],
              'username': user['username'],
              'mail': user['email'],
            };
          } else {
            throw Exception('Kullanıcı bulunamadı');
          }
        } else {
          throw Exception(
              'Kullanıcı bilgileri alınamadı: ${userResponse.body}');
        }
      } else {
        throw Exception('Giriş işlemi başarısız: ${response.body}');
      }
    } catch (e) {
      throw Exception('Giriş işlemi sırasında bir hata oluştu: $e');
    }
  }
}
