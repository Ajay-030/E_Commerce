import 'dart:async';
import 'package:app_1/user_myorder.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'user_cart.dart';
import 'checkout_page.dart';
import 'user_account.dart';
import 'wishlist_page.dart' hide MyShopApp;
import 'category_drawer.dart';
void main() => runApp(const ECommerceApp());

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto', primarySwatch: Colors.deepPurple),
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
  int _currentBottomNavIndex = 0;

  final List<String> carouselImages = const [
    'assets/slide4.jpg',
    'assets/slide5.jpg',
    'assets/slide6.jpg',
    'assets/slide1.jpg',
    'assets/slide2.jpg',
  ];

  final List<Map<String, dynamic>> allProducts = const [
    // Best Sellers (high rating and sales)
    {
      "name": "Elegant Kurthi",
      "price": 999,
      "discount": 20,
      "rating": 4.8,
      "size": "M, L, XL",
      "available": true,
      "image": "assets/kurthi1.jpg",
      "category": "Kurta & Kurti",
      "isBestSeller": true,
      "isNewArrival": false,
      "sales": 450,
    },
    {
      "name": "Cotton Kurthi",
      "price": 1199,
      "discount": 15,
      "rating": 4.2,
      "size": "M, XL",
      "available": false,
      "image": "assets/kurthi3.jpg",
      "category": "Kurta & Kurti",
      "isBestSeller": false,
      "isNewArrival": false,
      "sales": 210,
    },
    {
      "name": "Printed Kurthi",
      "price": 799,
      "discount": 30,
      "rating": 4.7,
      "size": "S, M, L",
      "available": true,
      "image": "assets/kurthi2.jpg",
      "category": "Kurta & Kurti",
      "isBestSeller": true,
      "isNewArrival": false,
      "sales": 380,
    },
    {
      "name": "Silk Kurthi",
      "price": 1299,
      "discount": 22,
      "rating": 4.9,
      "size": "L, XL",
      "available": true,
      "image": "assets/kurthi6.jpg",
      "category": "Ethnic Sets",
      "isBestSeller": true,
      "isNewArrival": false,
      "sales": 520,
    },
    {
      "name": "Embellished Kurthi",
      "price": 1399,
      "discount": 25,
      "rating": 4.8,
      "size": "M, L",
      "available": false,
      "image": "assets/kurthi9.jpg",
      "category": "Wedding collections",
      "isBestSeller": true,
      "isNewArrival": false,
      "sales": 410,
    },

    // New Arrivals
    {
      "name": "Designer Kurthi",
      "price": 1499,
      "discount": 20,
      "rating": 4.6,
      "size": "M, L, XL",
      "available": true,
      "image": "assets/kurthi10.jpg",
      "category": "Wedding collections",
      "isBestSeller": false,
      "isNewArrival": true,
      "sales": 120,
    },
    {
      "name": "Floral Print Kurthi",
      "price": 899,
      "discount": 15,
      "rating": 4.3,
      "size": "S, M, L",
      "available": true,
      "image": "assets/kurthi11.jpg",
      "category": "Kurta & Kurti",
      "isBestSeller": false,
      "isNewArrival": true,
      "sales": 85,
    },
    {
      "name": "Georgette Kurthi",
      "price": 1099,
      "discount": 10,
      "rating": 4.5,
      "size": "S, M, L, XL",
      "available": true,
      "image": "assets/kurthi12.jpg",
      "category": "Kurta & Kurti",
      "isBestSeller": false,
      "isNewArrival": true,
      "sales": 95,
    },
    {
      "name": "Anarkali Kurthi",
      "price": 1199,
      "discount": 18,
      "rating": 4.4,
      "size": "M, L",
      "available": true,
      "image": "assets/kurthi13.jpg",
      "category": "Ethnic Sets",
      "isBestSeller": false,
      "isNewArrival": true,
      "sales": 110,
    },

    // Regular Products
    {
      "name": "Cotton Kurthi",
      "price": 1199,
      "discount": 15,
      "rating": 4.2,
      "size": "M, XL",
      "available": false,
      "image": "assets/kurthi3.jpg",
      "category": "Kurta & Kurti",
      "isBestSeller": false,
      "isNewArrival": false,
      "sales": 210,
    },
    {
      "name": "Chic Kurthi",
      "price": 899,
      "discount": 25,
      "rating": 4.1,
      "size": "S, M",
      "available": true,
      "image": "assets/kurthi4.jpg",
      "category": "Kurta & Kurti",
      "isBestSeller": false,
      "isNewArrival": false,
      "sales": 180,
    },
    {
      "name": "Embroidered Kurthi",
      "price": 1099,
      "discount": 18,
      "rating": 4.3,
      "size": "M, L",
      "available": true,
      "image": "assets/kurthi5.jpg",
      "category": "Kurta & Kurti",
      "isBestSeller": false,
      "isNewArrival": false,
      "sales": 240,
    },
    {
      "name": "Cotton Floral Kurthi",
      "price": 799,
      "discount": 20,
      "rating": 4.0,
      "size": "S, M",
      "available": true,
      "image": "assets/kurthi7.jpg",
      "category": "Kurta & Kurti",
      "isBestSeller": false,
      "isNewArrival": false,
      "sales": 195,
    },
    {
      "name": "Denim Kurthi",
      "price": 1199,
      "discount": 15,
      "rating": 4.2,
      "size": "M, L, XL",
      "available": true,
      "image": "assets/kurthi8.jpg",
      "category": "Fusion wear",
      "isBestSeller": false,
      "isNewArrival": false,
      "sales": 160,
    },
    {
      "name": "Chanderi Silk Kurthi",
      "price": 1599,
      "discount": 12,
      "rating": 4.6,
      "size": "S, M, L",
      "available": true,
      "image": "assets/kurthi14.jpg",
      "category": "Ethnic Sets",
      "isBestSeller": false,
      "isNewArrival": false,
      "sales": 220,
    },
    {
      "name": "Batik Print Kurthi",
      "price": 999,
      "discount": 18,
      "rating": 4.3,
      "size": "M, L, XL",
      "available": true,
      "image": "assets/kurthi15.jpg",
      "category": "Kurta & Kurti",
      "isBestSeller": false,
      "isNewArrival": false,
      "sales": 175,
    },
    {
      "name": "Kalamkari Kurthi",
      "price": 1299,
      "discount": 20,
      "rating": 4.7,
      "size": "S, M",
      "available": true,
      "image": "assets/kurthi16.jpg",
      "category": "Ethnic Sets",
      "isBestSeller": false,
      "isNewArrival": false,
      "sales": 290,
    },
    {
      "name": "Bandhani Kurthi",
      "price": 1399,
      "discount": 15,
      "rating": 4.5,
      "size": "M, L, XL",
      "available": true,
      "image": "assets/kurthi17.jpg",
      "category": "Kurta & Kurti",
      "isBestSeller": false,
      "isNewArrival": false,
      "sales": 210,
    },
    {
      "name": "Lehenga Style Kurthi",
      "price": 1699,
      "discount": 22,
      "rating": 4.8,
      "size": "S, M, L",
      "available": true,
      "image": "assets/kurthi18.jpg",
      "category": "Wedding collections",
      "isBestSeller": false,
      "isNewArrival": false,
      "sales": 180,
    },
    {
      "name": "Kashmiri Kurthi",
      "price": 1499,
      "discount": 18,
      "rating": 4.4,
      "size": "M, L, XL",
      "available": true,
      "image": "assets/kurthi19.jpg",
      "category": "Kurta & Kurti",
      "isBestSeller": false,
      "isNewArrival": false,
      "sales": 160,
    },
    {
      "name": "Patchwork Kurthi",
      "price": 999,
      "discount": 20,
      "rating": 4.2,
      "size": "S, M",
      "available": true,
      "image": "assets/kurthi20.jpg",
      "category": "Fusion wear",
      "isBestSeller": false,
      "isNewArrival": false,
      "sales": 140,
    },
  ];

  // Filter and sort variables
  String _selectedCategory = 'All';
  double _minPrice = 0;
  double _maxPrice = 2000;
  bool _inStockOnly = false;
  String _sortBy = 'Recommended';
  List<Map<String, dynamic>> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = allProducts;
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

  void _applyFilters() {
    setState(() {
      _filteredProducts = allProducts.where((product) {
        final price = (product['price'] as int).toDouble();
        final matchesCategory =
            _selectedCategory == 'All' ||
            product['category'] == _selectedCategory;
        final matchesPrice = price >= _minPrice && price <= _maxPrice;
        final matchesStock = !_inStockOnly || product['available'];

        return matchesCategory && matchesPrice && matchesStock;
      }).toList();

      // Apply sorting
      switch (_sortBy) {
        case 'Price: Low to High':
          _filteredProducts.sort((a, b) => a['price'].compareTo(b['price']));
          break;
        case 'Price: High to Low':
          _filteredProducts.sort((a, b) => b['price'].compareTo(a['price']));
          break;
        case 'Highest Discount':
          _filteredProducts.sort(
            (a, b) => b['discount'].compareTo(a['discount']),
          );
          break;
        case 'Highest Rated':
          _filteredProducts.sort((a, b) => b['rating'].compareTo(a['rating']));
          break;
        case 'Best Selling':
          _filteredProducts.sort((a, b) => b['sales'].compareTo(a['sales']));
          break;
        default: // Recommended (original order)
          break;
      }
    });
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
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
              child: Stack(
                children: [
                  Image.asset(
                    product['image'],
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Wishlist Icon Button
                  Positioned(
                    top: 8,
                    left: 8,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        color: const Color.fromARGB(255, 177, 4, 196),
                        size: 24,
                      ),
                      onPressed: () {
                        // Add to wishlist functionality
                        _addToWishlist(product);
                      },
                    ),
                  ),
                  if (product['discount'] > 15)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${product['discount']}% OFF',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (product['isBestSeller'])
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'BESTSELLER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (product['isNewArrival'])
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Rest of the product card code remains the same...
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "₹${(product['price'] * (1 - product['discount'] / 100)).round()}",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 184, 156, 231),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Sizes: ${product['size']}",
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
                Text(
                  product['available'] ? "In Stock" : "Out of Stock",
                  style: TextStyle(
                    fontSize: 12,
                    color: product['available'] ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    ...List.generate(5, (star) {
                      return Icon(
                        star < product['rating'].floor()
                            ? Icons.star
                            : Icons.star_border,
                        size: 16,
                        color: Colors.orange,
                      );
                    }),
                    const SizedBox(width: 4),
                    Text(
                      "(${product['sales']})",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSection(
    String title,
    List<Map<String, dynamic>> products,
  ) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Container(
                width: 180,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: _buildProductCard(products[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  void _addToWishlist(Map<String, dynamic> product) {
    // Here you would typically add the product to your wishlist state management
    // For now, we'll just show a snackbar to indicate the product was added
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} added to wishlist'),
        duration: const Duration(seconds: 1),
      ),
    );

    // In a real app, you would add the product to your wishlist state
    // For example, if you're using Provider:
    // Provider.of<WishlistModel>(context, listen: false).addItem(product);
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter Products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  const SizedBox(height: 10),

                  // Category Filter
                  const Text(
                    'Category',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    items:
                        [
                              'All',
                              'Kurta & Kurti',
                              'Ethnic Sets',
                              'Fusion wear',
                              'Wedding collections',
                            ]
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setModalState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  // Price Range Filter
                  const Text(
                    'Price Range',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  RangeSlider(
                    values: RangeValues(_minPrice, _maxPrice),
                    min: 0,
                    max: 2000,
                    divisions: 20,
                    labels: RangeLabels(
                      '₹${_minPrice.toInt()}',
                      '₹${_maxPrice.toInt()}',
                    ),
                    onChanged: (RangeValues values) {
                      setModalState(() {
                        _minPrice = values.start;
                        _maxPrice = values.end;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  // Availability Filter
                  Row(
                    children: [
                      Checkbox(
                        value: _inStockOnly,
                        onChanged: (value) {
                          setModalState(() {
                            _inStockOnly = value!;
                          });
                        },
                      ),
                      const Text('In Stock Only'),
                    ],
                  ),

                  const Spacer(),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _selectedCategory = 'All';
                              _minPrice = 0;
                              _maxPrice = 2000;
                              _inStockOnly = false;
                              _sortBy = 'Recommended';
                              _applyFilters();
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Reset'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _applyFilters();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          child: const Text('Apply Filters'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSortDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sort By',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const SizedBox(height: 10),
              ...[
                'Recommended',
                'Price: Low to High',
                'Price: High to Low',
                'Highest Discount',
                'Highest Rated',
                'Best Selling',
              ].map((option) {
                return ListTile(
                  title: Text(option),
                  trailing: _sortBy == option
                      ? const Icon(
                          Icons.check,
                          color: Color.fromARGB(255, 243, 240, 248),
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      _sortBy = option;
                      _applyFilters();
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bestSellers = allProducts.where((p) => p['isBestSeller']).toList();
    final newArrivals = allProducts.where((p) => p['isNewArrival']).toList();

    return Scaffold(
      drawer: CategoryDrawer(
  selectedCategory: _selectedCategory,
  onCategorySelected: (category) {
    setState(() {
      _selectedCategory = category;
      _applyFilters();
    });
    Navigator.pop(context);
  }, onLogout: () { Navigator.of(context).pushReplacementNamed('/login'); },
),
      appBar: AppBar(
        title: const Text(
          "KurthiZone",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishlistScreen()),
              );
            },
          ),
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
                            horizontal: 16,
                            vertical: 12,
                          ),
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
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () => _showFilterDialog(context),
                      icon: const Icon(Icons.filter_alt_outlined),
                      label: const Text("Filter"),
                    ),
                    TextButton.icon(
                      onPressed: () => _showSortDialog(context),
                      icon: const Icon(Icons.sort),
                      label: Text(_sortBy),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    if (_selectedCategory != 'All')
                      Chip(
                        label: Text(_selectedCategory),
                        onDeleted: () {
                          setState(() {
                            _selectedCategory = 'All';
                            _applyFilters();
                          });
                        },
                      ),
                    if (_inStockOnly)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Chip(
                          label: const Text('In Stock'),
                          onDeleted: () {
                            setState(() {
                              _inStockOnly = false;
                              _applyFilters();
                            });
                          },
                        ),
                      ),
                    if (_minPrice > 0 || _maxPrice < 2000)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Chip(
                          label: Text(
                            '₹${_minPrice.toInt()}-₹${_maxPrice.toInt()}',
                          ),
                          onDeleted: () {
                            setState(() {
                              _minPrice = 0;
                              _maxPrice = 2000;
                              _applyFilters();
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Best Sellers Section
            SliverToBoxAdapter(
              child: _buildProductSection("Best Sellers", bestSellers),
            ),

            // New Arrivals Section
            SliverToBoxAdapter(
              child: _buildProductSection("New Arrivals", newArrivals),
            ),

            // All Products Section
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  "All Products",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              sliver: _filteredProducts.isEmpty
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 60,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "No products match your filters",
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedCategory = 'All';
                                    _minPrice = 0;
                                    _maxPrice = 2000;
                                    _inStockOnly = false;
                                    _sortBy = 'Recommended';
                                    _applyFilters();
                                  });
                                },
                                child: const Text("Reset Filters"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return _buildProductCard(_filteredProducts[index]);
                      }, childCount: _filteredProducts.length),
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
        currentIndex: _currentBottomNavIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business_outlined),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: "Trending",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Account",
          ),
        ],
      ),
    );
  }

  void _onBottomNavTap(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyShopApp()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartPage()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AccountPage(
            changeThemeMode: (mode) {}, // Optional placeholder
            currentThemeMode: ThemeMode.system,
          ),
        ),
      );
    } else {
      setState(() {
        _currentBottomNavIndex = index;
      });
    }
  }
}



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
        title: Text(
          userName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
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
                    .map(
                      (item) => ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    )
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
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
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
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Icon(
                      index < rating.floor() ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 20,
                    );
                  }),
                  const SizedBox(width: 8),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "(1.2k reviews)",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                available ? "In Stock" : "Out of Stock",
                style: TextStyle(
                  color: available ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Available Sizes:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: sizes.split(', ').map((size) {
                  return ChoiceChip(
                    label: Text(size),
                    selected: size == "M",
                    onSelected: (selected) {},
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                "Available Colors:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  colorDot(Colors.red),
                  colorDot(Colors.blue),
                  colorDot(Colors.green),
                  colorDot(Colors.purple),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Product Details:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bullet("100% Cotton fabric for comfortable wear"),
                  bullet("Handcrafted with traditional embroidery"),
                  bullet("Machine wash cold with similar colors"),
                  bullet("Imported fabric with premium quality stitching"),
                  bullet("Suitable for all casual and formal occasions"),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Customer Reviews:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              userReview(
                "Priya Sharma",
                "Loved the fabric and fit! Perfect for summer wear.",
                5,
              ),
              userReview(
                "Rahul Patel",
                "Good quality but the color was slightly different than shown.",
                4,
              ),
              userReview(
                "Neha Gupta",
                "Excellent stitching and finish. Worth the price!",
                5,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<CartModel>(context, listen: false).addItem(
                      CartItem(
                        id: name,
                        name: name,
                        category: 'Kurthi',
                        price: (price * (1 - discount / 100)).toDouble(),
                        imageUrl: imageList.first,
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$name added to cart"),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "ADD TO CART",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(
                          productName: name,
                          productPrice: discountedPrice,
                          image: imageList.first,
                          size: "M",
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: Colors.deepPurple),
                  ),
                  child: const Text(
                    "PROCEED TO PAYMENT",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
