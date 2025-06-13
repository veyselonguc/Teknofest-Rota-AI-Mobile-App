import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/models.dart';

class ApiProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String? _error;
  List<Map<String, dynamic>> _cities = [];
  List<Map<String, dynamic>> _places = [];
  List<Map<String, dynamic>> _visitHistory = [];
  List<Map<String, dynamic>> _recommendations = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Map<String, dynamic>> get cities => _cities;
  List<Map<String, dynamic>> get places => _places;
  List<Map<String, dynamic>> get visitHistory => _visitHistory;
  List<Map<String, dynamic>> get recommendations => _recommendations;

  Future<T> _handleRequest<T>(Future<T> Function() request) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      final result = await request();
      return result;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    return await _handleRequest(() => _apiService.login(email, password));
  }

  Future<Map<String, dynamic>> register(
      String username, String email, String password) async {
    return await _handleRequest(
        () => _apiService.register(username, email, password));
  }

  Future<void> getCities() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getCities();
      _cities = List<Map<String, dynamic>>.from(response);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getPlacesByCity(int cityId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getPlacesByCity(cityId);
      _places = List<Map<String, dynamic>>.from(response);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Place> getPlaceDetails(int placeId) async {
    final response =
        await _handleRequest(() => _apiService.getPlaceDetails(placeId));
    return Place.fromJson(response);
  }

  Future<int?> getUserId() async {
    return await _apiService.getUserId();
  }

  Future<void> saveVisitedPlace(int userId, int placeId) async {
    try {
      await _handleRequest(() => _apiService.saveVisitedPlace(placeId));
    } catch (e) {
      print('Ziyaret kaydetme hatası: $e');
      rethrow;
    }
  }

  Future<List<dynamic>> getVisitedPlaces() async {
    try {
      return await _handleRequest(() => _apiService.getVisitHistory());
    } catch (e) {
      print('Ziyaret geçmişi getirme hatası: $e');
      rethrow;
    }
  }

  Future<void> savePlaceRating(int placeId, int rating) async {
    try {
      await _handleRequest(() => _apiService.savePlaceRating(placeId, rating));
    } catch (e) {
      print('Puanlama hatası: $e');
      rethrow;
    }
  }

  Future<void> getVisitHistory() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getVisitHistory();
      _visitHistory = List<Map<String, dynamic>>.from(response);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Mekan önerilerini getirme
  Future<void> getPlaceRecommendations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getPlaceRecommendations();
      _recommendations = List<Map<String, dynamic>>.from(response);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
