import 'package:flutter/material.dart';
import 'payment_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required int productPrice, required String productName, required String image, required String size});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedAddress = 0;
  bool agreeToTerms = false;
  bool showCouponField = false;
  final TextEditingController _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
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
              _buildProgressIndicator(),
              const SizedBox(height: 20),
              _buildLoginSection(),
              const SizedBox(height: 20),
              _buildDeliveryAddressSection(),
              const SizedBox(height: 20),
              _buildOrderSummary(),
              const SizedBox(height: 20),
              _buildPriceDetails(),
              const SizedBox(height: 20),
              _buildTermsAndConditions(),
              const SizedBox(height: 30),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
              const Text('Cart', style: TextStyle(color: Colors.deepPurple)),
            ],
          ),
          Expanded(
            child: Container(
                height: 2,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                color: Colors.deepPurple),
          ),
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('2', style: TextStyle(color: Colors.white)),
                ),
              ),
              const Text('Checkout', style: TextStyle(color: Colors.deepPurple)),
            ],
          ),
          Expanded(
            child: Container(
                height: 2,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                color: Colors.grey[300]),
          ),
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('3', style: TextStyle(color: Colors.white)),
                ),
              ),
              const Text('Payment', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginSection() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("John Doe",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("johndoe@example.com",
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryAddressSection() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("DELIVERY ADDRESS",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                TextButton(
                  onPressed: () {},
                  child: const Text("+ ADD NEW ADDRESS",
                      style: TextStyle(color: Colors.deepPurple)),
                ),
              ],
            ),
            const Divider(),
            RadioListTile<int>(
              value: 0,
              groupValue: selectedAddress,
              onChanged: (int? value) {
                setState(() {
                  selectedAddress = value!;
                });
              },
              title: const Text("Home",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text(
                  "123 Main Street, Apt 4B\nNew York, NY 10001\nMobile: 9876543210"),
              secondary: const Icon(Icons.home, color: Colors.deepPurple),
              controlAffinity: ListTileControlAffinity.trailing,
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(),
            RadioListTile<int>(
              value: 1,
              groupValue: selectedAddress,
              onChanged: (int? value) {
                setState(() {
                  selectedAddress = value!;
                });
              },
              title: const Text("Work",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text(
                  "456 Business Ave, Floor 10\nNew York, NY 10005\nMobile: 9876543210"),
              secondary: const Icon(Icons.work, color: Colors.green),
              controlAffinity: ListTileControlAffinity.trailing,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("ORDER SUMMARY",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
            const Divider(),
            _buildProductItem(
                "Red Floral Printed Kurti", "₹599", "Size: M", "assets/kurti1.jpg"),
            const Divider(),
            _buildProductItem(
                "Blue Embroidered Kurti", "₹499", "Size: L", "assets/kurti2.jpg"),
            const Divider(),
            if (!showCouponField)
              TextButton(
                onPressed: () {
                  setState(() {
                    showCouponField = true;
                  });
                },
                child: const Text("+ APPLY COUPON",
                    style: TextStyle(color: Colors.deepPurple)),
              ),
            if (showCouponField)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _couponController,
                      decoration: const InputDecoration(
                        hintText: "Enter coupon code",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Apply coupon logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text("APPLY"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(
      String title, String price, String subtitle, String imagePath) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Text(price,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildPriceDetails() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("PRICE DETAILS",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
            const Divider(),
            _buildPriceRow("Total MRP", "₹1,098"),
            _buildPriceRow("Discount on MRP", "-₹200"),
            _buildPriceRow("Coupon Discount", "-₹0"),
            _buildPriceRow("Delivery Charges", "FREE"),
            const Divider(),
            _buildPriceRow("Total Amount", "₹898",
                isBold: true, isLarge: true),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value,
      {bool isBold = false, bool isLarge = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: isLarge ? 16 : 14,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontSize: isLarge ? 18 : 14,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: isLarge ? Colors.green : Colors.black)),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: agreeToTerms,
          onChanged: (bool? value) {
            setState(() {
              agreeToTerms = value ?? false;
            });
          },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        const Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: "I agree to the "),
                TextSpan(
                  text: "Terms and Conditions",
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: " and "),
                TextSpan(
                  text: "Privacy Policy",
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: " of MyShop."),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: agreeToTerms ? Colors.deepPurple : Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
        onPressed: agreeToTerms
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentPage()),
                );
              }
            : null,
        child: const Text(
          'CONTINUE TO PAYMENT',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
     ),
);
}
}
