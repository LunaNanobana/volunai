import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'organizations_screen.dart';

class SearchFriendsScreen extends StatefulWidget {
  const SearchFriendsScreen({super.key});
  @override
  State<SearchFriendsScreen> createState() => _SearchFriendsScreenState();
}

class _SearchFriendsScreenState extends State<SearchFriendsScreen> {
  bool _showOrgs = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('Поиск', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // Tabs
          Row(
            children: [
              Expanded(child: GestureDetector(
                onTap: () => setState(() => _showOrgs = false),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      color: !_showOrgs ? AppColors.primaryOrange : Colors.transparent, width: 2)),
                  ),
                  child: Text('Друзья', textAlign: TextAlign.center,
                    style: TextStyle(
                      color: !_showOrgs ? AppColors.primaryOrange : AppColors.textGrey,
                      fontWeight: FontWeight.bold)),
                ),
              )),
              Expanded(child: GestureDetector(
                onTap: () => setState(() => _showOrgs = true),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: _showOrgs ? AppColors.primaryOrange : Colors.transparent,
                    border: Border(bottom: BorderSide(
                      color: _showOrgs ? AppColors.primaryOrange : Colors.transparent, width: 2)),
                  ),
                  child: Text('Организации', textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _showOrgs ? Colors.white : AppColors.textGrey,
                      fontWeight: FontWeight.bold)),
                ),
              )),
            ],
          ),
          // Search
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: AppColors.textGrey, size: 20),
                  SizedBox(width: 8),
                  Text('Поиск Университетов', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16, color: AppColors.primaryOrange),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.divider),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Место', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
          // University list
          _UniversityItem(
            name: 'Назарбаев Университет',
            info: 'Организации: 356 - г.Астана',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrganizationsScreen())),
          ),
          _UniversityItem(
            name: 'Евразийский Национальный
Университет',
            info: 'Организации: 87 - г.Астана',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrganizationsScreen())),
          ),
          for (int i = 0; i < 4; i++)
            Container(
              height: 48,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.divider)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text(''), const Icon(Icons.chevron_right, color: AppColors.textGrey)],
              ),
            ),
        ],
      ),
    );
  }
}

class _UniversityItem extends StatelessWidget {
  final String name;
  final String info;
  final VoidCallback onTap;

  const _UniversityItem({required this.name, required this.info, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.divider))),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: const Color(0xFF003366), borderRadius: BorderRadius.circular(8)),
              child: const Center(child: Text('NU', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(info, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
              ],
            )),
            const Icon(Icons.chevron_right, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }
}
