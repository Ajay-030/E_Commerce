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
      home: OrdersPage(),
    );
  }
}

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int _selectedFilter = 0;
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
          name: '',
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
      case 1: // To Ship
        return allOrders.where((order) => order.status == 'To Ship').toList();
      case 2: // Completed
        return allOrders.where((order) => order.status == 'Delivered').toList();
      case 3: // Cancelled
        return allOrders.where((order) => order.status == 'Cancelled').toList();
      default: // All Orders
        return allOrders;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 24),
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
                    Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No orders found',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getEmptyStateMessage(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
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
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildOrderCard(filteredOrders[index]);
                },
              ),
            ),
        ],
      ),
    );
  }

  String _getEmptyStateMessage() {
    switch (_selectedFilter) {
      case 1:
        return 'You have no orders waiting to ship';
      case 2:
        return 'You have no completed orders yet';
      case 3:
        return 'You have no cancelled orders';
      default:
        return 'You have not placed any orders yet';
    }
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Orders'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Search by order ID or product name',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('SEARCH'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildFilterTab('All', 0),
              _buildFilterTab('To Ship', 1),
              _buildFilterTab('Delivered', 2),
              _buildFilterTab('Cancelled', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTab(String title, int index) {
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 3,
              color: _selectedFilter == index
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: _selectedFilter == index ? FontWeight.w600 : FontWeight.w500,
            color: _selectedFilter == index
                ? Theme.of(context).primaryColor
                : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderHeader(order),
          Divider(height: 1, thickness: 1, color: Colors.grey[100]),
          ...order.items.map((item) => _buildOrderItem(item)).toList(),
          Divider(height: 1, thickness: 1, color: Colors.grey[100]),
          _buildOrderActions(order),
        ],
      ),
    );
  }

  Widget _buildOrderHeader(Order order) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #${order.id}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
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
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(order.status),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Date',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('MMM dd, yyyy').format(order.date),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${order.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (order.status != 'Cancelled')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.status == 'To Ship' ? 'Est. Delivery' : 'Delivered',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('MMM dd').format(order.deliveryDate),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(OrderItem item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 80,
              height: 80,
              color: Colors.grey[200],
              child: Image.asset(
                item.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.image, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Qty: ${item.quantity}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                if (item.returnStatus.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: item.returnStatus.contains('closed')
                          ? Colors.grey[100]
                          : Colors.green[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.returnStatus.contains('closed')
                              ? Icons.check_circle_outline
                              : Icons.local_shipping_outlined,
                          size: 14,
                          color: item.returnStatus.contains('closed')
                              ? Colors.grey
                              : Colors.green,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          item.returnStatus,
                          style: TextStyle(
                            fontSize: 12,
                            color: item.returnStatus.contains('closed')
                                ? Colors.grey[600]
                                : Colors.green[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderActions(Order order) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (order.status == 'Delivered')
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.repeat, size: 18),
                label: const Text('Buy Again'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
                onPressed: () {},
              ),
            ),
     if (order.status == 'Refunded')
  FittedBox(
    child: OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.track_changes, size: 18, color: Colors.deepPurple),
      label: const Text(
        'Track Return',
        style: TextStyle(color: Colors.deepPurple),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        side: BorderSide(color: Colors.deepPurple.shade100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  ),


         if (order.status == 'To Ship')
  FittedBox(
    child: OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.cancel, size: 18, color: Colors.deepPurple),
      label: const Text(
        'Cancel Order',
        style: TextStyle(color: Colors.deepPurple),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        side: BorderSide(color: Colors.deepPurple.shade100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  ),

          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {},
              child: const Text('Order Details'),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green;
      case 'To Ship':
        return Colors.orange;
      case 'Refunded':
        return Colors.purple;
      case 'Cancelled':
        return Colors.red;
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
