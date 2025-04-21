import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'widgets/app_drawer.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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
          'Help & Support',
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Need Help?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'We\'re here to help you with any questions or concerns',
                            style: TextStyle(
                              color: Colors.white.withAlpha(204),
                              fontSize: 16,
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
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4a154b),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContactSection(),
                  const SizedBox(height: 24),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: const Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4a154b),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFAQSection(),
                  const SizedBox(height: 24),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: const Text(
                      'Support Options',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4a154b),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSupportSection(),
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

  Widget _buildContactSection() {
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
          _buildContactTile(
            icon: Icons.phone,
            title: 'Call Us',
            subtitle: '+233 24 123 4567',
            onTap: () {
              // Handle phone call
            },
          ),
          const Divider(),
          _buildContactTile(
            icon: Icons.email,
            title: 'Email Us',
            subtitle: 'support@northworldhotel.com',
            onTap: () {
              // Handle email
            },
          ),
          const Divider(),
          _buildContactTile(
            icon: Icons.chat,
            title: 'Live Chat',
            subtitle: 'Available 24/7',
            onTap: () {
              // Handle live chat
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
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
          _buildFAQTile(
            question: 'How do I make a booking?',
            answer:
                'To make a booking, select your preferred room type, choose your dates, and follow the booking process. You can pay using either credit card or mobile money.',
          ),
          const Divider(),
          _buildFAQTile(
            question: 'What is your cancellation policy?',
            answer:
                'We offer free cancellation up to 24 hours before check-in. After that, a fee may apply.',
          ),
          const Divider(),
          _buildFAQTile(
            question: 'What payment methods do you accept?',
            answer:
                'We accept credit/debit cards and mobile money payments through MTN, Vodafone, and AirtelTigo.',
          ),
          const Divider(),
          _buildFAQTile(
            question: 'What are your check-in and check-out times?',
            answer: 'Check-in is from 2:00 PM and check-out is until 12:00 PM.',
          ),
        ],
      ),
    );
  }

  Widget _buildSupportSection() {
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
          _buildSupportTile(
            icon: Icons.feedback,
            title: 'Send Feedback',
            onTap: () {
              // Handle feedback
            },
          ),
          const Divider(),
          _buildSupportTile(
            icon: Icons.report_problem,
            title: 'Report an Issue',
            onTap: () {
              // Handle issue report
            },
          ),
          const Divider(),
          _buildSupportTile(
            icon: Icons.help_outline,
            title: 'Browse Help Center',
            onTap: () {
              // Navigate to help center
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xff4a154b),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildFAQTile({
    required String question,
    required String answer,
  }) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            answer,
            style: TextStyle(
              color: Colors.grey.withAlpha(26),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupportTile({
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
