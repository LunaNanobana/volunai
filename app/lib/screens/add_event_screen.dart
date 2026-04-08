import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/volunai_logo.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});
  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  bool _generated = false;

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
                  IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
                  const Expanded(
                    child: Text('Добавить', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark))),
                  const Icon(Icons.bookmark_border),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: _generated ? _buildGeneratedPost() : _buildAIPost(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAIPost() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text('Посмотрите пост сгенерированный AI системой разпознавания вашего загруженного файла:',
          style: TextStyle(fontSize: 14, color: AppColors.textDark)),
        const SizedBox(height: 20),
        // Image upload area
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF78909C),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(Icons.water_outlined, size: 64, color: Colors.white54)),
        ),
        const SizedBox(height: 20),
        // Generated content box
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.divider),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Заголовок:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text('Загрязненное озеро требует очистки!'),
              SizedBox(height: 8),
              Text('Описание:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text('На данном участке выявлено загрязнение окружающей среды. Мусор или другие отходы негативно влияют на экосистему и требуют уборки.'),
              SizedBox(height: 8),
              Text('Рекомендуемая техника для уборки: (перчатки, мешки для мусора, лопаты и т.д.)'),
              SizedBox(height: 8),
              Text('Призываем волонтеров присоединиться!', style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 8),
              Text('Требуется Волонтеров - 100', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Г.Астана, р.Нура - оз.Талдыколь'),
              Text('14.09.2024 | 9:00-14:00'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.edit_outlined, color: AppColors.primaryOrange, size: 18),
            const SizedBox(width: 4),
            Text('Редактировать...', style: TextStyle(color: AppColors.primaryOrange, fontSize: 13)),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Опубликовать'),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primaryTeal),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('Предпросмтр', style: TextStyle(color: AppColors.primaryTeal, fontSize: 15)),
          ),
        ),
      ],
    );
  }

  Widget _buildGeneratedPost() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text('Пост об очисте мусора',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 16),
        Container(
          height: 140,
          decoration: BoxDecoration(
            color: const Color(0xFF78909C),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: Icon(Icons.water_outlined, size: 48, color: Colors.white54)),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.psychology_rounded, color: AppColors.primaryOrange, size: 28),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_outlined, color: AppColors.primaryTeal, size: 20),
                  const SizedBox(width: 8),
                  const Text('Пост
генерируется.
..', style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
