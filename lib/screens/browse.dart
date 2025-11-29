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

  // 🔹 NEW: the header bar that matches your HTML screenshot
  Widget _buildDiscoverHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
            color: Color(0x14000000), // light bottom shadow
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Discover Skill Swaps',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            splashRadius: 20,
            tooltip: 'My profile',
            icon: const Icon(
              Icons.person_outline,
              color: Colors.black,
            ),
            onPressed: _onMyProfileTap,
          ),
        ],
      ),
    );
  }

  // Same category IDs as profile setup
  static const List<Map<String, String>> _allOfferCategories = [
    {'id': 'technical', 'label': 'Technical'},
    {'id': 'creative', 'label': 'Creative / Artistic'},
    {'id': 'academic', 'label': 'Academic / Educational'},
    {'id': 'business', 'label': 'Business / Professional'},
    {'id': 'life', 'label': 'Life Skills / Personal'},
    {'id': 'fitness', 'label': 'Fitness / Sports'},
    {'id': 'music', 'label': 'Music'},
    {'id': 'language', 'label': 'Languages'},
    {'id': 'other', 'label': 'Other'},
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _onMyProfileTap() {
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

  Stream<QuerySnapshot> _recommendedMatchesStream() {
    final user = _auth.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    final docRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    return docRef.snapshots().switchMap((snapshot) {
      final data = snapshot.data();
      if (data == null) {
        return const Stream.empty();
      }

      final myOffers = List<String>.from(data['offerCategories'] ?? []);
      final myWants = List<String>.from(data['wantCategories'] ?? []);

      if (myOffers.isEmpty && myWants.isEmpty) {
        return const Stream.empty();
      }

      return FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, isNotEqualTo: user.uid)
          .snapshots();
    });
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
            // 🔹 NEW: inline header bar between app bar and search
            _buildDiscoverHeader(),
            const SizedBox(height: 8),

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
                final isSelected = _selectedCategoryId == id;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryId = id;
                    });
                    _onCategoryTap(id, label);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue.shade50
                          : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected
                            ? Colors.blue.shade400
                            : Colors.grey.shade300,
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.blue.shade700
                              : Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 28),

            Text(
              "Recommended matches (early prototype)",
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade900,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "These are other users who might have overlapping offers and wants. Matching logic will get smarter later.",
              style: TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),

            StreamBuilder<QuerySnapshot>(
              stream: _recommendedMatchesStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Once more people set up their profiles, you'll see suggested matches here.",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  );
                }

                final docs = snapshot.data!.docs;

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final userDoc = docs[index];
                    return _buildUserMatchCard(userDoc);
                  },
                );
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildUserMatchCard(DocumentSnapshot userDoc) {
    final data = userDoc.data() as Map<String, dynamic>? ?? {};
    final displayName =
        (data['displayName'] ?? 'Skill Swap user') as String;
    final bio = (data['bio'] ?? '') as String;
    final location = (data['location'] ?? '') as String;
    final offers = List<String>.from(data['offerCategories'] ?? []);
    final wants = List<String>.from(data['wantCategories'] ?? []);

    final initials = _getInitials(displayName);

    final String? firstDescription;
    if (offers.isNotEmpty && wants.isNotEmpty) {
      firstDescription =
          "Can help with ${offers.first}, wants to learn ${wants.first}.";
    } else if (offers.isNotEmpty) {
      firstDescription = "Can help with ${offers.first}.";
    } else if (wants.isNotEmpty) {
      firstDescription = "Wants to learn ${wants.first}.";
    } else {
      firstDescription = null;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.blue.shade50,
            child: Text(
              initials,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blue.shade700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                if (location.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (bio.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    bio,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ],
                if (firstDescription != null) ...[
                  const SizedBox(height: 6),
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
                    Wrap(
                      spacing: 6,
                      runSpacing: -4,
                      children: [
                        ...offers.take(2).map(
                          (o) => Chip(
                            label: Text(
                              o,
                              style: const TextStyle(fontSize: 11),
                            ),
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                        ...wants.take(2).map(
                          (w) => Chip(
                            label: Text(
                              w,
                              style: const TextStyle(fontSize: 11),
                            ),
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
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
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    var initials = '';
    final parts = name.trim().split(' ');
    if (parts.isNotEmpty) {
      initials = parts[0].isNotEmpty ? parts[0][0] : '';
      if (parts.length > 1 && parts[1].isNotEmpty) {
        initials += parts[1][0];
      }
    }
    return initials.toUpperCase();
  }
}
