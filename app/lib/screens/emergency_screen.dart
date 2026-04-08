import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  bool _emergencyActive = false;

  final _services = const [
    _EService(
      nameKz: 'Полиция жедел қызметі',
      nameEn: 'Police Emergency',
      number: '102',
      description: 'For immediate danger or ongoing violence',
      available: '24/7',
      languages: 'Қазақша, Русский, English',
      colors: [Color(0xFFDC2626), Color(0xFFB91C1C)],
      icon: Icons.shield_outlined,
    ),
    _EService(
      nameKz: 'Үйдегі зорлық желісі',
      nameEn: 'Domestic Violence Hotline',
      number: '150',
      description: 'Crisis counseling and support',
      available: '24/7',
      languages: 'Қазақша, Русский',
      colors: [Color(0xFF7C3AED), Color(0xFF6D28D9)],
      icon: Icons.phone_outlined,
    ),
    _EService(
      nameKz: 'Әйелдер дағдарыс орталығы',
      nameEn: "Women's Crisis Center",
      number: '+7 (727) 292-91-04',
      description: 'Shelter, legal aid, psychological support',
      available: '24/7',
      languages: 'Қазақша, Русский',
      colors: [Color(0xFFDB2777), Color(0xFFBE185D)],
      icon: Icons.group_outlined,
    ),
    _EService(
      nameKz: 'Медициналық жедел жәрдем',
      nameEn: 'Medical Emergency',
      number: '103',
      description: 'For injuries requiring immediate medical attention',
      available: '24/7',
      languages: 'Қазақша, Русский, English',
      colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
      icon: Icons.medical_services_outlined,
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
          // Header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFDC2626), Color(0xFFEA580C)],
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back_ios_new,
                                  color: Colors.white, size: 20),
                            ),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Жедел көмек',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text('Emergency Help',
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 13)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Emergency active alert
                        if (_emergencyActive) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.error_outline,
                                    color: Color(0xFFDC2626), size: 18),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Emergency mode active',
                                          style: TextStyle(
                                              color: Color(0xFF991B1B),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13)),
                                      Text(
                                          'Your trusted contacts have been notified',
                                          style: TextStyle(
                                              color: Color(0xFFB91C1C),
                                              fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Tab bar
                  TabBar(
                    controller: _tabCtrl,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white60,
                    indicatorColor: Colors.white,
                    indicatorWeight: 3,
                    tabs: const [
                      Tab(text: 'Emergency'),
                      Tab(text: 'Contacts'),
                      Tab(text: 'Shelters'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Content
          Expanded(
            child: TabBarView(
              controller: _tabCtrl,
              children: [
                _EmergencyTab(
                  services: _services,
                  onActivate: () => setState(() => _emergencyActive = true),
                ),
                _ContactsTab(),
                _SheltersTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EService {
  final String nameKz;
  final String nameEn;
  final String number;
  final String description;
  final String available;
  final String languages;
  final List<Color> colors;
  final IconData icon;

  const _EService({
    required this.nameKz,
    required this.nameEn,
    required this.number,
    required this.description,
    required this.available,
    required this.languages,
    required this.colors,
    required this.icon,
  });
}

class _EmergencyTab extends StatelessWidget {
  final List<_EService> services;
  final VoidCallback onActivate;

  const _EmergencyTab({required this.services, required this.onActivate});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // One-touch emergency
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFFEF4444), Color(0xFFDC2626)]),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFFDC2626).withOpacity(0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 4))
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Жедел белсендіру / Emergency Activation',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              const SizedBox(height: 6),
              Text(
                  'This will call emergency services and notify your trusted contacts',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.85), fontSize: 13)),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: onActivate,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          color: Color(0xFFDC2626), size: 22),
                      SizedBox(width: 8),
                      Text('ACTIVATE EMERGENCY HELP',
                          style: TextStyle(
                              color: Color(0xFFDC2626),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: 0.5)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text('Жедел қызметтер / Emergency Services',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF111827))),
        const SizedBox(height: 12),
        ...services.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _ServiceCard(service: s),
            )),
      ],
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final _EService service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: service.colors),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: service.colors[0].withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                    Icon(service.icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(service.nameKz,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Text(service.nameEn,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(service.description,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.85), fontSize: 13)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.white70, size: 14),
              const SizedBox(width: 4),
              Text(service.available,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 12)),
              const SizedBox(width: 16),
              const Icon(Icons.language, color: Colors.white70, size: 14),
              const SizedBox(width: 4),
              Expanded(
                child: Text(service.languages,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone, size: 16),
                const SizedBox(width: 6),
                Text('Call ${service.number}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                        fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactsTab extends StatelessWidget {
  final _contacts = const [
    _Contact(name: 'Айгерім (Best Friend)', phone: '+7 XXX XXX XX XX', relation: 'Friend'),
    _Contact(name: 'Апа (Aunt)', phone: '+7 XXX XXX XX XX', relation: 'Family'),
    _Contact(name: 'Гүлнар (Colleague)', phone: '+7 XXX XXX XX XX', relation: 'Work'),
  ];

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
          child: Row(
            children: const [
              Icon(Icons.group_outlined, color: Color(0xFF2563EB), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'These people will be notified if you activate emergency mode',
                  style: TextStyle(color: Color(0xFF1E40AF), fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ..._contacts.map((c) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ContactCard(contact: c),
            )),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.group_outlined),
          label: const Text('Add Trusted Contact'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F3FF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFDDD6FE)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Мәдени кеңес / Cultural Tip:',
                  style: TextStyle(
                      color: Color(0xFF6D28D9),
                      fontWeight: FontWeight.bold,
                      fontSize: 13)),
              SizedBox(height: 4),
              Text(
                  'Consider adding a trusted elder woman (апа) who understands cultural context and can advocate for you within the family.',
                  style:
                      TextStyle(color: Color(0xFF7C3AED), fontSize: 13, height: 1.5)),
            ],
          ),
        ),
      ],
    );
  }
}

