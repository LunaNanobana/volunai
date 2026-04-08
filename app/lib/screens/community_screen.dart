import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class _Post {
  final int id;
  final String author;
  final String time;
  final String content;
  final String category;
  int likes;
  final int replies;
  final bool isAnonymous;

  _Post({
    required this.id,
    required this.author,
    required this.time,
    required this.content,
    required this.category,
    required this.likes,
    required this.replies,
    required this.isAnonymous,
  });
}

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  final _newPostCtrl = TextEditingController();
  final Set<int> _liked = {};

  final List<_Post> _posts = [
    _Post(
      id: 1,
      author: 'Аноним 🌸',
      time: '2 сағат бұрын',
      content:
          'Бүгін үлкен қадам жасадым - психологпен алғаш рет кездестім. Бөлісу өте қиын болды, бірақ жеңілдеген сияқты. Сіздер жалғыз емессіздер.\n\nToday I took a big step - met with a psychologist for the first time. It was hard to share but I feel lighter. You are not alone.',
      category: 'Sharing',
      likes: 24,
      replies: 8,
      isAnonymous: true,
    ),
    _Post(
      id: 2,
      author: 'Күншуақ',
      time: '5 hours ago',
      content:
          'For anyone dealing with family pressure about marriage - remember that your life is yours. In our culture, they say "қыз - қонақ", but you are not just a guest in life. You are the author of your story. Stay strong! 💪',
      category: 'Support',
      likes: 45,
      replies: 15,
      isAnonymous: false,
    ),
    _Post(
      id: 3,
      author: 'Anonymous User',
      time: '1 день назад',
      content:
          'Спасибо всем за поддержку вчера. Ваши слова помогли мне найти силы обратиться за помощью. Сегодня я подала заявление. Это страшно, но я знаю, что делаю правильно.',
      category: 'Victory',
      likes: 67,
      replies: 23,
      isAnonymous: true,
    ),
    _Post(
      id: 4,
      author: 'Әсем',
      time: '2 days ago',
      content:
          'Resource sharing: I found a great legal aid organization that helps women for free. They understand cultural sensitivities and can provide advice in Kazakh, Russian, and English. DM me if you need the contact! 🤝',
      category: 'Resources',
      likes: 89,
      replies: 31,
      isAnonymous: false,
    ),
    _Post(
      id: 5,
      author: 'Аноним 🦋',
      time: '3 күн бұрын',
      content:
          'Балаларыммен кеткенімді ойлап отырмын. Қорқамын, бірақ білемін бұл керек. Біреу осындай жағдайдан өткен бе? Кеңес керек.\n\nThinking of leaving with my children. I\'m scared but I know it\'s necessary. Has anyone been through this? Need advice.',
      category: 'Advice',
      likes: 34,
      replies: 42,
      isAnonymous: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _newPostCtrl.dispose();
    super.dispose();
  }

  void _toggleLike(int id) {
    setState(() {
      if (_liked.contains(id)) {
        _liked.remove(id);
        _posts.firstWhere((p) => p.id == id).likes--;
      } else {
        _liked.add(id);
        _posts.firstWhere((p) => p.id == id).likes++;
      }
    });
  }

  void _showNewPost() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Share Anonymously',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF111827))),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lock_outline,
                        color: Color(0xFF2563EB), size: 16),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Your identity is protected. Share safely.',
                        style:
                            TextStyle(color: Color(0xFF1E40AF), fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _newPostCtrl,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText:
                      'Share your story, ask for advice, or offer support...',
                  filled: true,
                  fillColor: const Color(0xFFF3F4F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GradientButton(
                      text: 'Post',
                      gradient: AppColors.blueCyan,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
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
                colors: [Color(0xFF2563EB), Color(0xFF0891B2)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: 20),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Қауымдастық',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Text('Community Support',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 13)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _showNewPost,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.add,
                                color: Color(0xFF2563EB), size: 22),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Tab bar
                    Row(
                      children: [
                        _TabChip(
                          icon: Icons.group_outlined,
                          label: 'Барлығы / All',
                          active: _tabCtrl.index == 0,
                          onTap: () => setState(() => _tabCtrl.index = 0),
                        ),
                        const SizedBox(width: 8),
                        _TabChip(
                          icon: Icons.trending_up,
                          label: 'Танымал / Trending',
                          active: _tabCtrl.index == 1,
                          onTap: () => setState(() => _tabCtrl.index = 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),

          // Guidelines banner
          Container(
            color: const Color(0xFFF5F3FF),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                const Icon(Icons.favorite_outline,
                    color: Color(0xFF7C3AED), size: 16),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Біздің қауымдастық - қауіпсіз кеңістік. Be kind, supportive, and respectful.',
                    style: TextStyle(color: Color(0xFF6D28D9), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

          // Posts
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _posts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                final p = _posts[i];
                return _PostCard(
                  post: p,
                  liked: _liked.contains(p.id),
                  onLike: () => _toggleLike(p.id),
                );
              },
            ),
          ),

          // Safety notice
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(
                16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
            child: Row(
              children: [
                const Icon(Icons.lock_outline,
                    color: Color(0xFF6B7280), size: 14),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'All posts are monitored for safety. Report harmful content anytime.',
                    style: TextStyle(color: Color(0xFF6B7280), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _TabChip(
      {required this.icon,
      required this.label,
      required this.active,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 14,
                color: active
                    ? const Color(0xFF2563EB)
                    : Colors.white),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: active ? const Color(0xFF2563EB) : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final _Post post;
  final bool liked;
  final VoidCallback onLike;

  const _PostCard(
      {required this.post, required this.liked, required this.onLike});

  Color get _categoryColor {
    switch (post.category) {
      case 'Support':
        return const Color(0xFF16A34A);
      case 'Victory':
        return const Color(0xFF2563EB);
      case 'Resources':
        return const Color(0xFF7C3AED);
      case 'Advice':
        return const Color(0xFFEA580C);
      default:
        return const Color(0xFF6B7280);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 2))
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)]),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    post.isAnonymous ? '🔒' : post.author[0],
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.author,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111827),
                            fontSize: 14)),
                    Text(post.time,
                        style: const TextStyle(
                            color: Color(0xFF9CA3AF), fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _categoryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _categoryColor.withOpacity(0.3)),
                ),
                child: Text(
                  post.category,
                  style: TextStyle(
                      color: _categoryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            post.content,
            style: const TextStyle(
                color: Color(0xFF374151), fontSize: 14, height: 1.6),
          ),
          const SizedBox(height: 12),
          Divider(color: const Color(0xFFE5E7EB), height: 1),
          const SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: onLike,
                child: Row(
                  children: [
                    Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: liked
                          ? const Color(0xFFDB2777)
                          : const Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 4),
                    Text('${post.likes}',
                        style: TextStyle(
                            color: liked
                                ? const Color(0xFFDB2777)
                                : const Color(0xFF6B7280),
                            fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  const Icon(Icons.chat_bubble_outline,
                      size: 18, color: Color(0xFF6B7280)),
                  const SizedBox(width: 4),
                  Text('${post.replies}',
                      style: const TextStyle(
                          color: Color(0xFF6B7280), fontSize: 13)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
