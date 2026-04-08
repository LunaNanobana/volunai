import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  final _emergency = const [
    _EmContact(
      nameKz: 'Үйдегі зорлық-зомбылық желісі',
      nameEn: 'National Domestic Violence Hotline',
      number: '150',
      available: '24/7',
      languages: 'Қазақша, Русский, English',
    ),
    _EmContact(
      nameKz: 'Әйелдер дағдарыс орталығы',
      nameEn: "Women's Crisis Center",
      number: '+7 (727) 292-91-04',
      available: '24/7',
      languages: 'Қазақша, Русский',
    ),
    _EmContact(
      nameKz: 'Полиция (Отбасылық зорлық бөлімі)',
      nameEn: 'Police (Domestic Violence Unit)',
      number: '102',
      available: '24/7',
      languages: 'Қазақша, Русский, English',
    ),
  ];

  final _legal = const [
    _LegalResource(
      titleKz: 'Қазақстандағы құқықтарыңыз',
      titleEn: 'Understanding Your Rights in Kazakhstan',
      desc: "Complete guide to women's rights and legal protections",
      type: 'PDF Guide',
      icon: Icons.description_outlined,
    ),
    _LegalResource(
      titleKz: 'Қорғаныс қалай алу керек',
      titleEn: 'How to File a Restraining Order',
      desc: 'Step-by-step process and required documents',
      type: 'Guide',
      icon: Icons.balance_outlined,
    ),
    _LegalResource(
      titleKz: 'Тегін заң көмегі ұйымдары',
      titleEn: 'Free Legal Aid Organizations',
      desc: 'List of organizations providing free legal support',
      type: 'Directory',
      icon: Icons.menu_book_outlined,
    ),
    _LegalResource(
      titleKz: 'Неке құқықтары және мәжбүрлі неке',
      titleEn: 'Marriage Rights & Forced Marriage',
      desc: 'Your rights regarding marriage choice and cultural pressure',
      type: 'Article',
      icon: Icons.favorite_border,
    ),
  ];

  final _education = const [
    _EduContent(
      titleKz: 'Зорлық-зомбылықты тану',
      titleEn: 'Recognizing Abuse: Types and Warning Signs',
      duration: '8 min read',
      category: 'Education',
      categoryColor: Color(0xFFDC2626),
      categoryBg: Color(0xFFFEE2E2),
    ),
    _EduContent(
      titleKz: 'Қауіпсіздік жоспары құру',
      titleEn: 'Creating a Safety Plan',
      duration: '12 min read',
      category: 'Safety',
      categoryColor: Color(0xFFEA580C),
      categoryBg: Color(0xFFFFEDD5),
    ),
    _EduContent(
      titleKz: 'Мәдени дәстүрлер мен құқықтар',
      titleEn: 'Cultural Traditions vs. Your Rights',
      duration: '10 min read',
      category: 'Culture',
      categoryColor: Color(0xFF7C3AED),
      categoryBg: Color(0xFFEDE9FE),
    ),
    _EduContent(
      titleKz: 'Әйелдердің қаржылық тәуелсіздігі',
      titleEn: 'Financial Independence for Women',
      duration: '15 min read',
      category: 'Empowerment',
      categoryColor: Color(0xFF16A34A),
      categoryBg: Color(0xFFDCFCE7),
    ),
    _EduContent(
      titleKz: 'Психикалық жарақаттан айығу',
      titleEn: 'Healing from Trauma',
      duration: '11 min read',
      category: 'Mental Health',
      categoryColor: Color(0xFF2563EB),
      categoryBg: Color(0xFFDBEAFE),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF16A34A), Color(0xFF059669)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 12),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: 20),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ресурстар',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            Text('Resources & Information',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabCtrl,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white60,
                    indicatorColor: Colors.white,
                    indicatorWeight: 3,
                    tabs: const [
                      Tab(text: 'Emergency'),
                      Tab(text: 'Legal'),
                      Tab(text: 'Learn'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabCtrl,
              children: [
                _EmergencyTab(contacts: _emergency),
                _LegalTab(resources: _legal),
                _EducationTab(content: _education),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmContact {
  final String nameKz, nameEn, number, available, languages;

  const _EmContact({
    required this.nameKz,
    required this.nameEn,
    required this.number,
    required this.available,
    required this.languages,
  });
}

class _LegalResource {
  final String titleKz, titleEn, desc, type;
  final IconData icon;

  const _LegalResource({
    required this.titleKz,
    required this.titleEn,
    required this.desc,
    required this.type,
    required this.icon,
  });
}

class _EduContent {
  final String titleKz, titleEn, duration, category;
  final Color categoryColor, categoryBg;

  const _EduContent({
    required this.titleKz,
    required this.titleEn,
    required this.duration,
    required this.category,
    required this.categoryColor,
    required this.categoryBg,
  });
}

class _EmergencyTab extends StatelessWidget {
  final List<_EmContact> contacts;

  const _EmergencyTab({required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF2F2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFCA5A5)),
          ),
          child: const Row(
            children: [
              Icon(Icons.phone_outlined, color: Color(0xFFDC2626), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Жедел байланыс / Emergency Contacts',
                        style: TextStyle(
                            color: Color(0xFF991B1B),
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    SizedBox(height: 2),
                    Text(
                        "If you're in immediate danger, call emergency services",
                        style:
                            TextStyle(color: Color(0xFFB91C1C), fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ...contacts.map((c) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _EmContactCard(contact: c),
            )),
      ],
    );
  }
}

class _EmContactCard extends StatelessWidget {
  final _EmContact contact;

  const _EmContactCard({required this.contact});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(contact.nameKz,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF111827))),
          const SizedBox(height: 4),
          Text(contact.nameEn,
              style: const TextStyle(
                  color: Color(0xFF6B7280), fontSize: 13)),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.phone, color: Color(0xFF16A34A), size: 16),
              const SizedBox(width: 6),
              Text(contact.number,
                  style: const TextStyle(
                      color: Color(0xFF16A34A),
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
            ],
          ),
          const SizedBox(height: 4),
          Text('Available: ${contact.available}',
              style: const TextStyle(
                  color: Color(0xFF6B7280), fontSize: 12)),
          Text('Languages: ${contact.languages}',
              style: const TextStyle(
                  color: Color(0xFF6B7280), fontSize: 12)),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.phone, size: 16, color: Colors.white),
            label: const Text('Call Now',
                style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF16A34A),
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegalTab extends StatelessWidget {
  final List<_LegalResource> resources;

  const _LegalTab({required this.resources});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFBFDBFE)),
          ),
          child: const Row(
            children: [
              Icon(Icons.balance_outlined, color: Color(0xFF2563EB), size: 18),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Legal Rights',
                      style: TextStyle(
                          color: Color(0xFF1E40AF),
                          fontWeight: FontWeight.bold,
                          fontSize: 13)),
                  SizedBox(height: 2),
                  Text(
                      'All resources available in Kazakh, Russian, English',
                      style:
                          TextStyle(color: Color(0xFF2563EB), fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ...resources.map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _LegalCard(resource: r),
            )),
      ],
    );
  }
}

