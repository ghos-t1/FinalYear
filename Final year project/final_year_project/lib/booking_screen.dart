import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'widgets/app_drawer.dart';
import 'providers/booking_provider.dart';
import 'models/booking_model.dart';
import 'package:random_string/random_string.dart';

class BookingScreen extends StatefulWidget {
  final String roomType;
  final String location;
  final String city;
  final double price;

  const BookingScreen({
    super.key,
    required this.roomType,
    required this.location,
    required this.city,
    required this.price,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _numberOfGuests = 1;
  int _numberOfNights = 1;
  String _selectedPaymentMethod = 'card';
  String? _selectedMobileMoneyProvider;
  final _phoneController = TextEditingController();
  bool _isDrawerOpen = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4a154b),
        title: const Text(
          'Book Room',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            setState(() {
              _isDrawerOpen = !_isDrawerOpen;
            });
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(isDesktop ? 32.0 : 16.0),
              child: Form(
                key: _formKey,
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left side - Booking details
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRoomDetails(),
                                const SizedBox(height: 24),
                                _buildBookingDetails(),
                                const SizedBox(height: 24),
                                _buildPaymentSection(),
                              ],
                            ),
                          ),
                          const SizedBox(width: 32),
                          // Right side - Price summary
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                _buildPriceSummary(),
                                const SizedBox(height: 24),
                                _buildConfirmButton(),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRoomDetails(),
                          const SizedBox(height: 24),
                          _buildBookingDetails(),
                          const SizedBox(height: 24),
                          _buildPaymentSection(),
                          const SizedBox(height: 24),
                          _buildPriceSummary(),
                          const SizedBox(height: 24),
                          _buildConfirmButton(),
                        ],
                      ),
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

  Widget _buildRoomDetails() {
    return FadeInDown(
      duration: const Duration(milliseconds: 500),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(25),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.roomType,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff4a154b),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.location}, ${widget.city}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Price per night:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'GH₵ ${widget.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4a154b),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: const Text(
            'Booking Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff4a154b),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildDatePicker(
          'Check-in Date',
          _checkInDate,
          (date) => setState(() => _checkInDate = date),
        ),
        const SizedBox(height: 16),
        _buildDatePicker(
          'Check-out Date',
          _checkOutDate,
          (date) => setState(() => _checkOutDate = date),
        ),
        const SizedBox(height: 16),
        _buildNumberPicker(
          'Number of Guests',
          _numberOfGuests,
          (value) => setState(() => _numberOfGuests = value),
        ),
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff4a154b),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            children: [
              RadioListTile<String>(
                title: const Text('Credit/Debit Card'),
                value: 'card',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Mobile Money'),
                value: 'mobile_money',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
            ],
          ),
        ),
        if (_selectedPaymentMethod == 'mobile_money') ...[
          const SizedBox(height: 16),
          _buildMobileMoneySection(),
        ] else ...[
          const SizedBox(height: 16),
          _buildCardPaymentSection(),
        ],
      ],
    );
  }

  Widget _buildPriceSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(25),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Room Price'),
              Text('${widget.price} GH₵'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Number of Nights'),
              Text('$_numberOfNights'),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                '${widget.price * _numberOfNights} GH₵',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff4a154b),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Validate dates
            if (_checkInDate == null || _checkOutDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select check-in and check-out dates'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            // Validate check-out is after check-in
            if (_checkOutDate!.isBefore(_checkInDate!) ||
                _checkOutDate!.isAtSameMomentAs(_checkInDate!)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Check-out date must be after check-in date'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            // Validate mobile money selection
            if (_selectedPaymentMethod == 'mobile_money' &&
                _selectedMobileMoneyProvider == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select a mobile money provider'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            // Create a new booking
            final booking = BookingModel(
              id: randomAlphaNumeric(8),
              roomId: widget.roomType,
              roomName: widget.roomType,
              roomImage:
                  'assets/images/${widget.roomType.toLowerCase().replaceAll(' ', '_')}.jpg',
              checkInDate: _checkInDate!,
              checkOutDate: _checkOutDate!,
              totalPrice: widget.price * _numberOfNights,
              status: 'confirmed',
              paymentMethod: _selectedPaymentMethod == 'card'
                  ? 'Credit Card'
                  : 'Mobile Money',
              bookingReference: 'BK${randomAlphaNumeric(6).toUpperCase()}',
            );

            // Add booking to provider
            Provider.of<BookingProvider>(context, listen: false)
                .addBooking(booking);

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Booking successful!'),
                backgroundColor: Color(0xff4a154b),
              ),
            );

            // Navigate to bookings screen
            Navigator.pushReplacementNamed(context, '/bookings');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff4a154b),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Confirm Booking',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(
    String label,
    DateTime? date,
    Function(DateTime?) onDateSelected,
  ) {
    return InkWell(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (selectedDate != null) {
          onDateSelected(selectedDate);
          if (_checkInDate != null && _checkOutDate != null) {
            setState(() {
              _numberOfNights = _checkOutDate!.difference(_checkInDate!).inDays;
            });
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null
                  ? DateFormat('MMM dd, yyyy').format(date)
                  : 'Select $label',
              style: TextStyle(
                color: date != null ? Colors.black : Colors.grey[600],
              ),
            ),
            Icon(
              Icons.calendar_today,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberPicker(
    String label,
    int value,
    Function(int) onValueChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (value > 1) {
                    onValueChanged(value - 1);
                  }
                },
                icon: const Icon(Icons.remove_circle_outline),
                color: const Color(0xff4a154b),
              ),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (value < 4) {
                    onValueChanged(value + 1);
                  }
                },
                icon: const Icon(Icons.add_circle_outline),
                color: const Color(0xff4a154b),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileMoneySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Mobile Money Provider',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildProviderOption(
                'MTN Mobile Money',
                'mtn',
                'assets/mtn.png',
              ),
              _buildProviderOption(
                'Vodafone Cash',
                'vodafone',
                'assets/vodafone.png',
              ),
              _buildProviderOption(
                'AirtelTigo Money',
                'airteltigo',
                'assets/airteltigo.png',
              ),
            ],
          ),
          if (_selectedMobileMoneyProvider != null) ...[
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'e.g., 0241234567',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                if (value.length != 10) {
                  return 'Please enter a valid 10-digit phone number';
                }
                return null;
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCardPaymentSection() {
    return Column(
      children: [
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Card Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.credit_card),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your card number';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Expiry Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVV';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProviderOption(String name, String value, String imagePath) {
    final isSelected = _selectedMobileMoneyProvider == value;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedMobileMoneyProvider = value;
        });
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              isSelected ? const Color(0xff4a154b).withAlpha(25) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xff4a154b) : Colors.grey[300]!,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  name[0],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:
                        isSelected ? const Color(0xff4a154b) : Colors.grey[600],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xff4a154b) : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
