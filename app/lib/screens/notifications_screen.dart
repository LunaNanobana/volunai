import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('Уведомления', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          const Icon(Icons.account_balance_outlined, size: 22),
          const SizedBox(width: 8),
          const Icon(Icons.chat_bubble_outline_rounded, size: 22),
          const SizedBox(width: 8),
          const Icon(Icons.notifications, size: 22, color: AppColors.primaryOrange),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _NotifBubble(text: 'Вы зарегистрировались для "Специальная Олимпиада Огайо - Помощь в офисе".'),
            const SizedBox(height: 16),
            _NotifBubble(text: 'Напоминание! "Специальная Олимпиада Огайо - Помощь в офисе" началась! Отметьтесь.'),
            const SizedBox(height: 16),
            _NotifBubble(text: 'Вы отмечены для "Специальная Олимпиада Огайо - Помощь в офисе".'),
            const SizedBox(height: 32),
            const Text('Достижение Недели!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.attach_money, color: AppColors.primaryOrange),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text('Поздравляем! Вы заслужили награду за более чем 5 Часов волонтерства на этой неделе!',
                    style: TextStyle(fontSize: 13, color: AppColors.textDark)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Получить свои бонусы!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotifBubble extends StatelessWidget {
  final String text;
  const _NotifBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.notifications, color: AppColors.primaryTeal, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primaryOrange,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 13)),
          ),
        ),
      ],
    );
  }
}
