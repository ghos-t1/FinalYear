class BookingModel {
  final String id;
  final String roomId;
  final String roomName;
  final String roomImage;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final double totalPrice;
  final String status; // 'confirmed', 'pending', 'cancelled'
  final String paymentMethod;
  final String bookingReference;

  BookingModel({
    required this.id,
    required this.roomId,
    required this.roomName,
    required this.roomImage,
    required this.checkInDate,
    required this.checkOutDate,
    required this.totalPrice,
    required this.status,
    required this.paymentMethod,
    required this.bookingReference,
  });

  // Convert booking data to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roomId': roomId,
      'roomName': roomName,
      'roomImage': roomImage,
      'checkInDate': checkInDate.toIso8601String(),
      'checkOutDate': checkOutDate.toIso8601String(),
      'totalPrice': totalPrice,
      'status': status,
      'paymentMethod': paymentMethod,
      'bookingReference': bookingReference,
    };
  }

  // Create a booking from a map
  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] ?? '',
      roomId: map['roomId'] ?? '',
      roomName: map['roomName'] ?? '',
      roomImage: map['roomImage'] ?? '',
      checkInDate: DateTime.parse(map['checkInDate']),
      checkOutDate: DateTime.parse(map['checkOutDate']),
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      status: map['status'] ?? 'pending',
      paymentMethod: map['paymentMethod'] ?? '',
      bookingReference: map['bookingReference'] ?? '',
    );
  }
}