class _LegalCard extends StatelessWidget {
  final _LegalResource resource;

  const _LegalCard({required this.resource});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(resource.icon,
                color: const Color(0xFF2563EB), size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(resource.titleKz,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xFF111827))),
                          const SizedBox(height: 2),
                          Text(resource.titleEn,
                              style: const TextStyle(
                                  color: Color(0xFF6B7280), fontSize: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(resource.type,
                          style: const TextStyle(
                              color: Color(0xFF374151), fontSize: 11)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(resource.desc,
                    style: const TextStyle(
                        color: Color(0xFF6B7280), fontSize: 12, height: 1.4)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download_outlined, size: 14),
                      label: const Text('Download', style: TextStyle(fontSize: 12)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.open_in_new, size: 14),
                      label: const Text('Open', style: TextStyle(fontSize: 12)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EducationTab extends StatelessWidget {
  final List<_EduContent> content;

  const _EducationTab({required this.content});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F3FF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFDDD6FE)),
          ),
          child: const Row(
            children: [
              Icon(Icons.menu_book_outlined, color: Color(0xFF7C3AED), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Білім алу / Educational Content',
                        style: TextStyle(
                            color: Color(0xFF6D28D9),
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    SizedBox(height: 2),
                    Text(
                        'Knowledge is power. Learn about your rights and how to protect yourself.',
                        style:
                            TextStyle(color: Color(0xFF7C3AED), fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ...content.map((c) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _EduCard(content: c),
            )),
      ],
    );
  }
}

class _EduCard extends StatelessWidget {
  final _EduContent content;

  const _EduCard({required this.content});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7C3AED), Color(0xFFDB2777)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: const Center(
              child: Icon(Icons.menu_book_outlined,
                  color: Colors.white, size: 32),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(content.titleKz,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF111827))),
                const SizedBox(height: 2),
                Text(content.titleEn,
                    style: const TextStyle(
                        color: Color(0xFF6B7280), fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: content.categoryBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(content.category,
                          style: TextStyle(
                              color: content.categoryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(width: 8),
                    Text(content.duration,
                        style: const TextStyle(
                            color: Color(0xFF6B7280), fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 36),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text('Read Article',
                      style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
