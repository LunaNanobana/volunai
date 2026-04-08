import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/volunai_logo.dart';
import 'notifications_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileHeader(),
                    _buildTabs(),
                    _buildAnalytics(),
                    _buildTags(),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const SmallLogo(),
          const Expanded(
            child: Text('Профиль', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark))),
          IconButton(icon: const Icon(Icons.account_balance_outlined, size: 22), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline_rounded, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 22),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primaryTeal.withOpacity(0.2),
            child: const Icon(Icons.person, size: 40, color: AppColors.primaryTeal),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Алмас
Адильбеков',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                const Text('@almas_a', style: TextStyle(fontSize: 13, color: AppColors.textGrey)),
                const SizedBox(height: 8),
                const Text('Контакты:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textGrey)),
                const Text('almas_adlibekov@gmail.com
8(777)-123-45-67
Алматы, Казахстан',
                  style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryTeal),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Text('Поинты:', style: TextStyle(fontSize: 11, color: AppColors.primaryTeal)),
                const Text('750', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryTeal)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return TabBar(
      controller: _tabController,
      labelColor: AppColors.textDark,
      unselectedLabelColor: AppColors.textGrey,
      indicatorColor: AppColors.primaryOrange,
      labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      tabs: const [
        Tab(text: 'Аналитика'),
        Tab(text: 'Ивенты'),
        Tab(text: 'Клубы'),
        Tab(text: 'Достижения'),
      ],
    );
  }

  Widget _buildAnalytics() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _AnalyticsCard(
                child: Column(children: [
                  SizedBox(
                    width: 60, height: 60,
                    child: CircularProgressIndicator(
                      value: 0.9,
                      strokeWidth: 6,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryTeal),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('90%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primaryTeal)),
                  const Text('Посещаемость', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                ]),
              )),
              const SizedBox(width: 12),
              Expanded(child: _AnalyticsCard(
                child: Column(children: [
                  const Icon(Icons.access_time, size: 36, color: AppColors.primaryOrange),
                  const Text('81', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.textDark)),
                  const Text('часов', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                ]),
              )),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _AnalyticsCard(
                child: Column(children: [
                  const Text('26', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: AppColors.textDark)),
                  const Text('Ивенты', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                ]),
              )),
              const SizedBox(width: 12),
              Expanded(child: _AnalyticsCard(
                child: Column(children: [
                  const Icon(Icons.attach_money, size: 28, color: AppColors.primaryOrange),
                  const Text('15000 тг', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark)),
                  const Text('Пожертвование', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                ]),
              )),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _AnalyticsCard(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('NU_volunteers
club', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textDark)),
                  const Text('Клубы', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                ]),
              )),
              const SizedBox(width: 12),
              Expanded(child: _AnalyticsCard(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  const Icon(Icons.emoji_events, color: AppColors.primaryOrange),
                  const Icon(Icons.people, color: AppColors.primaryTeal),
                  const Icon(Icons.star, color: Colors.purple),
                ]),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTags() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Wrap(
        spacing: 8,
        children: [
          _Tag(label: 'Волонтер', color: AppColors.primaryTeal),
          _Tag(label: 'Психолог', color: AppColors.primaryTeal),
          _Tag(label: 'Любитель животных', color: Colors.pink[100]!, textColor: Colors.pink),
        ],
      ),
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  final Widget child;
  const _AnalyticsCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Center(child: child),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  final Color? textColor;

  const _Tag({required this.label, required this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(label, style: TextStyle(fontSize: 12, color: textColor ?? color, fontWeight: FontWeight.w600)),
    );
  }
}
