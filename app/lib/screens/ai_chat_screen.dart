import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/volunai_logo.dart';
import 'add_event_screen.dart';
import 'psychology_screen.dart';
import 'rating_screen.dart';
import 'notifications_screen.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});
  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final _msgCtrl = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _showOptions = true;

  final List<Map<String, dynamic>> _quickOptions = [
    {'label': 'Пост об очисте мусора', 'icon': Icons.article_outlined, 'screen': 'post'},
    {'label': 'Консультация с психологом', 'icon': Icons.psychology_outlined, 'screen': 'psychology'},
    {'label': 'Рейтинг волонтёров', 'icon': Icons.leaderboard_outlined, 'screen': 'rating'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: _showOptions ? _buildOptions(context) : _buildChat(),
            ),
            _buildInput(context),
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
            child: Text('VolunAi', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark))),
          IconButton(icon: const Icon(Icons.account_balance_outlined, size: 22), onPressed: () {}),
          IconButton(icon: const Icon(Icons.chat_bubble_outline_rounded, size: 22), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 22),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
        ],
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16)],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Чем могу помочь?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              const SizedBox(height: 24),
              for (final opt in _quickOptions)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () => _handleOption(context, opt['screen']),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(opt['icon'] as IconData, color: AppColors.primaryOrange),
                          const SizedBox(width: 12),
                          Text(opt['label'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleOption(BuildContext context, String screen) {
    switch (screen) {
      case 'post':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const AddEventScreen()));
        break;
      case 'psychology':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PsychologyScreen()));
        break;
      case 'rating':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const RatingScreen()));
        break;
    }
  }

  Widget _buildChat() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final msg = _messages[index];
        final isUser = msg['isUser'] as bool;
        return Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            decoration: BoxDecoration(
              color: isUser ? AppColors.primaryOrange : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6)],
            ),
            child: Text(msg['text'] as String,
              style: TextStyle(color: isUser ? Colors.white : AppColors.textDark)),
          ),
        );
      },
    );
  }

  Widget _buildInput(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.attach_file, color: AppColors.textGrey), onPressed: () {}),
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
                  hintText: 'Написать сообщение...',
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              if (_msgCtrl.text.isNotEmpty) {
                setState(() {
                  _showOptions = false;
                  _messages.add({'text': _msgCtrl.text, 'isUser': true});
                  _msgCtrl.clear();
                  Future.delayed(const Duration(milliseconds: 500), () {
                    setState(() {
                      _messages.add({'text': 'Обрабатываю ваш запрос...', 'isUser': false});
                    });
                  });
                });
              }
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.primaryOrange,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
