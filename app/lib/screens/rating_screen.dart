import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/volunai_logo.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});
  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  final List<Map<String, dynamic>> volunteers = [
    {'nick': '@almas_a', 'points': 750, 'rank': 1},
    {'nick': '@ariya_123', 'points': 750, 'rank': 2},
    {'nick': '@ashata2', 'points': 750, 'rank': 3},
    {'nick': '@volont_\$5', 'points': 750, 'rank': 4},
    {'nick': '@saht5a', 'points': 750, 'rank': 5},
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  Color _rankColor(int rank) {
    switch (rank) {
      case 1: return AppColors.gold;
      case 2: return AppColors.silver;
      case 3: return AppColors.bronze;
      default: return rank == 4 ? const Color(0xFFE8F5E9) : Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const SmallLogo(),
                  const Expanded(
                    child: Text('Рейтинг', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryOrange))),
                  const Icon(Icons.account_balance_outlined, size: 22),
                  const SizedBox(width: 8),
                  const Icon(Icons.chat_bubble_outline_rounded, size: 22),
                  const SizedBox(width: 8),
                  const Icon(Icons.notifications_outlined, size: 22),
                ],
              ),
            ),
            TabBar(
              controller: _tabCtrl,
              labelColor: AppColors.textDark,
              unselectedLabelColor: AppColors.textGrey,
              indicatorColor: AppColors.primaryOrange,
              tabs: const [
                Tab(text: 'Волонтеры'),
                Tab(text: 'Менторы'),
                Tab(text: 'Книголюбы'),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Самые активные
волонтеры:', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppColors.textGrey)),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 80, child: Text('Ник:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                SizedBox(width: 100, child: Text('Поинты:', textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: volunteers.length,
                itemBuilder: (context, i) {
                  final v = volunteers[i];
                  final rank = v['rank'] as int;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: _rankColor(rank).withOpacity(rank <= 3 ? 0.15 : 1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _rankColor(rank).withOpacity(0.4), width: rank <= 3 ? 1.5 : 0),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 32,
                          child: rank <= 3
                            ? Icon(Icons.emoji_events_rounded, color: _rankColor(rank), size: 28)
                            : Text('$rank', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primaryTeal.withOpacity(0.2),
                          child: const Icon(Icons.person, color: AppColors.primaryTeal),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(v['nick'] as String,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.divider),
                          ),
                          child: Text('${v['points']}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
