import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/volunai_logo.dart';
import 'search_results_screen.dart';
import 'notifications_screen.dart';
import 'rating_screen.dart';
import 'search_friends_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchCtrl = TextEditingController();
  int _selectedCategory = 0;

  final List<Map<String, dynamic>> categories = [
    {'label': 'Субботники', 'icon': Icons.park_outlined},
    {'label': 'Продукты', 'icon': Icons.restaurant_outlined},
    {'label': 'Здоровье', 'icon': Icons.favorite_border},
    {'label': 'Животные', 'icon': Icons.pets},
    {'label': 'Образование', 'icon': Icons.school_outlined},
    {'label': 'Климат', 'icon': Icons.wb_sunny_outlined},
    {'label': 'Фестивали', 'icon': Icons.celebration_outlined},
    {'label': 'Поиски пропавших', 'icon': Icons.search_outlined},
    {'label': 'Психологи', 'icon': Icons.psychology_outlined},
    {'label': 'Книги', 'icon': Icons.menu_book_outlined},
    {'label': 'Детдом', 'icon': Icons.child_friendly_outlined},
    {'label': 'Другое', 'icon': Icons.more_horiz},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Search bar
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => const SearchResultsScreen())),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: AppColors.textGrey),
                            const SizedBox(width: 8),
                            Text('Ищи ивенты по названиям или
фильтруй по назначению',
                              style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final cat = categories[index];
                          final isSelected = _selectedCategory == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _selectedCategory = index);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (_) => SearchResultsScreen(category: cat['label'])));
                            },
                            child: Column(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.primaryOrange.withOpacity(0.1) : const Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(16),
                                    border: isSelected
                                      ? Border.all(color: AppColors.primaryOrange, width: 2)
                                      : null,
                                  ),
                                  child: Icon(cat['icon'] as IconData,
                                    size: 32,
                                    color: isSelected ? AppColors.primaryOrange : AppColors.textGrey),
                                ),
                                const SizedBox(height: 6),
                                Text(cat['label'] as String,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? AppColors.primaryOrange : AppColors.textDark,
                                  )),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const SmallLogo(),
          const Expanded(
            child: Text('Поиск',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          ),
          IconButton(
            icon: const Icon(Icons.account_balance_outlined, color: AppColors.textDark),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RatingScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.textDark),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
        ],
      ),
    );
  }
}
