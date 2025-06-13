import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'user_cart.dart';
void main() {
  runApp(const MyShopApp());
}

class MyShopApp extends StatelessWidget {
  const MyShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
          secondary: Colors.deepPurpleAccent,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
        ),
      ),
      home: const WishlistScreen(),
    );
  }
}

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _currentTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  bool _showSearch = false;
  final List<Map<String, dynamic>> _wishlistItems = [
    {
      'title': 'HomeCloud Dish Drying Mat for Kitchen Counter',
      'brand': 'HomeCloud',
      'rating': 4.0,
      'ratingCount': 164,
      'price': 398.00,
      'shipping': 'FREE Delivery on orders over ₹499',
      'size': '50 x 40 cm',
      'color': 'Beige Beauty',
      'image': 'https://m.media-amazon.com/images/I/71YHjVXyR0L.AC_UL320.jpg',
      'list': 'Shopping List',
    },
    {
      'title': 'Premium Kitchen Knife Set',
      'brand': 'ChefMaster',
      'rating': 4.5,
      'ratingCount': 342,
      'price': 1299.00,
      'shipping': 'FREE Delivery tomorrow',
      'size': '6 pieces',
      'color': 'Silver',
      'image': 'https://m.media-amazon.com/images/I/71YHjVXyR0L.AC_UL320.jpg',
      'list': 'Kitchen Essentials',
    },
  ];
  List<Map<String, dynamic>> _filteredItems = [];
  final List<String> _shoppingLists = [
    'Shopping List',
    'Birthday Wishlist',
    'Kitchen Essentials',
    'Tech Gadgets'
  ];
  String _selectedList = 'Shopping List';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController?.addListener(() {
      setState(() {
        _currentTabIndex = _tabController?.index ?? 0;
      });
    });
    _filteredItems = List.from(_wishlistItems);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = _wishlistItems.where((item) {
        final titleLower = item['title'].toLowerCase();
        final brandLower = item['brand'].toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower) || brandLower.contains(searchLower);
      }).toList();
    });
  }

  void _filterByList(String listName) {
    setState(() {
      _selectedList = listName;
      _filteredItems = _wishlistItems.where((item) => item['list'] == listName).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Your Lists Tab
          SingleChildScrollView(
            child: Column(
              children: [
                _buildCreateListButton(),
                _buildShoppingLists(),
                _buildWishlistItems(),
              ],
            ),
          ),
          
          // Your Friends Tab
          const Center(child: Text('Friends lists will appear here')),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
  return AppBar(
    title: _showSearch
        ? TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search your wishlist...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
            style: const TextStyle(color: Colors.white),
            onChanged: _filterItems,
          )
        : const Text('Your Lists'),
    actions: [
      IconButton(
        icon: Icon(_showSearch ? Icons.close : Icons.search),
        onPressed: () {
          setState(() {
            _showSearch = !_showSearch;
            if (!_showSearch) {
              _searchController.clear();
              _filterItems('');
            }
          });
        },
      ),
      IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartPage()),
          );
        },
      ),
      const SizedBox(width: 8),
    ],
    bottom: TabBar(
      controller: _tabController,
      tabs: const [
        Tab(text: 'Your Lists'),
        Tab(text: 'Your Friends'),
      ],
      indicatorColor: Colors.white,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white.withOpacity(0.7),
    ),
  );
}

  Widget _buildCreateListButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: _showCreateListDialog,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        icon: const Icon(Icons.add),
        label: const Text(
          'Create a List',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildShoppingLists() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Shopping Lists',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            padding: const EdgeInsets.only(bottom: 16),
            children: _shoppingLists.map((list) => _buildListCard(list)).toList(), 
          ),
        ],
      ),
    );
  }

 Widget _buildListCard(String title) {
  final isPrivate = title == 'Shopping List' || title == 'Kitchen Essentials';
  final isPublic = title == 'Tech Gadgets';
  final icon = title == 'Shopping List'
      ? Icons.shopping_basket
      : title == 'Birthday Wishlist'
          ? Icons.card_giftcard
          : title == 'Kitchen Essentials'
              ? Icons.kitchen
              : Icons.devices;
  final type = isPrivate
      ? 'Default List'
      : isPublic
          ? 'Viewable by all'
          : 'Invite Only';
  final privacy = isPrivate
      ? 'Private'
      : isPublic
          ? 'Public'
          : 'Shared';

  return Card(
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        _filterByList(title);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(
          minHeight: 150,
          maxHeight: 150,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: Colors.deepPurple, size: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    privacy,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 2),
            SizedBox(
              width: double.infinity,
              child: Text(
                type,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 25, // Increased to 34 to prevent overflow
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        _showManageListDialog(title);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 4), // Added vertical padding
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Manage',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _filterByList(title);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 4), // Added vertical padding
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'View',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
  Widget _buildWishlistItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_filteredItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    '$_selectedList Items',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_filteredItems.length} items',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          if (_filteredItems.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    const Icon(Icons.search_off, size: 48, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'No items found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Text(
                      _selectedList == 'Shopping List' 
                        ? 'Add items to your list' 
                        : 'Try a different search term',
                      style: const TextStyle(color: Colors.grey),
                    ),   
                  ],
                ),
              ),
            ),
          ..._filteredItems.map((item) => _buildWishlistItem(
                item['title'],
                item['brand'],
                item['rating'],
                item['ratingCount'],
                item['price'],
                item['shipping'],
                item['size'],
                item['color'],
                item['image'],
                item['list'],
              )),
        ],
      ),
    );
  }

  Widget _buildWishlistItem(
    String title,
    String brand,
    double rating,
    int ratingCount,
    double price,
    String shipping,
    String size,
    String color,
    String imageUrl,
    String listName,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'by $brand',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: rating,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 16,
                            direction: Axis.horizontal,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$ratingCount',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹$price',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        shipping,
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Size: $size | Color: $color',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showAddedToCartSnackbar();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.shopping_cart, size: 18),
                    label: const Text('Add to Cart'),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => _buildMoveToListSheet(title, listName),
                    );
                  },
                  icon: const Icon(Icons.move_down),
                  tooltip: 'Move to list',
                ),
                IconButton(
                  onPressed: () {
                    _showDeleteDialog(title);
                  },
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Remove item',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoveToListSheet(String itemTitle, String currentList) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Move "$itemTitle" to:',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ..._shoppingLists.where((list) => list != currentList).map((list) => 
            ListTile(
              leading: Icon(
                list == 'Shopping List' ? Icons.shopping_basket 
                : list == 'Birthday Wishlist' ? Icons.card_giftcard 
                : list == 'Kitchen Essentials' ? Icons.kitchen 
                : Icons.devices,
              ),
              title: Text(list),
              onTap: () {
                Navigator.pop(context);
                _moveItemToList(itemTitle, list);
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Create new list'),
            onTap: () {
              Navigator.pop(context);
              _showCreateListDialog(itemTitle: itemTitle);
            },
          ),
        ],
      ),
    );
  }

  void _moveItemToList(String itemTitle, String newList) {
    setState(() {
      final itemIndex = _wishlistItems.indexWhere((item) => item['title'] == itemTitle);
      if (itemIndex != -1) {
        _wishlistItems[itemIndex]['list'] = newList;
        _filterItems(_searchController.text);
      }
    });
    _showMovedSnackbar(newList);
  }

  void _showAddedToCartSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item added to cart'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showMovedSnackbar(String listName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item moved to $listName'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showDeleteDialog(String itemName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Item'),
        content: Text('Are you sure you want to remove "$itemName" from your wishlist?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _wishlistItems.removeWhere((item) => item['title'] == itemName);
                _filterItems(_searchController.text);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Item removed from wishlist'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            child: const Text(
              'Remove',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showManageListDialog(String listName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Manage $listName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Rename List'),
              onTap: () {
                Navigator.pop(context);
                _showRenameListDialog(listName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share List'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sharing $listName'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete List', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _showDeleteListDialog(listName);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showDeleteListDialog(String listName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete List'),
        content: Text('Are you sure you want to delete "$listName"? All items in this list will be moved to your default Shopping List.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                // Move all items to Shopping List
                for (var item in _wishlistItems.where((item) => item['list'] == listName)) {
                  item['list'] = 'Shopping List';
                }
                // Remove the list
                _shoppingLists.remove(listName);
                _filterByList('Shopping List');
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"$listName" deleted and items moved to Shopping List'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showRenameListDialog(String oldListName) {
    final TextEditingController renameController = TextEditingController(text: oldListName);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename List'),
        content: TextField(
          controller: renameController,
          decoration: const InputDecoration(
            labelText: 'New list name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = renameController.text.trim();
              if (newName.isNotEmpty && newName != oldListName) {
                Navigator.pop(context);
                setState(() {
                  // Update list name in shopping lists
                  final index = _shoppingLists.indexOf(oldListName);
                  if (index != -1) {
                    _shoppingLists[index] = newName;
                  }
                  // Update list name in all items
                  for (var item in _wishlistItems.where((item) => item['list'] == oldListName)) {
                    item['list'] = newName;
                  }
                  if (_selectedList == oldListName) {
                    _selectedList = newName;
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('List renamed to "$newName"'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Rename'),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showCreateListDialog({String? itemTitle}) {
    final TextEditingController listNameController = TextEditingController();
    String privacyValue = 'Private';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create new list'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: listNameController,
              decoration: const InputDecoration(
                labelText: 'List name',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Privacy',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Private',
                  child: Text('Private (only you can see)'),
                ),
                DropdownMenuItem(
                  value: 'Shared',
                  child: Text('Shared (invite only)'),
                ),
                DropdownMenuItem(
                  value: 'Public',
                  child: Text('Public (anyone can view)'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  privacyValue = value;
                }
              },
              value: privacyValue,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final listName = listNameController.text.trim();
              if (listName.isNotEmpty) {
                Navigator.pop(context);
                setState(() {
                  _shoppingLists.add(listName);
                  if (itemTitle != null) {
                    // Move the item to the new list
                    final itemIndex = _wishlistItems.indexWhere((item) => item['title'] == itemTitle);
                    if (itemIndex != -1) {
                      _wishlistItems[itemIndex]['list'] = listName;
                    }
                    _filterByList(listName);
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"$listName" created${itemTitle != null ? ' and item moved' : ''}'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Create'),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
),
);
}
}