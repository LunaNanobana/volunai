import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/volunai_logo.dart';

class PsychologyScreen extends StatefulWidget {
  const PsychologyScreen({super.key});
  @override
  State<PsychologyScreen> createState() => _PsychologyScreenState();
}

class _PsychologyScreenState extends State<PsychologyScreen> {
  final _msgCtrl = TextEditingController();
  int _stage = 0;

  final List<String> _questions = [
    'Пройдите наш психологический тест:
1)Вы испытываете напряжение или вам не по себе?',
    '2) Как часто это происходит?',
    '3) Влияет ли это на вашу повседневную жизнь?',
  ];

  final List<String> _answers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
                  const Expanded(
                    child: Text('VolunAi', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // User message
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: const Text('Консультация
с психологом',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // AI response
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40, height: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryOrange,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.psychology_rounded, color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
                          ),
                          child: Text(_stage < _questions.length ? _questions[_stage] : 'У вас возможно:
Повышенная тревожность',
                            style: const TextStyle(fontSize: 14, color: AppColors.textDark)),
                        ),
                      ),
                    ],
                  ),
                  if (_stage >= _questions.length) ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Column(
                        children: [
                          const Text('Мероприятие! Инфосессия насчет темы "Тревожные расстройства"',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          const SizedBox(height: 8),
                          Container(height: 80, color: const Color(0xFF1565C0),
                            child: const Center(child: Icon(Icons.people_outlined, color: Colors.white, size: 40))),
                          const SizedBox(height: 8),
                          Row(children: [
                            const Icon(Icons.group, size: 16, color: AppColors.primaryOrange),
                            const SizedBox(width: 4),
                            const Text('Socially Strong - г.Астана', style: TextStyle(fontSize: 12)),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.attach_file, color: AppColors.textGrey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _msgCtrl,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_stage < _questions.length) _stage++;
                        _msgCtrl.clear();
                      });
                    },
                    child: Container(
                      width: 44, height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryOrange,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                    ),
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
