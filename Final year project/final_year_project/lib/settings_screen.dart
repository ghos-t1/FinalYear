import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'widgets/app_drawer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'Ghana Cedis (GH₵)';
  bool _isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4a154b),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            setState(() {
              _isDrawerOpen = !_isDrawerOpen;
            });
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 500),
                    child: const Text(
                      'Account Settings',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4a154b),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingSection(
                    'Profile',
                    [
                      _buildSettingTile(
                        icon: Icons.person,
                        title: 'Edit Profile',
                        onTap: () {
                          // Navigate to edit profile
                        },
                      ),
                      _buildSettingTile(
                        icon: Icons.lock,
                        title: 'Change Password',
                        onTap: () {
                          // Navigate to change password
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  FadeInDown(
                    duration: const Duration(milliseconds: 500),
                    child: const Text(
                      'Preferences',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4a154b),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingSection(
                    'App Settings',
                    [
                      _buildSwitchTile(
                        icon: Icons.notifications,
                        title: 'Push Notifications',
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            _notificationsEnabled = value;
                          });
                        },
                      ),
                      _buildSwitchTile(
                        icon: Icons.dark_mode,
                        title: 'Dark Mode',
                        value: _darkModeEnabled,
                        onChanged: (value) {
                          setState(() {
                            _darkModeEnabled = value;
                          });
                        },
                      ),
                      _buildDropdownTile(
                        icon: Icons.language,
                        title: 'Language',
                        value: _selectedLanguage,
                        items: ['English', 'French', 'Twi', 'Ga'],
                        onChanged: (value) {
                          setState(() {
                            _selectedLanguage = value!;
                          });
                        },
                      ),
                      _buildDropdownTile(
                        icon: Icons.attach_money,
                        title: 'Currency',
                        value: _selectedCurrency,
                        items: [
                          'Ghana Cedis (GH₵)',
                          'US Dollars (\$)',
                          'Euros (€)'
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedCurrency = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  FadeInDown(
                    duration: const Duration(milliseconds: 500),
                    child: const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4a154b),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingSection(
                    'App Information',
                    [
                      _buildSettingTile(
                        icon: Icons.info,
                        title: 'Version',
                        subtitle: '1.0.0',
                      ),
                      _buildSettingTile(
                        icon: Icons.description,
                        title: 'Terms of Service',
                        onTap: () {
                          // Navigate to terms
                        },
                      ),
                      _buildSettingTile(
                        icon: Icons.privacy_tip,
                        title: 'Privacy Policy',
                        onTap: () {
                          // Navigate to privacy policy
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AppDrawer(
            isOpen: _isDrawerOpen,
            onClose: () {
              setState(() {
                _isDrawerOpen = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingSection(String title, List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(26),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: items,
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xff4a154b),
      ),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: onTap != null
          ? const Icon(Icons.chevron_right, color: Colors.grey)
          : null,
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xff4a154b),
      ),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xff4a154b),
      ),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xff4a154b),
      ),
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        underline: Container(),
      ),
    );
  }
}
