import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(const ECommerceApp());

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> carouselImages = const [
    'assets/slide4.jpg',
    'assets/slide5.jpg',
    'assets/slide6.jpg',
    'assets/slide1.jpg',
    'assets/slide2.jpg',
  ];

  final List<Map<String, dynamic>> products = const [
    {
      "name": "Elegant Kurthi",
      "price": 999,
      "discount": 20,
      "rating": 4.5,
      "size": "M, L, XL",
      "available": true,
      "image": "assets/kurthi1.jpg"
    },
    {
      "name": "Printed Kurthi",
      "price": 799,
      "discount": 30,
      "rating": 4.2,
      "size": "S, M, L",
      "available": true,
      "image": "assets/kurthi2.jpg"
    },
    {
      "name": "Cotton Kurthi",
      "price": 1199,
      "discount": 15,
      "rating": 4.8,
      "size": "M, XL",
      "available": false,
      "image": "assets/kurthi3.jpg"
    },
    {
      "name": "Chic Kurthi",
      "price": 899,
      "discount": 25,
      "rating": 4.3,
      "size": "S, M",
      "available": true,
      "image": "assets/kurthi4.jpg"
    },
    {
      "name": "Embroidered Kurthi",
      "price": 1099,
      "discount": 18,
      "rating": 4.6,
      "size": "M, L",
      "available": true,
      "image": "assets/kurthi5.jpg"
    },
    {
      "name": "Silk Kurthi",
      "price": 1299,
      "discount": 22,
      "rating": 4.7,
      "size": "L, XL",
      "available": true,
      "image": "assets/kurthi6.jpg"
    },
    {
      "name": "Cotton Floral Kurthi",
      "price": 799,
      "discount": 20,
      "rating": 4.4,
      "size": "S, M",
      "available": true,
      "image": "assets/kurthi7.jpg"
    },
    {
      "name": "Denim Kurthi",
      "price": 1199,
      "discount": 15,
      "rating": 4.2,
      "size": "M, L, XL",
      "available": true,
      "image": "assets/kurthi8.jpg"
    },
    {
      "name": "Embellished Kurthi",
      "price": 1399,
      "discount": 25,
      "rating": 4.9,
      "size": "M, L",
      "available": false,
      "image": "assets/kurthi9.jpg"
    },
    {
      "name": "Designer Kurthi",
      "price": 1499,
      "discount": 20,
      "rating": 4.7,
      "size": "M, L, XL",
      "available": true,
      "image": "assets/kurthi10.jpg"
    }
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % carouselImages.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF7F3FF),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30)),
                ),
                child: const Text(
                  "Categories",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 0),
                  children: const [
                    DrawerCategoryItem(title: "Ethnic Sets"),
                    DrawerCategoryItem(title: "Kurta & Kurti"),
                    DrawerCategoryItem(title: "Sarees for Women"),
                    DrawerCategoryItem(title: "Winter Collection"),
                    DrawerCategoryItem(title: "Fusion wear"),
                    DrawerCategoryItem(title: "Bottoms"),
                    DrawerCategoryItem(title: "Crop top"),
                    DrawerCategoryItem(title: "Wedding collections"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "KurthiZone",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
        ],
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/bannerbg.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: carouselImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              carouselImages[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Filter",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Sort By",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = products[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailPage(
                                    name: product['name'],
                                    price: product['price'],
                                    discount: product['discount'],
                                    rating: product['rating'],
                                    sizes: product['size'],
                                    available: product['available'],
                                    imageList: [product['image']],
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.asset(
                                product['image'],
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(
                                  "₹${product['price']}  (-${product['discount']}%)",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 184, 156, 231),
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text("Sizes: ${product['size']}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700])),
                                Text(
                                  product['available']
                                      ? "In Stock"
                                      : "Out of Stock",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: product['available']
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: List.generate(5, (star) {
                                    return Icon(
                                      star < product['rating'].floor()
                                          ? Icons.star
                                          : Icons.star_border,
                                      size: 16,
                                      color: Colors.orange,
                                    );
                                  }),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  childCount: products.length,
                ),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer), label: "Offers"),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: "Trending"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Wishlist"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }
}

/// DrawerCategoryItem now only takes a title
class DrawerCategoryItem extends StatelessWidget {
  final String title;
  const DrawerCategoryItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(title, style: const TextStyle(fontSize: 16)),
    );
  }
}

/// Full-featured Product Detail Page
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
                (index) => Icon(
                  Icons.star,
                  color: index < rating ? Colors.amber : Colors.grey,
                  size: 16,
                ),
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
                          child: Image.asset(item,
                              fit: BoxFit.cover, width: double.infinity),
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
