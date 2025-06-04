import 'package:flutter/material.dart';

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
      title: 'My Shop Account',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
      ),
      darkTheme: ThemeData(
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
      ),
      themeMode: _themeMode,
      home: AccountPage(
        changeThemeMode: changeThemeMode,
        currentThemeMode: _themeMode,
      ),
    );
  }
}

class AccountPage extends StatefulWidget {
   final Function(ThemeMode) changeThemeMode;
  final ThemeMode currentThemeMode;
  const AccountPage({super.key,
   required this.changeThemeMode,
    required this.currentThemeMode,});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // ignore: unused_field
  final bool _darkModeEnabled = false;

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
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _UserProfileSection(),
            const _QuickActionsSection(),
            const _AccountOptionsSection(),
            const _FinanceOptionsSection(),
            const _CreditScoreSection(),
            const _NotificationsSection(),
            _ThemeSettingsSection(
              darkModeEnabled: widget.currentThemeMode == ThemeMode.dark,
              onThemeChanged: (value) {
                widget.changeThemeMode(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
            ),
            const _LanguageSection(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'v5.24.1 • Last updated 2 hours ago',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserProfileSection extends StatelessWidget {
  const _UserProfileSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.grey[200],
                    child: Icon(
                      Icons.person,
                      size: 36,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ajay Kumar',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          text: 'Explore Plus ',
                          style: const TextStyle(
                            color: Color(0xFF2874F0),
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: 'Silver',
                              style: TextStyle(
                                color: Colors.orange[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(text: ' >'),
                          ],
                        ),
                      ),
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
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.orange[100]!,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange[700],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Flipkart Plus Zone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                        ),
                        Text(
                          'Complete profile to unlock benefits',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange[700],
                          ),
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
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blue[100]!,
                ),
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Get latest updates of your orders',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Text('Update'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _QuickActionButton(
              icon: Icons.shopping_bag_outlined,
              label: 'Orders',
              notificationCount: 2,
            ),
            _QuickActionButton(
              icon: Icons.favorite_border,
              label: 'Wishlist',
            ),
            _QuickActionButton(
              icon: Icons.card_giftcard,
              label: 'Coupons',
            ),
            _QuickActionButton(
              icon: Icons.help_outline,
              label: 'Help',
            ),
            _QuickActionButton(
              icon: Icons.history,
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int? notificationCount;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _AccountOptionsSection extends StatelessWidget {
  const _AccountOptionsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
          child: Text(
            'Account Settings',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Card(
          child: Column(
            children: [
              const _SettingsItem(
                icon: Icons.loyalty_outlined,
                title: 'Flipkart Plus',
                subtitle: 'View benefits & offers',
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
              const Divider(height: 1, indent: 16),
              const _SettingsItem(
                icon: Icons.edit_outlined,
                title: 'Edit Profile',
                subtitle: 'Update your personal details',
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
              const Divider(height: 1, indent: 16),
              const _SettingsItem(
                icon: Icons.credit_card_outlined,
                title: 'Saved Cards & Wallets',
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
              const Divider(height: 1, indent: 16),
              const _SettingsItem(
                icon: Icons.location_on_outlined,
                title: 'Saved Addresses',
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
              const Divider(height: 1, indent: 16),
              _SettingsItem(
                icon: Icons.language_outlined,
                title: 'Select Language',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
              const Divider(height: 1, indent: 16),
              const _SettingsItem(
                icon: Icons.notifications_none,
                title: 'Notification Settings',
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
              const Divider(height: 1, indent: 16),
              const _SettingsItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Center',
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Card(
          child: Column(
            children: [
              _SettingsItem(
                icon: Icons.star_border,
                title: 'Reviews',
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
              Divider(height: 1, indent: 16),
              _SettingsItem(
                icon: Icons.question_answer_outlined,
                title: 'Questions & Answers',
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Card(
          child: Column(
            children: [
              _SettingsItem(
                icon: Icons.storefront_outlined,
                title: 'Sell on Flipkart',
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Card(
          child: Column(
            children: [
              _SettingsItem(
                icon: Icons.description_outlined,
                title: 'Terms, Policies and Licenses',
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
              Divider(height: 1, indent: 16),
              _SettingsItem(
                icon: Icons.help_outline,
                title: 'Browse FAQs',
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            )
          : null,
      trailing: trailing,
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      minVerticalPadding: 0,
      visualDensity: VisualDensity.compact,
    );
  }
}

class _FinanceOptionsSection extends StatelessWidget {
  const _FinanceOptionsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
          child: Text(
            'Finance Options',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _FinanceOptionItem(
                  icon: Icons.money_outlined,
                  title: 'Flipkart Personal Loan',
                  subtitle: 'Instant Cash upto ₹10,00,000',
                  color: Colors.purple[100],
                  iconColor: Colors.purple,
                ),
                const SizedBox(height: 16),
                _FinanceOptionItem(
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

class _FinanceOptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? color;
  final Color? iconColor;

  const _FinanceOptionItem({
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
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
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
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }
}

class _CreditScoreSection extends StatelessWidget {
  const _CreditScoreSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
          child: Text(
            'Credit Score',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Get detailed credit report instantly',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationsSection extends StatelessWidget {
  const _NotificationsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
          child: Text(
            'Notifications',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
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
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Get personalized notifications',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}

class _ThemeSettingsSection extends StatelessWidget {
  final bool darkModeEnabled;
  final ValueChanged<bool> onThemeChanged;

  const _ThemeSettingsSection({
    required this.darkModeEnabled,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
          child: Text(
            'Appearance',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
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

class _LanguageSection extends StatelessWidget {
  const _LanguageSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
          child: Text(
            'Language Preferences',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _LanguageChip(label: 'English', selected: true),
                      _LanguageChip(label: 'हिंदी'),
                      _LanguageChip(label: 'தமிழ்'),
                      _LanguageChip(label: 'తెలుగు'),
                      _LanguageChip(label: 'മലയാളം'),
                      _LanguageChip(label: 'বাংলা'),
                      _LanguageChip(label: 'मराठी'),
                      _LanguageChip(label: 'ગુજરાતી'),
                      _LanguageChip(label: '+3 more'),
                    ],
                  ),
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

class _LanguageChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _LanguageChip({
    required this.label,
    this.selected = false,
  });

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
        color: selected
            ? Theme.of(context).colorScheme.primary
            : Colors.black,
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
      appBar: AppBar(
        title: const Text('Select Language'),
      ),
      body: ListView(
        children: const [
          _LanguageTile(
            language: 'English',
            code: 'EN',
            selected: true,
          ),
          _LanguageTile(
            language: 'हिंदी',
            code: 'HI',
          ),
          _LanguageTile(
            language: 'தமிழ்',
            code: 'TA',
          ),
          _LanguageTile(
            language: 'తెలుగు',
            code: 'TE',
          ),
          _LanguageTile(
            language: 'മലയാളം',
            code: 'ML',
          ),
          _LanguageTile(
            language: 'বাংলা',
            code: 'BN',
          ),
          _LanguageTile(
            language: 'मराठी',
            code: 'MR',
          ),
          _LanguageTile(
            language: 'ગુજરાતી',
            code: 'GU',
          ),
          _LanguageTile(
            language: 'ಕನ್ನಡ',
            code: 'KN',
          ),
          _LanguageTile(
            language: 'ਪੰਜਾਬੀ',
            code: 'PA',
          ),
          _LanguageTile(
            language: 'ଓଡ଼ିଆ',
            code: 'OR',
          ),
        ],
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final String language;
  final String code;
  final bool selected;

  const _LanguageTile({
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