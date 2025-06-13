import 'package:app_1/user_account.dart';
import 'package:flutter/material.dart';

class CategoryDrawer extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final VoidCallback onLogout;
  
  CategoryDrawer({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.onLogout,
  });

  final Map<String, List<String>> _categories = {
    'Women': [
      'Western Wear',
      'Ethnic Wear',
      'Lingerie',
      'Footwear',
      'Accessories'
    ],
    'Men': ['Casual Wear', 'Formal Wear', 'Sports Wear', 'Footwear', 'Watches'],
    'Kids': ['Boys', 'Girls', 'Infants', 'Toys', 'Accessories'],
    'Home & Living': ['Bedding', 'Decor', 'Kitchen', 'Bath', 'Furniture'],
    'Beauty': ['Makeup', 'Skincare', 'Haircare', 'Fragrances', 'Tools'],
  };

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 40, color: Colors.deepPurple),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Welcome, User!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                ..._categories.entries.map((entry) {
                  return ExpansionTile(
                    title: Text(
                      entry.key,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: entry.value.map((subcategory) {
                      return ListTile(
                        title: Text(subcategory),
                        tileColor: selectedCategory == '${entry.key} - $subcategory' 
                            ? Colors.deepPurple.withOpacity(0.1)
                            : null,
                        onTap: () {
                          onCategorySelected('${entry.key} - $subcategory');
                        },
                      );
                    }).toList(),
                  );
                }).toList(),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountPage(
                          changeThemeMode: (mode) {}, // Optional placeholder
                          currentThemeMode: ThemeMode.system,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Help & Support'),
                  onTap: () {
                    onCategorySelected('Help & Support');
                  },
                ),
              ],
            ),
          ),
          
          // Logout button at the bottom
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1.0,
                ),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              children: [
                const Divider(height: 1, color: Colors.grey),
                const SizedBox(height: 16),
                
                // Logout button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.logout, size: 20),
                    label: const Text(
                      'LOG OUT',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red.shade700,
                      backgroundColor: Colors.transparent,
                      side: BorderSide(color: Colors.red.shade700),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      // Close the drawer first
                      Navigator.pop(context);
                      // Then perform logout action
                      onLogout();
                      // Navigate to login page with replacement (so user can't go back)
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ),
                
                const SizedBox(height: 12),
                Text(
                  'App Version 1.0.0',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}