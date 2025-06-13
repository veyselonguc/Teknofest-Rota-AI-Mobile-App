import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ornek003/anasayfa/baslik_kismi.dart';
import 'package:ornek003/anasayfa/bunu_biliyor_muydunuz.dart';
import 'package:ornek003/dialogs/app_dialogs.dart';
import 'package:ornek003/anasayfa/duygu_durumlari.dart';
import 'package:ornek003/oneri/oneriCalistir.dart' as oneri;
import 'package:ornek003/anasayfa/menu.dart';
import 'package:ornek003/anasayfa/nasil_hissediyorsun.dart';
import 'package:ornek003/anasayfa/splash_screen.dart';
import 'package:ornek003/anasayfa/ulke_secim_butonlari.dart';
import 'package:ornek003/anasayfa/ulke_secim_metni.dart';
import 'package:ornek003/auth/login_page.dart';
import 'package:ornek003/auth/register_page.dart';
import 'package:ornek003/onboarding/visit_question_page.dart';
import 'package:ornek003/providers/user_provider.dart';
import 'package:ornek003/providers/api_provider.dart';
import 'package:ornek003/onboarding/city_selection_page.dart';
import 'package:ornek003/onboarding/visit_history_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ApiProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ROTA AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1E3D59),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3D59),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/visit': (context) => const VisitQuestionPage(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/question2': (context) => const oneri.QuestionPage2(),
        '/question3': (context) => const oneri.QuestionPage3(),
        '/recommendations': (context) => const oneri.RecommendationsPage(),
        '/moreSuggestions': (context) => const oneri.MoreSuggestionsPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildInfoRow(
      BuildContext context, IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.white,
            height: 1.0,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu, color: Colors.white, size: 28),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.white, size: 28),
                onPressed: () => AppDialogs.showNotificationsDialog(context),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon:
                const Icon(Icons.person_outline, color: Colors.white, size: 28),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person_outline,
                          color: Theme.of(context).primaryColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Profil Bilgileri',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  content: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (userProvider.isLoggedIn) ...[
                          _buildInfoRow(
                            context,
                            Icons.person,
                            'Kullanıcı Adı',
                            userProvider.username ?? '',
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            context,
                            Icons.email_outlined,
                            'E-posta',
                            userProvider.email ?? '',
                          ),
                          const SizedBox(height: 16),
                        ],
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VisitHistoryPage(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.history,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Geçmiş Ziyaretlerim',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (!userProvider.isLoggedIn) ...[
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/login');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            child: const Text('Giriş Yap'),
                          ),
                        ],
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Kapat',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white, size: 28),
            onPressed: () => AppDialogs.showHelpDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white, size: 28),
            onPressed: () => AppDialogs.showInfoDialog(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: const Menu(),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.8),
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      BaslikKismi(),
                      NasilHissediyorsun(),
                      DuyguDurumuButonlari(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  UlkeSecimMetni(),
                  UlkeSecimButonlari(),
                  BunuBiliyorMuydunuz(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
