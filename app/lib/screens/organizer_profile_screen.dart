import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/volunai_logo.dart';
import 'event_details_screen.dart';

class OrganizerProfileScreen extends StatelessWidget {
  const OrganizerProfileScreen({super.key});

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
                  const Expanded(child: Text('Профиль', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                  const Icon(Icons.account_balance_outlined, size: 22),
                  const SizedBox(width: 8),
                  const Icon(Icons.chat_bubble_outline_rounded, size: 22),
                  const SizedBox(width: 8),
                  const Icon(Icons.notifications_outlined, size: 22),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60, height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1565C0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text('АЖ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('"Астана жастары"', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text('@astana_zhastar', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryTeal,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                minimumSize: Size.zero,
                              ),
                              child: const Text('Подписаться', style: TextStyle(color: Colors.white, fontSize: 12)),
                            ),
                            const Text('5012 членов', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Контакты:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.textGrey)),
                    const SizedBox(height: 4),
                    const Row(children: [
                      Icon(Icons.email_outlined, size: 14, color: AppColors.textGrey),
                      SizedBox(width: 4),
                      Text('astana_zhastar@gmail.com', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                    ]),
                    const Row(children: [
                      Icon(Icons.phone_outlined, size: 14, color: AppColors.textGrey),
                      SizedBox(width: 4),
                      Text('8(777)-123-45-67', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                    ]),
                    const Row(children: [
                      Icon(Icons.location_on_outlined, size: 14, color: AppColors.textGrey),
                      SizedBox(width: 4),
                      Text('Астана, Казахстан', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                    ]),
                    const SizedBox(height: 16),
                    // Tabs
                    const Row(
                      children: [
                        Text('Ивенты', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primaryOrange)),
                        SizedBox(width: 20),
                        Text('Аналитика', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                        SizedBox(width: 20),
                        Text('Прошлые
ивенты', style: TextStyle(color: AppColors.textGrey, fontSize: 11)),
                        SizedBox(width: 20),
                        Text('Достижения', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Divider(color: AppColors.primaryOrange, thickness: 2, endIndent: 250),
                    const SizedBox(height: 16),
                    // Event card
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventDetailsScreen())),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.divider),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32, height: 32,
                                    decoration: const BoxDecoration(color: Color(0xFF1565C0), shape: BoxShape.circle),
                                    child: const Center(child: Text('АЖ', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('"Астана жастары"', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('Действия Казахстана по борьбе с торговлей детьми',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            ),
                            const SizedBox(height: 8),
                            Container(height: 120, color: const Color(0xFF546E7A),
                              child: const Center(child: Icon(Icons.people_outlined, size: 48, color: Colors.white54))),
                            const SizedBox(height: 8),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('Требуется Волонтер - 45', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: const LinearProgressIndicator(
                                  value: 0.5,
                                  backgroundColor: Color(0xFFE0E0E0),
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryOrange),
                                  minHeight: 8,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(12, 0, 12, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Г.Астана, р.Есиль - ул.БухарЖырау', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                                  Text('15.09.2024 | 12:00', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9C4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFFFEB3B)),
                      ),
                      child: Row(
                        children: [
                          const Text('Об организации: ', style: TextStyle(fontSize: 13, color: AppColors.textGrey)),
                          Text('Калалык волонтерлар
штабы',
                            style: TextStyle(fontSize: 13, color: AppColors.primaryOrange, fontWeight: FontWeight.bold)),
                        ],
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
}
