import 'package:app_1/HomePage.dart' show HomePage;
import 'package:app_1/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:app_1/user_cart.dart';
import 'package:app_1/user_myorder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void changeThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop',
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: _themeMode,
      home: AccountPage(
        changeThemeMode: changeThemeMode,
        currentThemeMode: _themeMode,
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2874F0),
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF2874F0),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: const CardThemeData(
        elevation: 1,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        dense: true,
        visualDensity: VisualDensity.compact,
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2874F0),
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1A237E),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}

class AccountPage extends StatefulWidget {
  final Function(ThemeMode) changeThemeMode;
  final ThemeMode currentThemeMode;

  const AccountPage({
    super.key,
    required this.changeThemeMode,
    required this.currentThemeMode,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _currentIndex = 4;

  final List<Widget> _pages = const [
    HomePage(),
    OrdersPage(),
    PlaceholderWidget(title: 'Explore'),
    CartPage(),
    PlaceholderWidget(title: 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            tooltip: 'Search',
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
            tooltip: 'More options',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const UserProfileSection(),
            const QuickActionsSection(),
            const AccountOptionsSection(),
            const FinanceOptionsSection(),
            const CreditScoreSection(),
            const NotificationsSection(),
            ThemeSettingsSection(
              darkModeEnabled: widget.currentThemeMode == ThemeMode.dark,
              onThemeChanged: (value) {
                widget.changeThemeMode(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
            ),
            const LanguageSection(),
            const AppVersionInfo(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Theme.of(context).colorScheme.primary,
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
    );
  }

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String title;
  const PlaceholderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title));
  }
}

class UserProfileSection extends StatelessWidget {
  const UserProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 16),
            _buildPlusZoneBanner(),
            const SizedBox(height: 12),
            _buildEmailVerificationBanner(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          child: const CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 36, color: Colors.white),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ajay Kumar',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              _buildMembershipStatus(),
              const SizedBox(height: 4),
              Text(
                '+91 ••••• •••89',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Icon(
          Icons.qr_code,
          color: Theme.of(context).colorScheme.primary,
          size: 28,
        ),
      ],
    );
  }

  Widget _buildMembershipStatus() {
    return RichText(
      text: const TextSpan(
        text: 'Explore Plus ',
        style: TextStyle(color: Color(0xFF2874F0), fontWeight: FontWeight.w500),
        children: [
          TextSpan(
            text: 'Silver',
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
          ),
          const TextSpan(text: ' >'),
        ],
      ),
    );
  }

  Widget _buildPlusZoneBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange[100]!),
      ),
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.orange[700], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plus Zone',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[800],
                  ),
                ),
                Text(
                  'Complete profile to unlock benefits',
                  style: TextStyle(fontSize: 12, color: Colors.orange[700]),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildEmailVerificationBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.email_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add/Verify your Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Get latest updates of your orders',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Theme.of(context).colorScheme.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          QuickActionButton(
            icon: Icons.add_business_outlined,
            label: 'Orders',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrdersPage()),
              );
            },
          ),
          QuickActionButton(
            icon: Icons.favorite_border,
            label: 'Wishlist',
            onTap: () {
              Navigator.push(
                context,
                 MaterialPageRoute(builder: (context) => const WishlistScreen()),
              );
            },
          ),
          const QuickActionButton(icon: Icons.card_giftcard, label: 'Coupons'),
          const QuickActionButton(icon: Icons.help_outline, label: 'Help'),
          const QuickActionButton(icon: Icons.history, label: 'History'),
        ],
      ),
    );
  }
}

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final int? notificationCount;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                icon,
                size: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
              if (notificationCount != null)
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      notificationCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class AccountOptionsSection extends StatelessWidget {
  const AccountOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Account Settings'),
        Card(
          child: Column(
            children: [
              const SettingsItem(
                icon: Icons.loyalty_outlined,
                title: 'kurthi Plus',
                subtitle: 'View benefits & offers',
              ),
              const Divider(height: 1, indent: 16),
              const SettingsItem(
                icon: Icons.edit_outlined,
                title: 'Edit Profile',
                subtitle: 'Update your personal details',
              ),
              const Divider(height: 1, indent: 16),
              const SettingsItem(
                icon: Icons.credit_card_outlined,
                title: 'Saved Cards & Wallets',
              ),
              const Divider(height: 1, indent: 16),
              const SettingsItem(
                icon: Icons.location_on_outlined,
                title: 'Saved Addresses',
              ),
              const Divider(height: 1, indent: 16),
              _buildLanguageSettingItem(context),
              const Divider(height: 1, indent: 16),
              const SettingsItem(
                icon: Icons.notifications_none,
                title: 'Notification Settings',
              ),
              const Divider(height: 1, indent: 16),
              const SettingsItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Center',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Card(
          child: Column(
            children: [
              SettingsItem(icon: Icons.star_border, title: 'Reviews'),
              Divider(height: 1, indent: 16),
              SettingsItem(
                icon: Icons.question_answer_outlined,
                title: 'Questions & Answers',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Card(
          child: Column(
            children: [
              SettingsItem(
                icon: Icons.storefront_outlined,
                title: 'Sell ',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Card(
          child: Column(
            children: [
              SettingsItem(
                icon: Icons.description_outlined,
                title: 'Terms, Policies and Licenses',
              ),
              Divider(height: 1, indent: 16),
              SettingsItem(icon: Icons.help_outline, title: 'Browse FAQs'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageSettingItem(BuildContext context) {
    return const SettingsItem(
      icon: Icons.language_outlined,
      title: 'Select Language',
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Chip(
            label: Text('3'),
            backgroundColor: Colors.blue,
            labelStyle: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}

class FinanceOptionsSection extends StatelessWidget {
  const FinanceOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Options'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                FinanceOptionItem(
                  icon: Icons.money_outlined,
                  title: 'Personal Loan',
                  subtitle: 'Instant Cash upto ₹10,00,000',
                  color: Colors.purple[100],
                  iconColor: Colors.purple,
                ),
                const SizedBox(height: 16),
                FinanceOptionItem(
                  icon: Icons.credit_card,
                  title: 'Pre-approved Super Credit Card',
                  subtitle: 'Lifetime free | Instant issuance',
                  color: Colors.blue[100],
                  iconColor: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CreditScoreSection extends StatelessWidget {
  const CreditScoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Credit Score'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.credit_score,
                    color: Colors.green[800],
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Free credit score check',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Get detailed credit report instantly',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NotificationsSection extends StatelessWidget {
  const NotificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Notifications'),
        Card(
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none,
                color: Colors.orange[800],
                size: 28,
              ),
            ),
            title: const Text(
              'Tap for latest updates and offers',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Get personalized notifications',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

class ThemeSettingsSection extends StatelessWidget {
  final bool darkModeEnabled;
  final ValueChanged<bool> onThemeChanged;

  const ThemeSettingsSection({
    super.key,
    required this.darkModeEnabled,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Appearance'),
        Card(
          child: SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Switch between light and dark theme'),
            value: darkModeEnabled,
            onChanged: onThemeChanged,
            secondary: Icon(
              darkModeEnabled ? Icons.dark_mode : Icons.light_mode,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Language Preferences'),
        Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LanguageSelectionPage(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Try Flipkart in your language',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const LanguageChipsRow(),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'View all languages',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LanguageChipsRow extends StatelessWidget {
  const LanguageChipsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        LanguageChip(label: 'English', selected: true),
        LanguageChip(label: 'हिंदी'),
        LanguageChip(label: 'தமிழ்'),
        LanguageChip(label: 'తెలుగు'),
        LanguageChip(label: 'മലയാളം'),
        LanguageChip(label: 'বাংলা'),
        LanguageChip(label: 'मराठी'),
        LanguageChip(label: 'ગુજરાતી'),
        LanguageChip(label: '+3 more'),
      ],
    );
  }
}

class LanguageChip extends StatelessWidget {
  final String label;
  final bool selected;

  const LanguageChip({super.key, required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: selected
          ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
          : Colors.grey[200],
      side: selected
          ? BorderSide(color: Theme.of(context).colorScheme.primary)
          : BorderSide.none,
      labelStyle: TextStyle(
        color: selected ? Theme.of(context).colorScheme.primary : Colors.black,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Language')),
      body: ListView(
        children: const [
          LanguageTile(language: 'English', code: 'EN', selected: true),
          LanguageTile(language: 'हिंदी', code: 'HI'),
          LanguageTile(language: 'தமிழ்', code: 'TA'),
          LanguageTile(language: 'తెలుగు', code: 'TE'),
          LanguageTile(language: 'മലയാളം', code: 'ML'),
          LanguageTile(language: 'বাংলা', code: 'BN'),
          LanguageTile(language: 'मराठी', code: 'MR'),
          LanguageTile(language: 'ગુજરાતી', code: 'GU'),
          LanguageTile(language: 'ಕನ್ನಡ', code: 'KN'),
          LanguageTile(language: 'ਪੰਜਾਬੀ', code: 'PA'),
          LanguageTile(language: 'ଓଡ଼ିଆ', code: 'OR'),
        ],
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  final String language;
  final String code;
  final bool selected;

  const LanguageTile({
    super.key,
    required this.language,
    required this.code,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(language),
      subtitle: Text(code),
      trailing: selected
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      minVerticalPadding: 0,
      visualDensity: VisualDensity.compact,
    );
  }
}

class FinanceOptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? color;
  final Color? iconColor;

  const FinanceOptionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.color,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class AppVersionInfo extends StatelessWidget {
  const AppVersionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'v5.24.1 • Last updated 2 hours ago',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
      ),
    );
  }
}
