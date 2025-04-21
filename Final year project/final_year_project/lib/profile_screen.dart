import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'widgets/app_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop) async {
        if (!didPop) {
          Navigator.pushReplacementNamed(context, '/home');
        }
        return true;
      } as PopInvokedWithResultCallback<dynamic>,
      child: Scaffold(
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
            'Profile',
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
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xff4a154b),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Color(0xff4a154b),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'John Doe',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'john.doe@example.com',
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(204),
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Edit profile
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(0xff4a154b),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text('Edit Profile'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: const Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4a154b),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoSection(),
                    const SizedBox(height: 24),
                    FadeInUp(
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
                    _buildPreferencesSection(),
                    const SizedBox(height: 24),
                    FadeInUp(
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
                    _buildSettingsSection(context),
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
      ),
    );
  }

  Widget _buildInfoSection() {
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
        children: [
          _buildInfoTile(
            icon: Icons.phone,
            title: 'Phone Number',
            value: '+233 24 123 4567',
          ),
          const Divider(),
          _buildInfoTile(
            icon: Icons.location_on,
            title: 'Address',
            value: '123 Main Street, Accra',
          ),
          const Divider(),
          _buildInfoTile(
            icon: Icons.calendar_today,
            title: 'Member Since',
            value: 'January 2024',
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
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
        children: [
          _buildPreferenceTile(
            icon: Icons.notifications,
            title: 'Notifications',
            value: 'Enabled',
          ),
          const Divider(),
          _buildPreferenceTile(
            icon: Icons.language,
            title: 'Language',
            value: 'English',
          ),
          const Divider(),
          _buildPreferenceTile(
            icon: Icons.attach_money,
            title: 'Currency',
            value: 'Ghana Cedis (GH₵)',
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
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
        children: [
          _buildSettingTile(
            icon: Icons.lock,
            title: 'Change Password',
            onTap: () {
              // Navigate to change password
            },
          ),
          const Divider(),
          _buildSettingTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              Navigator.pushNamed(context, '/help');
            },
          ),
          const Divider(),
          _buildSettingTile(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          const Divider(),
          _buildSettingTile(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              // Handle logout
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xff4a154b),
      ),
      title: Text(title),
      subtitle: Text(value),
    );
  }

  Widget _buildPreferenceTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xff4a154b),
      ),
      title: Text(title),
      trailing: Text(
        value,
        style: TextStyle(
          color: Colors.grey.withAlpha(26),
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xff4a154b),
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
