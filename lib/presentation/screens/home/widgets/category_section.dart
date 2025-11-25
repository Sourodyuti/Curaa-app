import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/app_theme.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Food', 'icon': Icons.restaurant, 'color': Color(0xFFEC4899)},
    {'name': 'Toys', 'icon': Icons.sports_tennis, 'color': Color(0xFF8B5CF6)},
    {'name': 'Grooming', 'icon': Icons.content_cut, 'color': Color(0xFF06B6D4)},
    {'name': 'Health', 'icon': Icons.favorite, 'color': Color(0xFFEF4444)},
    {'name': 'Accessories', 'icon': Icons.shopping_bag, 'color': Color(0xFFF59E0B)},
    {'name': 'Training', 'icon': Icons.school, 'color': Color(0xFF10B981)},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Shop by Category',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return _CategoryCard(
                name: category['name'],
                icon: category['icon'],
                color: category['color'],
                onTap: () {
                  // Navigate to products with category filter
                  context.push('/products?category=${category['name']}');
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({
    Key? key,
    required this.name,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
