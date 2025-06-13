import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  bool _isNotificationsEnabled = true;
  String _selectedLanguage = 'Türkçe';
  double _textSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Uygulama Ayarları',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.8),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle('Görünüm Ayarları'),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildSwitchTile(
                    'Karanlık Mod',
                    'Koyu renk teması kullan',
                    Icons.dark_mode_outlined,
                    _isDarkMode,
                    (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                    },
                  ),
                  _buildDivider(),
                  _buildSliderTile(
                    'Yazı Boyutu',
                    'Uygulama genelinde yazı boyutunu ayarla',
                    Icons.text_fields,
                    _textSize,
                    12.0,
                    20.0,
                    (value) {
                      setState(() {
                        _textSize = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Bildirim Ayarları'),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildSwitchTile(
                'Bildirimleri Aç',
                'Uygulama bildirimlerini al',
                Icons.notifications_outlined,
                _isNotificationsEnabled,
                (value) {
                  setState(() {
                    _isNotificationsEnabled = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Dil Ayarları'),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildLanguageOption('Türkçe'),
                  _buildDivider(),
                  _buildLanguageOption('English'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Uygulama Bilgileri'),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildInfoTile(
                    'Versiyon',
                    'v1.0.0',
                    Icons.info_outline,
                  ),
                  _buildDivider(),
                  _buildActionTile(
                    'Gizlilik Politikası',
                    'Gizlilik politikamızı inceleyin',
                    Icons.privacy_tip_outlined,
                    () {},
                  ),
                  _buildDivider(),
                  _buildActionTile(
                    'Kullanım Koşulları',
                    'Kullanım koşullarını inceleyin',
                    Icons.description_outlined,
                    () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildSliderTile(
    String title,
    String subtitle,
    IconData icon,
    double value,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(icon, color: Theme.of(context).primaryColor),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 8,
          label: value.toStringAsFixed(1),
          onChanged: onChanged,
          activeColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Widget _buildLanguageOption(String language) {
    return RadioListTile<String>(
      title: Text(language),
      value: language,
      groupValue: _selectedLanguage,
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value!;
        });
      },
      activeColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildInfoTile(
    String title,
    String subtitle,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Theme.of(context).primaryColor,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      indent: 56,
      color: Theme.of(context).primaryColor.withOpacity(0.1),
    );
  }
}
