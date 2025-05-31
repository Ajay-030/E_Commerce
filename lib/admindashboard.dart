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
        appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple),
      ),
      home: DashboardScreen(),
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
      drawer: DrawerMenu(),
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: SingleChildScrollView(
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
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text(
              'Admin Panel',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Orders'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text('Products'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Customers'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Reports'),
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
      padding: EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(1, 100),
                FlSpot(2, 150),
                FlSpot(3, 130),
                FlSpot(4, 170),
                FlSpot(5, 200),
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
      padding: EdgeInsets.all(16),
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.orange,
              value: 50,
              title: 'Direct',
              radius: 70,
              titleStyle: TextStyle(
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
              titleStyle: TextStyle(
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
              titleStyle: TextStyle(
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
