import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/volunai_logo.dart';
import 'event_details_screen.dart';

class SearchResultsScreen extends StatelessWidget {
  final String? category;
  const SearchResultsScreen({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const SmallLogo(),
                  const Expanded(
                    child: Text('Поиск', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark))),
                  const Icon(Icons.account_balance_outlined, color: AppColors.textDark),
                  const SizedBox(width: 8),
                  const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.textDark),
                  const SizedBox(width: 8),
                  const Icon(Icons.notifications_outlined, color: AppColors.textDark),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(category != null ? '$category...' : 'Субботники...',
                      style: const TextStyle(color: AppColors.textGrey, fontSize: 14)),
                  ),
                  const Icon(Icons.search, color: AppColors.textGrey),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _ResultCard(
                    title: 'Загрязненное озеро требует очистки!',
                    volunteersNeeded: 100,
                    volunteersJoined: 60,
                    imageColor: const Color(0xFF78909C),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventDetailsScreen())),
                  ),
                  const SizedBox(height: 16),
                  _ResultCard(
                    title: 'Необходима срочная посадка деревьев в городском парке для улучшения качества воздуха и создания зелёной зоны отдыха!',
                    volunteersNeeded: 60,
                    volunteersJoined: 25,
                    imageColor: const Color(0xFF4CAF50),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventDetailsScreen())),
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

class _ResultCard extends StatelessWidget {
  final String title;
  final int volunteersNeeded;
  final int volunteersJoined;
  final Color imageColor;
  final VoidCallback onTap;

  const _ResultCard({required this.title, required this.volunteersNeeded,
    required this.volunteersJoined, required this.imageColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final progress = volunteersJoined / volunteersNeeded;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ),
            Container(
              height: 130,
              decoration: BoxDecoration(color: imageColor),
              child: const Center(child: Icon(Icons.image_outlined, color: Colors.white54, size: 48)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
              child: Text('Требуется Волонтеров - $volunteersNeeded',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: const Color(0xFFE0E0E0),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryOrange),
                  minHeight: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
