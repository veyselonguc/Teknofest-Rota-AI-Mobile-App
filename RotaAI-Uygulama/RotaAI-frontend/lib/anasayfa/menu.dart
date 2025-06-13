import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ornek003/auth/login_page.dart';
import 'package:ornek003/auth/register_page.dart';
import 'package:ornek003/settings/settings_page.dart';
import 'package:ornek003/support/support_page.dart';
import 'package:ornek003/providers/user_provider.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.95),
              Colors.white,
              Colors.white,
            ],
            stops: const [0.0, 0.3, 0.3, 1.0],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                      ),
                      child: const Icon(
                        Icons.travel_explore,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    userProvider.isLoggedIn
                        ? 'Hoş Geldiniz, ${userProvider.username}!'
                        : 'Hoş Geldiniz!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userProvider.isLoggedIn
                        ? userProvider.email ?? ''
                        : 'Seyahat planınızı birlikte yapalım',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(height: 32),
                    if (!userProvider.isLoggedIn)
                      _buildMenuSection(
                        title: 'HESAP',
                        items: [
                          MenuItem(
                            icon: Icons.person_outline,
                            title: 'Giriş Yap',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                          ),
                          MenuItem(
                            icon: Icons.person_add_outlined,
                            title: 'Kayıt Ol',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                          ),
                        ],
                        context: context,
                      ),
                    const SizedBox(height: 24),
                    _buildMenuSection(
                      title: 'AYARLAR',
                      items: [
                        MenuItem(
                          icon: Icons.settings_outlined,
                          title: 'Uygulama Ayarları',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsPage(),
                              ),
                            );
                          },
                        ),
                        MenuItem(
                          icon: Icons.feedback_outlined,
                          title: 'Destek ve Öneri',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SupportPage(),
                              ),
                            );
                          },
                        ),
                      ],
                      context: context,
                    ),
                    const SizedBox(height: 24),
                    _buildMenuSection(
                      title: 'DİĞER',
                      items: [
                        if (userProvider.isLoggedIn)
                          MenuItem(
                            icon: Icons.logout_outlined,
                            title: 'Çıkış Yap',
                            isDestructive: true,
                            onTap: () {
                              userProvider.logout();
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                          )
                        else
                          MenuItem(
                            icon: Icons.logout_outlined,
                            title: 'Çıkış Yap',
                            isDestructive: true,
                            onTap: () => exit(0),
                          ),
                      ],
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified_outlined,
                          size: 14,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'ROTA AI v1.0.0',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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

  Widget _buildMenuSection({
    required String title,
    required List<MenuItem> items,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: items.map((item) {
              final isLast = items.last == item;
              return Column(
                children: [
                  _buildMenuItem(
                    context: context,
                    icon: item.icon,
                    title: item.title,
                    isDestructive: item.isDestructive,
                    onTap: item.onTap,
                  ),
                  if (!isLast)
                    Padding(
                      padding: const EdgeInsets.only(left: 56),
                      child: Divider(
                        height: 1,
                        color: Theme.of(context).primaryColor.withOpacity(0.05),
                      ),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    bool isDestructive = false,
    required VoidCallback onTap,
  }) {
    final color =
        isDestructive ? Colors.red[700] : Theme.of(context).primaryColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });
}
