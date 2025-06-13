import 'package:flutter/material.dart';

class AppDialogs {
  // Yardım Dialog Penceresi
  static void showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.help_outline,
                size: 48,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 16),
              const Text(
                'Nasıl Kullanılır?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                '1. Öncelikle nasıl hissettiğinizi seçin\n'
                '2. Ziyaret etmek istediğiniz ülkeyi seçin\n'
                '3. Size özel rotalar oluşturulacak\n'
                '4. Rotaları inceleyip size en uygun olanı seçin',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  'Anladım',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bilgi Dialog Penceresi
  static void showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.info_outline,
                size: 48,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 16),
              const Text(
                'Uygulama Hakkında',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'ROTA AI, yapay zeka destekli kişiselleştirilmiş seyahat rotaları oluşturan bir uygulamadır. Ruh halinize ve tercihlerinize göre size özel rotalar sunar.\n\n'
                'Versiyon: 1.0.0\n'
                'Geliştirici: ROTA AI Ekibi',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  'Kapat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bildirim Dialog Penceresi
  static void showNotificationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxHeight: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bildirimler',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Sadece dialog penceresini kapat
                    },
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  children: [
                    _buildNotificationItem(
                      context,
                      'Yeni Rota Önerisi!',
                      'Size özel yeni rotalar oluşturuldu.',
                      '2 saat önce',
                      Icons.route,
                    ),
                    _buildNotificationItem(
                      context,
                      'Hoş Geldiniz!',
                      'ROTA AI\'ya hoş geldiniz. Hemen keşfe başlayın.',
                      '1 gün önce',
                      Icons.celebration,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Profil Dialog Penceresi
  static void showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Kullanıcı Adı',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'kullanici@email.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              _buildProfileButton(
                context,
                'Profili Düzenle',
                Icons.edit,
                () {
                  // Profil düzenleme sayfasına yönlendirme
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 8),
              _buildProfileButton(
                context,
                'Ayarlar',
                Icons.settings,
                () {
                  // Ayarlar sayfasına yönlendirme
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 8),
              _buildProfileButton(
                context,
                'Çıkış Yap',
                Icons.exit_to_app,
                () {
                  // Çıkış işlemleri
                  Navigator.pop(context);
                },
                isLogout: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bildirim öğesi widget'ı
  static Widget _buildNotificationItem(
    BuildContext context,
    String title,
    String message,
    String time,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(message),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Profil butonu widget'ı
  static Widget _buildProfileButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onPressed, {
    bool isLogout = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isLogout ? Colors.red : Theme.of(context).primaryColor,
            ),
          ),
          foregroundColor:
              isLogout ? Colors.red : Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
