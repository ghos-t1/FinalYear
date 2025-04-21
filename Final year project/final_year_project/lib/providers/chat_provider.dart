import 'package:flutter/material.dart';
import '../models/chat_message.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatMessage> _messages = [];
  bool _isLoading = false;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  // Initialize chat with a welcome message
  Future<void> initializeChat() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    _messages = [
      ChatMessage(
        text: "Hello! I'm your virtual assistant. How can I help you today?",
        isUser: false,
        timestamp: DateTime.now(),
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  // Send a message and get a response
  Future<void> sendMessage(String text) async {
    // Add user message
    _messages.add(
      ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();

    // Simulate typing delay
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    // Generate response based on keywords
    final response = _generateResponse(text);

    // Add bot response
    _messages.add(
      ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );

    _isLoading = false;
    notifyListeners();
  }

  // Generate a response based on user message
  String _generateResponse(String userMessage) {
    final message = userMessage.toLowerCase();

    if (message.contains('book') || message.contains('reservation')) {
      return "To make a booking, please select your preferred room type and dates from our room details page. You can pay using either credit card or mobile money.";
    } else if (message.contains('price') || message.contains('cost')) {
      return "Our room prices range from 450 GH₵ to 670 GH₵ per night. Please check the room details page for specific pricing.";
    } else if (message.contains('cancel') || message.contains('refund')) {
      return "We offer free cancellation up to 24 hours before check-in. After that, a fee may apply. Please contact our support team for specific cases.";
    } else if (message.contains('amenities') ||
        message.contains('facilities')) {
      return "We offer various amenities including:\n• 5-Star Luxury Rooms\n• Fine Dining\n• Swimming Pool\n• Spa & Wellness\n• Free WiFi\n• Free Parking";
    } else if (message.contains('location') || message.contains('address')) {
      return "We have branches in:\n• East Legon, Accra\n• Ahodwo, Kumasi\n• Airport Ridge, Takoradi\n• Sowutuom, Accra";
    } else if (message.contains('hello') ||
        message.contains('hi') ||
        message.contains('hey')) {
      return "Hello! How can I assist you today?";
    } else if (message.contains('thank')) {
      return "You're welcome! Is there anything else I can help you with?";
    } else {
      return "I'm here to help! You can ask me about:\n• Booking a room\n• Room prices\n• Cancellation policy\n• Hotel amenities\n• Branch locations";
    }
  }
}
