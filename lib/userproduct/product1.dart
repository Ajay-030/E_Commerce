import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetailPage extends StatelessWidget {
  final String name;
  final int price;
  final int discount;
  final double rating;
  final String sizes;
  final bool available;
  final List<String> imageList;

  const ProductDetailPage({
    super.key,
    required this.name,
    required this.price,
    required this.discount,
    required this.rating,
    required this.sizes,
    required this.available,
    required this.imageList,
  });

  Widget bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget colorDot(Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(width: 1.5, color: Colors.grey.shade700),
      ),
    );
  }

  Widget userReview(String userName, String comment, double rating) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(userName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comment),
            const SizedBox(height: 6),
            Row(
              children: List.generate(
                5,
                (index) => Icon(Icons.star,
                    color: index < rating ? Colors.amber : Colors.grey, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final discountedPrice = (price * (1 - discount / 100)).round();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Color(0xFFF5F5F5)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(name),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              CarouselSlider(
                items: imageList
                    .map((item) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(item, fit: BoxFit.cover, width: double.infinity),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: false,
                  viewportFraction: 0.85,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                name,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '₹$discountedPrice',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '₹$price',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$discount% OFF',
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Text(rating.toStringAsFixed(1),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 4),
                        const Icon(Icons.star, color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text("158 ratings", style: TextStyle(color: Colors.black87)),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Available Colors:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Row(
                children: [
                  colorDot(Colors.pinkAccent),
                  colorDot(Colors.blueAccent),
                  colorDot(Colors.orange),
                  colorDot(Colors.green),
                ],
              ),
              const SizedBox(height: 20),
              Text('Available Sizes: $sizes', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 20),
              const Text('Key Features:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              bullet("Premium cotton fabric for all-day comfort"),
              bullet("Elegant floral embroidery with detailed finish"),
              bullet("Available in multiple sizes and color options"),
              bullet("Ideal for festive occasions, casual outings"),
              const SizedBox(height: 30),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Kurthi added to cart!")),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart_outlined),
                      label: const Text('Add to Cart', style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Proceeding to Buy Now!")),
                        );
                      },
                      icon: const Icon(Icons.flash_on),
                      label: const Text('Buy Now', style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Divider(height: 1),
              const SizedBox(height: 16),
              const Text('User Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              userReview("Anjali", "Very soft and comfortable. Loved it!", 5),
              userReview("Divya", "Color is good but size runs slightly small.", 4),
              userReview("Riya", "Good quality, timely delivery.", 5),
            ],
          ),
        ),
      ),
    );
  }
}
