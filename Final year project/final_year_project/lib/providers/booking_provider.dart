import 'package:flutter/material.dart';
import '../models/booking_model.dart';

class BookingProvider extends ChangeNotifier {
  List<BookingModel> _bookings = [];
  bool _isLoading = false;

  List<BookingModel> get bookings => _bookings;
  bool get isLoading => _isLoading;

  // Initialize bookings (in a real app, this would fetch from an API or local storage)
  Future<void> initializeBookings() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock booking data
    _bookings = [
      BookingModel(
        id: '1',
        roomId: '1',
        roomName: 'Deluxe Room',
        roomImage: 'assets/images/room1.jpg',
        checkInDate: DateTime.now().add(const Duration(days: 2)),
        checkOutDate: DateTime.now().add(const Duration(days: 4)),
        totalPrice: 299.99,
        status: 'confirmed',
        paymentMethod: 'Mobile Money',
        bookingReference: 'BK123456',
      ),
      BookingModel(
        id: '2',
        roomId: '2',
        roomName: 'Suite Room',
        roomImage: 'assets/images/room2.jpg',
        checkInDate: DateTime.now().add(const Duration(days: 7)),
        checkOutDate: DateTime.now().add(const Duration(days: 9)),
        totalPrice: 499.99,
        status: 'pending',
        paymentMethod: 'Credit Card',
        bookingReference: 'BK789012',
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  // Add a new booking
  Future<void> addBooking(BookingModel booking) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    _bookings.add(booking);
    _isLoading = false;
    notifyListeners();
  }

  // Cancel a booking
  Future<void> cancelBooking(String bookingId) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    final index = _bookings.indexWhere((booking) => booking.id == bookingId);
    if (index != -1) {
      final booking = _bookings[index];
      _bookings[index] = BookingModel(
        id: booking.id,
        roomId: booking.roomId,
        roomName: booking.roomName,
        roomImage: booking.roomImage,
        checkInDate: booking.checkInDate,
        checkOutDate: booking.checkOutDate,
        totalPrice: booking.totalPrice,
        status: 'cancelled',
        paymentMethod: booking.paymentMethod,
        bookingReference: booking.bookingReference,
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  // Get booking by ID
  BookingModel? getBookingById(String bookingId) {
    try {
      return _bookings.firstWhere((booking) => booking.id == bookingId);
    } catch (e) {
      return null;
    }
  }
}
