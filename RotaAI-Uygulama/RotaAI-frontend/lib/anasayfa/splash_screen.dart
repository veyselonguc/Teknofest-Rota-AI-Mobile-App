import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../auth/login_page.dart';
import '../onboarding/visit_question_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _sloganAnimation;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _sloganAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeInOut),
      ),
    );

    _controller.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _checkAuth();
      });
    });
  }

  Future<void> _checkAuth() async {
    try {
      final userId = await _apiService.getUserId();
      if (userId != null) {
        print('Kullanıcı girişi yapılmış, userId: $userId');
        Navigator.pushReplacementNamed(context, '/visit');
      } else {
        print('Kullanıcı girişi yapılmamış');
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      print('Auth kontrolü sırasında hata: $e');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              // Dekoratif arka plan elementleri
              Positioned(
                top: -100,
                right: -100,
                child: Transform.rotate(
                  angle: -0.2,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF4A90E2).withOpacity(0.05),
                          const Color(0xFF4A90E2).withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(150),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -150,
                left: -100,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF4A90E2).withOpacity(0.05),
                        const Color(0xFF4A90E2).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
              ),
              // Ana içerik
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo animasyonu
                    Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: SizedBox(
                            width: 380,
                            height: 380,
                            child: Image.asset(
                              'assets/images/logomuz.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Slogan
                    FadeTransition(
                      opacity: _sloganAnimation,
                      child: Column(
                        children: [
                          Text(
                            "Türkiye ve KKTC'yi Keşfet",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1E3D59),
                              letterSpacing: 1.2,
                              shadows: [
                                Shadow(
                                  color:
                                      const Color(0xFF1E3D59).withOpacity(0.2),
                                  offset: const Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Yapay Zeka ile Kişisel Rotanı Oluştur",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
