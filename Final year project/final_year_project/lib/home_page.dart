import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'widgets/app_drawer.dart';
import 'room_details_screen.dart';

// Main home page displaying hotel information and branches
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Track selected bottom navigation item
  int _selectedIndex = 0;
  bool _isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    // Check if we're on a desktop-sized screen
    final isDesktop = MediaQuery.of(context).size.width >= 1200;

    return Scaffold(
      backgroundColor: const Color(0xfff8f9fd),
      // Custom app bar with hotel logo and logout button
      appBar: isDesktop
          ? null
          : AppBar(
              backgroundColor: const Color(0xff4a154b),
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _isDrawerOpen = !_isDrawerOpen;
                  });
                },
              ),
              title: Row(
                children: [
                  const Text(
                    'North World Hotel',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/chat'),
        backgroundColor: const Color(0xff4a154b),
        child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
      ),
      body: Row(
        children: [
          // Side Navigation for Desktop
          if (isDesktop)
            Container(
              width: 250,
              color: const Color(0xff4a154b),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        const Text(
                          'North World Hotel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildNavItem(Icons.home, 'Home', 0),
                  _buildNavItem(Icons.history, 'Bookings', 1),
                  _buildNavItem(Icons.person, 'Profile', 2),
                  _buildNavItem(Icons.settings, 'Settings', 3),
                  _buildNavItem(Icons.help_outline, 'Help', 4),
                  const Spacer(),
                  _buildNavItem(Icons.logout, 'Logout', -1),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          // Main Content
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hero Section
                      Container(
                        height: isDesktop ? 500 : 300,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/hotel_hero.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(179),
                              ],
                            ),
                          ),
                          padding: EdgeInsets.all(isDesktop ? 48 : 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInDown(
                                duration: const Duration(milliseconds: 500),
                                child: const Text(
                                  'Welcome to Hotel App',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                child: const Text(
                                  'Find your perfect stay',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Content Sections
                      Padding(
                        padding: EdgeInsets.all(isDesktop ? 48 : 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Branch locations section
                            FadeInDown(
                              duration: const Duration(milliseconds: 500),
                              child: const Text(
                                'Our Branches',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff4a154b),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Grid of branch cards
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.75,
                              children: [
                                _buildBranchCard(
                                  'East Legon',
                                  'Accra',
                                  '5-star luxury in the heart of Accra',
                                  'assets/images/homepage1.jpg',
                                ),
                                _buildBranchCard(
                                  'Ahodwo',
                                  'Kumasi',
                                  'Modern comfort in the Garden City',
                                  'assets/images/homepage1.jpg',
                                ),
                                _buildBranchCard(
                                  'Airport Ridge',
                                  'Takoradi',
                                  'Beachfront luxury in the Oil City',
                                  'assets/images/homepage1.jpg',
                                ),
                                _buildBranchCard(
                                  'Sowutuom',
                                  'Accra',
                                  'Northern hospitality at its finest',
                                  'assets/images/homepage1.jpg',
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            // Features section
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              child: const Text(
                                'Why Choose Us',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff4a154b),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildFeaturesList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Drawer for mobile/tablet
                if (!isDesktop)
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
        ],
      ),
      // Bottom Navigation for mobile/tablet
      bottomNavigationBar: !isDesktop
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                // Navigate based on index
                switch (index) {
                  case 0: // Home
                    Navigator.pushReplacementNamed(context, '/home');
                    break;
                  case 1: // Bookings
                    Navigator.pushReplacementNamed(context, '/bookings');
                    break;
                  case 2: // Profile
                    Navigator.pushReplacementNamed(context, '/profile');
                    break;
                }
              },
              selectedItemColor: const Color(0xff4a154b),
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'Bookings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        // Navigate based on index
        switch (index) {
          case 0: // Home
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1: // Bookings
            Navigator.pushReplacementNamed(context, '/bookings');
            break;
          case 2: // Profile
            Navigator.pushReplacementNamed(context, '/profile');
            break;
          case 3: // Settings
            Navigator.pushReplacementNamed(context, '/settings');
            break;
          case 4: // Help
            Navigator.pushReplacementNamed(context, '/help');
            break;
          case -1: // Logout
            Navigator.pushReplacementNamed(context, '/auth');
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: isSelected ? Colors.white.withAlpha(26) : Colors.transparent,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchCard(
      String title, String location, String description, String imagePath) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomDetailsScreen(
                location: title,
                city: location,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(51),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4a154b),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        location,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.withAlpha(153),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.withAlpha(153),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {
        'icon': Icons.star,
        'title': '5-Star Luxury',
        'description': 'Experience world-class comfort'
      },
      {
        'icon': Icons.restaurant,
        'title': 'Fine Dining',
        'description': 'International and local cuisine'
      },
      {
        'icon': Icons.pool,
        'title': 'Swimming Pool',
        'description': 'Relax in our infinity pools'
      },
      {
        'icon': Icons.spa,
        'title': 'Spa & Wellness',
        'description': 'Rejuvenate your senses'
      },
      {
        'icon': Icons.wifi,
        'title': 'Free WiFi',
        'description': 'Stay connected throughout'
      },
      {
        'icon': Icons.local_parking,
        'title': 'Free Parking',
        'description': 'Secure parking available'
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: index * 100),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(51),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  features[index]['icon'] as IconData,
                  color: const Color(0xff4a154b).withAlpha(128),
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  features[index]['title'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4a154b),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  features[index]['description'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.withAlpha(102),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
