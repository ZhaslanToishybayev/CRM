part of '../../../main.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final MinimaxAIService _aiService = MinimaxAIService();
  final List<ChatMessage> _messages = [];
  bool _isRequestInFlight = false;

  @override
  void initState() {
    super.initState();
    _messages.add(
      ChatMessage(
        isUser: false,
        message:
            'Hello! I\'m your AI Assistant. I can help you with tasks, productivity tips, and suggestions. How can I help you today?',
        timestamp: DateTime.now(),
      ),
    );
    if (_aiService.isDemoMode) {
      _messages.add(
        ChatMessage(
          isUser: false,
          message:
              'DEMO MODE включен: ответы будут демонстрационными. Для реального AI отключите AI_DEMO_MODE.',
          timestamp: DateTime.now(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_isRequestInFlight) return;

    final userInput = _messageController.text.trim();
    if (userInput.isEmpty) return;
    _messageController.clear();

    await _requestAIResponse(userInput: userInput, appendUserMessage: true);
  }

  Future<void> _retryMessage(String failedMessage) async {
    if (_isRequestInFlight) return;
    await _requestAIResponse(
      userInput: failedMessage,
      appendUserMessage: false,
    );
  }

  Future<void> _requestAIResponse({
    required String userInput,
    required bool appendUserMessage,
  }) async {
    int? userMessageIndex;

    setState(() {
      if (appendUserMessage) {
        _messages.add(
          ChatMessage(
            isUser: true,
            message: userInput,
            timestamp: DateTime.now(),
          ),
        );
        userMessageIndex = _messages.length - 1;
      }

      _isRequestInFlight = true;
      _messages.add(
        ChatMessage(
          isUser: false,
          message: '🧠 Minimax AI думает...',
          timestamp: DateTime.now(),
          isTyping: true,
        ),
      );
    });

    _scrollToBottom();

    final conversationHistory = <Map<String, String>>[];
    for (var i = 0; i < _messages.length; i++) {
      final msg = _messages[i];
      if (msg.isTyping || msg.isError) continue;
      if (userMessageIndex != null && i == userMessageIndex) continue;
      conversationHistory.add({
        'role': msg.isUser ? 'user' : 'assistant',
        'content': msg.message,
      });
    }

    try {
      final response = await _aiService.sendMessage(
        userInput,
        conversationHistory,
      );

      setState(() {
        _messages.removeWhere((msg) => msg.isTyping);
        _messages.add(
          ChatMessage(
            isUser: false,
            message: response,
            timestamp: DateTime.now(),
          ),
        );
      });
    } on AIChatException catch (error) {
      setState(() {
        _messages.removeWhere((msg) => msg.isTyping);
        _messages.add(
          ChatMessage(
            isUser: false,
            message: error.userMessage,
            timestamp: DateTime.now(),
            isError: true,
            retryMessage: userInput,
          ),
        );
      });
    } catch (_) {
      setState(() {
        _messages.removeWhere((msg) => msg.isTyping);
        _messages.add(
          ChatMessage(
            isUser: false,
            message: 'Не удалось получить ответ AI. Повторите попытку.',
            timestamp: DateTime.now(),
            isError: true,
            retryMessage: userInput,
          ),
        );
      });
    } finally {
      setState(() {
        _isRequestInFlight = false;
      });
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showQuickSuggestions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SuggestionBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI Assistant',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            onPressed: _showQuickSuggestions,
            tooltip: 'Quick Suggestions',
          ),
        ],
      ),
      body: Column(
        children: [
          if (_aiService.isDemoMode)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: const Color(0xFFFFF7ED),
              child: Text(
                'AI DEMO MODE: продовые ответы отключены.',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF9A3412),
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('ai_input_field'),
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Ask me anything...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) {
                      if (!_isRequestInFlight) {
                        _sendMessage();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  key: const Key('ai_send_button'),
                  tooltip: 'Send message',
                  onPressed: _isRequestInFlight ? null : _sendMessage,
                  backgroundColor: const Color(0xFF8B5CF6),
                  foregroundColor: Colors.white,
                  mini: true,
                  child: const Icon(Icons.send, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              backgroundColor: const Color(0xFF8B5CF6),
              radius: 20,
              child: Icon(Icons.psychology, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: message.isUser
                    ? const Color(0xFF8B5CF6)
                    : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: message.isUser
                      ? const Radius.circular(20)
                      : const Radius.circular(4),
                  bottomRight: message.isUser
                      ? const Radius.circular(4)
                      : const Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.message,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: message.isUser ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: message.isUser
                          ? Colors.white.withValues(alpha: 0.8)
                          : Colors.grey[600],
                    ),
                  ),
                  if (message.isError && message.retryMessage != null) ...[
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: _isRequestInFlight
                          ? null
                          : () => _retryMessage(message.retryMessage!),
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text('Retry'),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 12),
            CircleAvatar(
              backgroundColor: const Color(0xFF6366F1),
              radius: 20,
              child: Text(
                'JD',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class ChatMessage {
  final bool isUser;
  final String message;
  final DateTime timestamp;
  final bool isTyping;
  final bool isError;
  final String? retryMessage;

  ChatMessage({
    required this.isUser,
    required this.message,
    required this.timestamp,
    this.isTyping = false,
    this.isError = false,
    this.retryMessage,
  });
}

class SuggestionBottomSheet extends StatelessWidget {
  const SuggestionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      'How to be more productive?',
      'Task management tips',
      'How to use gamification?',
      'Client relationship tips',
      'Show my statistics',
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.3,
        maxChildSize: 0.6,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Quick Suggestions',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ...suggestions.map(
                  (suggestion) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.lightbulb,
                        color: Color(0xFFF59E0B),
                      ),
                      title: Text(
                        suggestion,
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
