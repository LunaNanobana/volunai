import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/volunai_logo.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const SmallLogo(),
                  const Expanded(
                    child: Text('Подробности', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                  IconButton(
                    icon: const Icon(Icons.share_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Посадка деревьев для улучшения качества воздуха и создания зелёной зоны отдыха!',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark),
                    ),
                    const SizedBox(height: 16),
                    // Event image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        color: const Color(0xFF4CAF50),
                        child: const Center(
                          child: Icon(Icons.park_outlined, size: 64, color: Colors.white54)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Progress
                    Row(
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(
                                  value: 25/60,
                                  strokeWidth: 5,
                                  backgroundColor: Colors.grey[200],
                                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryOrange),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('25/60', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                            Text('Занято мест', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Volunteers
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          Container(
                            margin: EdgeInsets.only(right: i < 2 ? -8 : 12),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: [AppColors.primaryTeal, AppColors.primaryOrange, Colors.purple][i],
                              child: const Icon(Icons.person, color: Colors.white, size: 18),
                            ),
                          ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.textGrey),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: const Text('Волонтеры(21)',
                            style: TextStyle(color: AppColors.textDark, fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 12),
                    Row(children: [
                      const Icon(Icons.location_on_outlined, color: AppColors.primaryOrange),
                      const SizedBox(width: 8),
                      const Text('Центральный парк,
г.Астана',
                        style: TextStyle(fontSize: 14, color: AppColors.textDark)),
                    ]),
                    const SizedBox(height: 12),
                    Row(children: [
                      const Icon(Icons.calendar_today_outlined, color: AppColors.textGrey),
                      const SizedBox(width: 8),
                      const Text('Сб, 16 Июля, 2024
9:00-14:00',
                        style: TextStyle(fontSize: 14, color: AppColors.textDark)),
                    ]),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryOrange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text('Присоединиться',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
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
