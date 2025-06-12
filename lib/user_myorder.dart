import 'package:app_1/HomePage.dart';
import 'package:app_1/user_account.dart';
import 'package:app_1/user_cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyShopApp());
}

class MyShopApp extends StatelessWidget {
  const MyShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const OrdersPage(),
    );
  }
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int _selectedFilter = 0;
  int _selectedIndex = 1; // For BottomNavigationBar

  final List<Order> allOrders = [
    Order(
      id: '408-5877661-5688346',
      date: DateTime(2024, 11, 28),
      total: 549.00,
      status: 'Delivered',
      deliveryDate: DateTime(2024, 12, 5),
      items: [
        OrderItem(
          name: 'Elegant Kurthi',
          image: 'assets/kitchen_mat.jpg',
          returnStatus: 'Return window closed',
          price: 274.50,
          quantity: 2,
        ),
      ],
    ),
    Order(
      id: '408-7037875-6348369',
      date: DateTime(2024, 11, 27),
      total: 2079.00,
      status: 'Refunded',
      deliveryDate: DateTime(2024, 12, 2),
      items: [
        OrderItem(
          name: 'Premium Smart Watch with Health Monitoring',
          image: 'assets/smart_watch.jpg',
          returnStatus: 'Refund issued - Return in transit',
          price: 2079.00,
          quantity: 1,
        ),
      ],
    ),
    Order(
      id: '408-7037875-6348370',
      date: DateTime(2024, 11, 29),
      total: 899.00,
      status: 'To Ship',
      deliveryDate: DateTime(2024, 12, 10),
      items: [
        OrderItem(
          name: 'Wireless Noise Cancelling Headphones',
          image: 'assets/headphones.jpg',
          returnStatus: '',
          price: 899.00,
          quantity: 1,
        ),
      ],
    ),
    Order(
      id: '408-7037875-6348371',
      date: DateTime(2024, 11, 25),
      total: 129.00,
      status: 'Cancelled',
      deliveryDate: DateTime(2024, 12, 1),
      items: [
        OrderItem(
          name: 'Stainless Steel Water Bottle',
          image: 'assets/water_bottle.jpg',
          returnStatus: 'Order cancelled',
          price: 129.00,
          quantity: 1,
        ),
      ],
    ),
  ];

  List<Order> get filteredOrders {
    switch (_selectedFilter) {
      case 1:
        return allOrders.where((order) => order.status == 'To Ship').toList();
      case 2:
        return allOrders.where((order) => order.status == 'Delivered').toList();
      case 3:
        return allOrders.where((order) => order.status == 'Cancelled').toList();
      default:
        return allOrders;
    }
  }

  // ignore: unused_element
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterTabs(),
          if (filteredOrders.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No orders found',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getEmptyStateMessage(),
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: filteredOrders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) =>
                    _buildOrderCard(filteredOrders[index]),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business_outlined),
            activeIcon: Icon(Icons.add_business),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigation logic would go here
    // For now, we'll just handle the state change
    // In a real app, you would navigate to different pages:

    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => CartPage()));
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
    }
  }

  String _getEmptyStateMessage() {
    switch (_selectedFilter) {
      case 1:
        return "You don't have any orders to ship right now";
      case 2:
        return "You don't have any delivered orders";
      case 3:
        return "You don't have any cancelled orders";
      default:
        return "You haven't placed any orders yet";
    }
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Orders'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Search by order ID or product name',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            // Implement search functionality
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              // Implement search
              Navigator.pop(context);
            },
            child: const Text('SEARCH'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      height: 50,
      color: Colors.white,
      child: Row(
        children: [
          _buildFilterTab('All', 0),
          _buildFilterTab('To Ship', 1),
          _buildFilterTab('Delivered', 2),
          _buildFilterTab('Cancelled', 3),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String title, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedFilter = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _selectedFilter == index
                    ? Colors.deepPurple
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: _selectedFilter == index
                    ? Colors.deepPurple
                    : Colors.grey,
                fontWeight: _selectedFilter == index
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[200]!, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderHeader(order),
            const SizedBox(height: 12),
            ...order.items.map((item) => _buildOrderItem(item)).toList(),
            const SizedBox(height: 12),
            _buildOrderActions(order),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeader(Order order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #${order.id}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Placed on ${DateFormat('MMM dd, yyyy').format(order.date)}',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(order.status).withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            order.status,
            style: TextStyle(
              color: _getStatusColor(order.status),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItem(OrderItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey[200],
              image: DecorationImage(
                image: AssetImage(item.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.quantity} × ₹${item.price.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                if (item.returnStatus.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      item.returnStatus,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderActions(Order order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total: ₹${order.total.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        if (order.status == 'Delivered')
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'Buy Again',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        if (order.status == 'To Ship')
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'Track Order',
              style: TextStyle(color: Colors.black87),
            ),
          ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green;
      case 'To Ship':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      case 'Refunded':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

class Order {
  final String id;
  final DateTime date;
  final DateTime deliveryDate;
  final double total;
  final String status;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
    required this.items,
    required this.deliveryDate,
  });
}

class OrderItem {
  final String name;
  final String image;
  final String returnStatus;
  final double price;
  final int quantity;

  OrderItem({
    required this.name,
    required this.image,
    required this.returnStatus,
    required this.price,
    required this.quantity,
  });
}
