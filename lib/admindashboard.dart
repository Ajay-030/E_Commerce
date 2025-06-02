import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple),
      ),
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ------------------- Dashboard Screen -------------------

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                InfoCard(
                  title: 'Orders',
                  value: '152',
                  icon: Icons.shopping_cart,
                  color: Colors.deepPurple,
                ),
                InfoCard(
                  title: 'Revenue',
                  value: '\$24.3K',
                  icon: Icons.attach_money,
                  color: Colors.green,
                ),
                InfoCard(
                  title: 'Customers',
                  value: '1.2K',
                  icon: Icons.people,
                  color: Colors.orange,
                ),
                InfoCard(
                  title: 'Products',
                  value: '320',
                  icon: Icons.inventory,
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 24),
            ChartPlaceholder(),
            SizedBox(height: 24),
            PieChartPlaceholder(),
          ],
        ),
      ),
    );
  }
}

// ------------------- Drawer Menu -------------------

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text(
              'Admin Panel',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Orders'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Products'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Customers'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Reports'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

// ------------------- Info Card -------------------

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 2 - 24;
    if (MediaQuery.of(context).size.width < 600) cardWidth = double.infinity;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

// ------------------- Line Chart -------------------

class ChartPlaceholder extends StatelessWidget {
  const ChartPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey.shade300)],
      ),
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(1, 100),
                const FlSpot(2, 150),
                const FlSpot(3, 130),
                const FlSpot(4, 170),
                const FlSpot(5, 200),
              ],
              isCurved: true,
              barWidth: 3,
              color: Colors.deepPurple,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- Pie Chart -------------------

class PieChartPlaceholder extends StatelessWidget {
  const PieChartPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey.shade300)],
      ),
      padding: const EdgeInsets.all(16),
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.orange,
              value: 50,
              title: 'Direct',
              radius: 70,
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              titlePositionPercentageOffset: 0.6,
            ),
            PieChartSectionData(
              color: Colors.green,
              value: 5.4,
              title: 'Referral',
              radius: 70,
              titleStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                
              ),
              titlePositionPercentageOffset: 0.8,
            ),
            PieChartSectionData(
              color: Colors.blue,
              value: 44.6,
              title: 'Organic',
              radius: 70,
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              titlePositionPercentageOffset: 0.6,
            ),
          ],
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }
}
