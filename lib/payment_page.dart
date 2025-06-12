import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;
  final TextEditingController _upiController = TextEditingController();

  @override
  void dispose() {
    _upiController.dispose();
    super.dispose();
  }

  @override
  Widget _buildTimerSection() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.timer, color: Colors.red),
      SizedBox(width: 8),
      Text("Complete payment in 10:00 minutes"),
    ],
  );
}

Widget _buildPaymentOptions() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Select Payment Method", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ListTile(
        title: const Text("Credit/Debit Card"),
        leading: Radio<String>(
          value: 'card',
          groupValue: selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              selectedPaymentMethod = value;
            });
          },
        ),
      ),
      ListTile(
        title: const Text("UPI"),
        leading: Radio<String>(
          value: 'upi',
          groupValue: selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              selectedPaymentMethod = value;
            });
          },
        ),
      ),
      if (selectedPaymentMethod == 'upi') ...[
        const SizedBox(height: 10),
        TextField(
          controller: _upiController,
          decoration: const InputDecoration(
            labelText: "Enter UPI ID",
            border: OutlineInputBorder(),
          ),
        ),
      ],
    ],
  );
}

Widget _buildPriceDetails() {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Price Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Subtotal"),
          Text("₹1000"),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Tax"),
          Text("₹50"),
        ],
      ),
      Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("₹1050", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    ],
  );
}

Widget _buildSecurityInfo() {
  return const Row(
    children: [
      Icon(Icons.lock, color: Colors.green),
      SizedBox(width: 8),
      Expanded(child: Text("Your transaction is secured and encrypted.")),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Options'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimerSection(),
              const SizedBox(height: 20),
              _buildPaymentOptions(),
              const SizedBox(height: 20),
              _buildPriceDetails(),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: selectedPaymentMethod != null ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment processed successfully')),
                    );
                  } : null,
                  child: const Text(
                    'PAY NOW',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildSecurityInfo(),
            ],
          ),
        ),
      ),
    );
  }

  // [Rest of your payment page methods]
}
