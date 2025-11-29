import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_setup.dart';
import 'category_results.dart';


class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  String _searchQuery = '';
  String? _selectedCategoryId;

  // Same category IDs as profile setup
  static const List<Map<String, String>> _allOfferCategories = [
    {'id': 'technical', 'label': 'Technical'},
    {'id': 'creative', 'label': 'Creative / Artistic'},
    {'id': 'academic', 'label': 'Academic / Educational'},
    {'id': 'business', 'label': 'Business / Professional'},
    {'id': 'trades', 'label': 'Trades / Hands-On'},
    {'id': 'lifestyle', 'label': 'Lifestyle & Personal Dev'},
    {'id': 'social', 'label': 'Social & Community'},
    {'id': 'digital_content', 'label': 'Digital Content / Social Media'},
    {'id': 'career', 'label': 'Career & Tech Advancement'},
  ];

  static const Map<String, IconData> _categoryIcons = {
    'technical': Icons.code,
    'creative': Icons.palette_rounded,
    'academic': Icons.menu_book_rounded,
    'business': Icons.business_center_rounded,
    'trades': Icons.handyman_rounded,
    'lifestyle': Icons.self_improvement_rounded,
    'social': Icons.people_alt_rounded,
    'digital_content': Icons.smartphone_rounded,
    'career': Icons.trending_up_rounded,
  };

  void _onMyProfileTap() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You need to be signed in to view your profile.'),
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ProfileSetupScreen(),
      ),
    );
  }

void _onCategoryTap(String id, String label) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => CategoryResultsScreen(
        categoryId: id,
        categoryLabel: label,
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Discover Skill Swaps',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black),
            tooltip: 'My profile',
            onPressed: _onMyProfileTap,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search Bar (UI only for now)
            TextField(
              decoration: InputDecoration(
                hintText: "Search people or skills... (coming soon)",
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
                prefixIcon:
                    Icon(Icons.search_rounded, color: Colors.grey.shade600),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: Colors.blue.shade400,
                    width: 1.4,
                  ),
                ),
              ),
              style: const TextStyle(fontSize: 15),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.trim();
                });
              },
            ),

            const SizedBox(height: 24),

            // 🔹 Categories
            Text(
              "Browse by category",
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.1,
              children: _allOfferCategories.map((cat) {
                final id = cat['id']!;
                final label = cat['label']!;
                final icon = _categoryIcons[id] ?? Icons.category_rounded;
                final isSelected = _selectedCategoryId == id;

                return CategoryTile(
                  icon: icon,
                  label: label,
                  selected: isSelected,
                  onTap: () => _onCategoryTap(id, label),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            Text(
              "Tap a category to see people who offer skills in that area.",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== CATEGORY TILE =====================

class CategoryTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.blue.shade600;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? baseColor.withOpacity(0.08) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? baseColor : Colors.grey.shade200,
            width: selected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26,
              color: selected ? baseColor : Colors.blue.shade600,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.black : Colors.grey.shade800,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}

// ===================== CATEGORY RESULTS SCREEN =====================

class CategoryResultsScreen extends StatelessWidget {
  final String categoryId;
  final String categoryLabel;

  const CategoryResultsScreen({
    super.key,
    required this.categoryId,
    required this.categoryLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          categoryLabel,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Failed to load users. Please try again.'),
            );
          }

          final docs = snapshot.data?.docs ?? [];

          final filtered = docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final offersDynamic =
                data['offers'] as List<dynamic>? ?? [];
            final offers =
                offersDynamic.whereType<Map<String, dynamic>>().toList();

            if (offers.isEmpty) return false;

            final hasCategory = offers.any((offer) {
              final cat = (offer['category'] ?? '').toString().trim();
              return cat == categoryId;
            });

            return hasCategory;
          }).toList();

          if (filtered.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'No one has listed skills in "$categoryLabel" yet.\nCheck back soon!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final doc = filtered[index];
              final data = doc.data() as Map<String, dynamic>;

              final firstName =
                  (data['firstName'] ?? '').toString().trim();
              final lastName =
                  (data['lastName'] ?? '').toString().trim();
              final fullName = (firstName.isEmpty && lastName.isEmpty)
                  ? 'Unnamed user'
                  : '$firstName $lastName';

              final offersDynamic =
                  data['offers'] as List<dynamic>? ?? [];
              final offers =
                  offersDynamic.whereType<Map<String, dynamic>>().toList();

              // Only keep offers in this category for display
              final categoryOffers = offers.where((offer) {
                final cat = (offer['category'] ?? '').toString().trim();
                return cat == categoryId;
              }).toList();

              return UserSkillCard(
                name: fullName,
                offers: categoryOffers,
              );
            },
          );
        },
      ),
    );
  }
}

// ===================== USER SKILL CARD =====================

class UserSkillCard extends StatelessWidget {
  final String name;
  final List<Map<String, dynamic>> offers;

  const UserSkillCard({
    super.key,
    required this.name,
    required this.offers,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Take first 3 skills for chips
    final topOffers = offers.take(3).toList();

    // Use first offer description as preview if available
    String? firstDescription;
    if (offers.isNotEmpty) {
      final raw = offers.first['description']?.toString().trim() ?? '';
      if (raw.isNotEmpty) {
        firstDescription = raw;
      }
    }

    String initials = '';
    final parts = name.split(' ');
    if (parts.isNotEmpty) {
      initials = parts[0].isNotEmpty ? parts[0][0] : '';
      if (parts.length > 1 && parts[1].isNotEmpty) {
        initials += parts[1][0];
      }
    }
    initials = initials.toUpperCase();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: avatar + name
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  initials.isEmpty ? 'S' : initials,
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          if (topOffers.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: topOffers.map((offer) {
                final skillName =
                    (offer['name'] ?? '').toString().trim();
                final level =
                    (offer['level'] ?? '').toString().trim();
                final label =
                    level.isEmpty ? skillName : '$skillName • $level';

                return Chip(
                  label: Text(
                    label,
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: Colors.blue.shade50,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }).toList(),
            )
          else
            Text(
              'No skills listed yet.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),

          if (firstDescription != null) ...[
            const SizedBox(height: 8),
            Text(
              firstDescription,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 13,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.swap_horiz_rounded,
                      size: 18, color: Colors.blue.shade600),
                  const SizedBox(width: 6),
                  Text(
                    "Open to swap",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // Later: navigate to full profile / send request
                },
                child: const Text('View details'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
