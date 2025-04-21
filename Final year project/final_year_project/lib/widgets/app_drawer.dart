import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onClose;

  const AppDrawer({
    super.key,
    required this.isOpen,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isOpen)
          GestureDetector(
            onTap: onClose,
            child: Container(
              color: Colors.black.withAlpha(128),
            ),
          ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          left: isOpen ? 0 : -300,
          top: 0,
          bottom: 0,
          width: 300,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color(0xff4a154b),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 35,
                          color: Color(0xff4a154b),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'John Doe',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'john.doe@example.com',
                        style: TextStyle(
                          color: Colors.white.withAlpha(204),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildDrawerItem(context, Icons.home, 'Home', '/home'),
                      _buildDrawerItem(
                          context, Icons.bookmark, 'My Bookings', '/bookings'),
                      _buildDrawerItem(
                          context, Icons.person, 'Profile', '/profile'),
                      _buildDrawerItem(
                          context, Icons.settings, 'Settings', '/settings'),
                      _buildDrawerItem(
                          context, Icons.help, 'Help & Support', '/help'),
                      const Divider(),
                      _buildDrawerItem(
                          context, Icons.logout, 'Logout', '/auth'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String label, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }
}
