import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/volunai_logo.dart';
import 'event_details_screen.dart';
import 'notifications_screen.dart';
import 'rating_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text('Недавние События',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                    textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  _EventCard(
                    username: 'Eco_Life',
                    title: 'Загрязненное озеро требует очистки!',
                    volunteersNeeded: 100,
                    volunteersJoined: 60,
                    location: 'Г.Астана, р.Нура - оз.Талдыколь',
                    date: '14.09.2024 | 9:00-14:00',
                    imageColor: const Color(0xFF78909C),
                    imageIcon: Icons.water_outlined,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventDetailsScreen())),
                  ),
                  const SizedBox(height: 16),
                  _EventCard(
                    username: 'Pet.lover',
                    title: 'Ищем Дом для Собаки!',
                    volunteersNeeded: 1,
                    volunteersJoined: 0,
                    location: 'Г.Астана, р.Есиль - ул.БухарЖырау',
                    date: '15.09.2024 | 12:00',
                    imageColor: const Color(0xFF8D6E63),
                    imageIcon: Icons.pets,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventDetailsScreen())),
                  ),
                  const SizedBox(height: 16),
                  _EventCard(
                    username: 'Ai',
                    title: 'Помощь людям в подтопленных зонах',
                    volunteersNeeded: 40,
                    volunteersJoined: 25,
                    location: 'Павлодарская область',
                    date: '14.09.2024 | 9:00-14:00',
                    imageColor: const Color(0xFF546E7A),
                    imageIcon: Icons.flood_outlined,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventDetailsScreen())),
                  ),
                  const SizedBox(height: 16),
                  _EventCard(
                    username: 'Ai',
                    title: 'Мероприятие! Обсуждение книги «Проект "Аве Мария"»',
                    volunteersNeeded: 20,
                    volunteersJoined: 8,
                    location: 'Г.Алматы, кафе "Took"',
                    date: '14.09.2024 | 9:00-14:00',
                    imageColor: const Color(0xFF4A148C),
                    imageIcon: Icons.menu_book_rounded,
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

  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const SmallLogo(),
          const Expanded(
            child: Text('Главная',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          ),
          IconButton(
            icon: const Icon(Icons.account_balance_outlined, color: AppColors.textDark),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RatingScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.textDark),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final String username;
  final String title;
  final int volunteersNeeded;
  final int volunteersJoined;
  final String location;
  final String date;
  final Color imageColor;
  final IconData imageIcon;
  final VoidCallback onTap;

  const _EventCard({
    required this.username, required this.title, required this.volunteersNeeded,
    required this.volunteersJoined, required this.location, required this.date,
    required this.imageColor, required this.imageIcon, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progress = volunteersNeeded > 0 ? volunteersJoined / volunteersNeeded : 0.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: AppColors.primaryTeal.withOpacity(0.2),
                    child: Icon(Icons.person, size: 16, color: AppColors.primaryTeal),
                  ),
                  const SizedBox(width: 8),
                  Text(username, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ),
            const SizedBox(height: 8),
            Container(
              height: 140,
              margin: const EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                color: imageColor,
                image: DecorationImage(
                  image: const AssetImage('assets/images/home_screen.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(imageColor.withOpacity(0.5), BlendMode.overlay),
                ),
              ),
              child: Center(
                child: Icon(imageIcon, color: Colors.white54, size: 48),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
              child: Text('Требуется Волонтеров - $volunteersNeeded',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textDark)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Icon(Icons.location_on_outlined, size: 12, color: AppColors.primaryOrange),
                    const SizedBox(width: 4),
                    Text(location, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
                  ]),
                  const SizedBox(height: 2),
                  Row(children: [
                    const Icon(Icons.access_time, size: 12, color: AppColors.textGrey),
                    const SizedBox(width: 4),
                    Text(date, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
