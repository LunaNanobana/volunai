import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class _Message {
  final String text;
  final bool isUser;
  final bool isTyping;
  final List<String>? suggestions;

  const _Message({
    required this.text,
    required this.isUser,
    this.isTyping = false,
    this.suggestions,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollCtrl = ScrollController();

  List<_Message> _messages = [
    const _Message(
      text:
          "Сәлеметсіз бе! Мен Алтын - сіздің AI көмекшіңізбін.\nHello! I'm Altyn, your AI assistant. I'm here to listen and support you. How are you feeling today?",
      isUser: false,
      suggestions: [
        "I need someone to talk to",
        "I'm feeling unsafe",
        "Tell me about my rights",
        "Менің құқықтарым қандай?"
      ],
    ),
  ];

  void _send([String? override]) {
    final text = (override ?? _controller.text).trim();
    if (text.isEmpty) return;

    setState(() {
      _messages = [
        ..._messages,
        _Message(text: text, isUser: true),
        const _Message(text: '', isUser: false, isTyping: true),
      ];
      _controller.clear();
    });
    _scrollDown();

    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      setState(() {
        _messages = [
          ..._messages.where((m) => !m.isTyping),
          _generateReply(text),
        ];
      });
      _scrollDown();
    });
  }

  _Message _generateReply(String input) {
    final lower = input.toLowerCase();
    if (lower.contains('unsafe') || lower.contains('қауіпсіз емес') || lower.contains('fear')) {
      return const _Message(
        text:
            "Сіздің қауіпсіздігіңіз маңызды. Your safety is important. I'm here to help.\n\n• Access your safety plan\n• Contact emergency services\n• Talk to someone anonymously\n\nRemember: 'Өзіңді қорға' — protect yourself first. You have the right to be safe.",
        isUser: false,
        suggestions: ["Show safety plan", "Emergency contacts", "I need legal advice"],
      );
    } else if (lower.contains('rights') || lower.contains('құқықтарым')) {
      return const _Message(
        text:
            "In Kazakhstan, you have important rights:\n\n• Right to protection from violence\n• Right to confidentiality\n• The right to seek help\n\n'Әйелдің құрметі - елдің құрметі' — You deserve respect and protection under the law.",
        isUser: false,
        suggestions: ["Legal resources", "How to report abuse", "Talk to community"],
      );
    } else if (lower.contains('talk') || lower.contains('listen') || lower.contains('alone')) {
      return const _Message(
        text:
            "Мен тыңдап тұрмын. I'm listening.\n\nRemember, you're not alone. 'Бөлісу - жеңілдету' (Sharing lightens the burden). Take your time, and share what's on your mind when you're ready.",
        isUser: false,
        suggestions: ["I'm feeling overwhelmed", "What can I do?"],
      );
    } else {
      return const _Message(
        text:
            "Рақмет сізге бөліскеніңізге. Thank you for sharing with me. I'm here to support you. How can I help you further today?",
        isUser: false,
        suggestions: ["Resources", "Safety planning", "Just want to talk"],
      );
    }
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollCtrl.dispose();
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
                colors: [Color(0xFF7C3AED), Color(0xFFDB2777)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 20),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            'Алтын AI',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          const SizedBox(width: 6),
                          const Text('✨', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4ADE80),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Always here for you',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9), fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (ctx, i) {
                final msg = _messages[i];
                return _MessageBubble(message: msg, onSuggestion: _send);
              },
            ),
          ),

          // Privacy notice
          Container(
            color: const Color(0xFFF5F3FF),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                const Icon(Icons.shield_outlined,
                    color: Color(0xFF7C3AED), size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'All conversations are encrypted and anonymous',
                    style: TextStyle(
                        color: const Color(0xFF7C3AED).withOpacity(0.9),
                        fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

          // Input
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(
                16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Хабарлама жазыңыз / Type a message...',
                      hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                      filled: true,
                      fillColor: const Color(0xFFF3F4F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _send,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF7C3AED), Color(0xFFDB2777)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded,
                        color: Colors.white, size: 20),
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

class _MessageBubble extends StatelessWidget {
  final _Message message;
  final void Function(String) onSuggestion;

  const _MessageBubble({required this.message, required this.onSuggestion});

  @override
  Widget build(BuildContext context) {
    if (message.isUser) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF7C3AED), Color(0xFFDB2777)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Text(
                  message.text,
                  style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF7C3AED), Color(0xFFDB2777)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 8),
              const Text('Altyn',
                  style: TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 42),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: message.isTyping
                      ? const _TypingDots()
                      : Text(
                          message.text,
                          style: const TextStyle(
                              color: Color(0xFF111827), fontSize: 14, height: 1.5),
                        ),
                ),
                if (message.suggestions != null) ...[
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: message.suggestions!
                        .map(
                          (s) => GestureDetector(
                            onTap: () => onSuggestion(s),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: const Color(0xFF7C3AED).withOpacity(0.4)),
                              ),
                              child: Text(
                                s,
                                style: const TextStyle(
                                    color: Color(0xFF7C3AED),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingDots extends StatefulWidget {
  const _TypingDots();

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          final offset = ((_ctrl.value * 3) - i).clamp(0.0, 1.0);
          final bounce = offset < 0.5 ? offset * 2 : (1 - offset) * 2;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Transform.translate(
              offset: Offset(0, -4 * bounce),
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Color(0xFF9CA3AF),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