class _Contact {
  final String name;
  final String phone;
  final String relation;

  const _Contact(
      {required this.name, required this.phone, required this.relation});
}

class _ContactCard extends StatelessWidget {
  final _Contact contact;

  const _ContactCard({required this.contact});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)]),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                contact.name[0],
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                        fontSize: 14)),
                Text(contact.phone,
                    style: const TextStyle(
                        color: Color(0xFF6B7280), fontSize: 13)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(contact.relation,
                      style: const TextStyle(
                          color: Color(0xFF374151), fontSize: 11)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.phone_outlined,
                size: 18, color: Color(0xFF374151)),
          ),
        ],
      ),
    );
  }
}

class _SheltersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFBBF7D0)),
          ),
          child: Row(
            children: const [
              Icon(Icons.location_on_outlined,
                  color: Color(0xFF16A34A), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Жақын баспаналар / Nearest Shelters',
                        style: TextStyle(
                            color: Color(0xFF15803D),
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    SizedBox(height: 2),
                    Text('Safe spaces available 24/7 with no questions asked',
                        style: TextStyle(color: Color(0xFF16A34A), fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _ShelterCard(
          nameKz: 'Алматы әйелдер орталығы',
          nameEn: "Almaty Women's Crisis Center",
          address: 'Dostyk Ave, Almaty',
          distance: '2.3 km',
          beds: 'Available',
          services: ['Shelter', 'Legal Aid', 'Counseling', 'Children Welcome'],
        ),
        const SizedBox(height: 12),
        _ShelterCard(
          nameKz: 'Қауіпсіз баспана орталығы',
          nameEn: 'Safe Haven Center',
          address: 'Abay Ave, Almaty',
          distance: '4.7 km',
          beds: 'Call to check',
          services: ['24/7 Shelter', 'Medical', 'Job Training'],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7ED),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFED7AA)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Маңызды ақпарат / Important Information:',
                  style: TextStyle(
                      color: Color(0xFFEA580C),
                      fontWeight: FontWeight.bold,
                      fontSize: 13)),
              SizedBox(height: 8),
              _BulletRow('You can arrive without prior notice'),
              _BulletRow('No documents required for emergency admission'),
              _BulletRow('Children are welcome'),
              _BulletRow('Free services available'),
              _BulletRow('Қазақша қызмет көрсетіледі'),
            ],
          ),
        ),
      ],
    );
  }
}

class _BulletRow extends StatelessWidget {
  final String text;

  const _BulletRow(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const Text('• ', style: TextStyle(color: Color(0xFFEA580C))),
          Expanded(
            child: Text(text,
                style:
                    const TextStyle(color: Color(0xFF92400E), fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

class _ShelterCard extends StatelessWidget {
  final String nameKz;
  final String nameEn;
  final String address;
  final String distance;
  final String beds;
  final List<String> services;

  const _ShelterCard({
    required this.nameKz,
    required this.nameEn,
    required this.address,
    required this.distance,
    required this.beds,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    final available = beds == 'Available';
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.shield_outlined,
                    color: Color(0xFF16A34A), size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nameKz,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF111827))),
                    Text(nameEn,
                        style: const TextStyle(
                            color: Color(0xFF6B7280), fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  color: Color(0xFF6B7280), size: 14),
              const SizedBox(width: 4),
              Text(distance,
                  style: const TextStyle(
                      color: Color(0xFF374151), fontSize: 13)),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: available
                      ? const Color(0xFF16A34A)
                      : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  beds,
                  style: TextStyle(
                      color:
                          available ? Colors.white : const Color(0xFF374151),
                      fontSize: 11,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(address,
                style: const TextStyle(
                    color: Color(0xFF6B7280), fontSize: 12)),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: services
                .map((s) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF16A34A).withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(s,
                          style: const TextStyle(
                              color: Color(0xFF16A34A), fontSize: 11)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone_outlined, size: 16),
                  label: const Text('Call'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.navigation_outlined,
                      size: 16, color: Colors.white),
                  label: const Text('Directions',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16A34A),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
