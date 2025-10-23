import 'package:flutter/material.dart';
import '../services/data_service.dart';

class KumbotScreen extends StatefulWidget {
  const KumbotScreen({super.key});

  @override
  State<KumbotScreen> createState() => _KumbotScreenState();
}

class _KumbotScreenState extends State<KumbotScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _responses = DataService.getKumbotResponses();

  @override
  void initState() {
    super.initState();
    _addBotMessage("Hello! I'm Kumbot, your HaloMind assistant! ✨\n\nI'm here to help you understand how to make the most of your Halo Space and Desire Orbits. Try these sample questions:");
    _showSampleQuestions();
  }

  void _showSampleQuestions() {
    Future.delayed(const Duration(milliseconds: 500), () {
      for (int i = 0; i < _responses.length; i++) {
        Future.delayed(Duration(milliseconds: 200 * i), () {
          _addSampleQuestion(_responses[i]['question']);
        });
      }
    });
  }

  void _addSampleQuestion(String question) {
    setState(() {
      _messages.add(ChatMessage(
        text: question,
        isUser: false,
        isSampleQuestion: true,
      ));
    });
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.smart_toy_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Kumbot Assistant'),
          ],
        ),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _showQuickQuestions,
            icon: const Icon(Icons.help_outline_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  message: message,
                  onSampleQuestionTap: _handleSampleQuestionTap,
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Ask Kumbot anything...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF2196F3),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => _handleSubmitted(_textController.text),
                      icon: const Icon(Icons.send_rounded, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _addUserMessage(text);
    _textController.clear();

    // Simulate typing delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _respondToMessage(text);
    });
  }

  void _addUserMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
      ));
    });
    _scrollToBottom();
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: false,
      ));
    });
    _scrollToBottom();
  }

  void _respondToMessage(String userMessage) {
    String response = _findBestResponse(userMessage);
    _addBotMessage(response);
  }

  String _findBestResponse(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();
    
    // Find matching response
    for (final responseData in _responses) {
      final question = responseData['question'].toString().toLowerCase();
      if (lowerMessage.contains('what is') && question.contains('what is')) {
        return responseData['answer'];
      }
      if (lowerMessage.contains('orbit') && question.contains('orbit')) {
        return responseData['answer'];
      }
      if (lowerMessage.contains('green') && question.contains('green')) {
        return responseData['answer'];
      }
      if (lowerMessage.contains('capture') && question.contains('capture')) {
        return responseData['answer'];
      }
      if (lowerMessage.contains('share') && question.contains('share')) {
        return responseData['answer'];
      }
    }

    // Default responses
    if (lowerMessage.contains('hello') || lowerMessage.contains('hi')) {
      return "Hello there! 👋 I'm excited to help you explore KumindHalo! What would you like to know?";
    }
    
    if (lowerMessage.contains('thank')) {
      return "You're very welcome! 😊 I'm always here to help you make the most of your KumindHalo experience!";
    }

    return "That's a great question! 🤔 While I'm still learning, I can help you with:\n\n• Understanding Desire Orbits\n• How to capture products\n• GreenRank and sustainability\n• Sharing with family\n• General KumindHalo features\n\nTry asking about any of these topics!";
  }

  void _showQuickQuestions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Questions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 16),
            ..._responses.map((response) => ListTile(
              leading: const Icon(Icons.help_outline, color: Color(0xFF2196F3)),
              title: Text(response['question']),
              onTap: () {
                Navigator.pop(context);
                _addUserMessage(response['question']);
                Future.delayed(const Duration(milliseconds: 500), () {
                  _addBotMessage(response['answer']);
                });
              },
            )),
          ],
        ),
      ),
    );
  }

  void _handleSampleQuestionTap(String question) {
    // Add the question as a user message
    _addUserMessage(question);
    
    // Find the corresponding answer from responses
    final response = _responses.firstWhere(
      (r) => r['question'] == question,
      orElse: () => {'answer': 'I\'m not sure about that. Can you try asking differently?'},
    );
    
    // Add the bot's response after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _addBotMessage(response['answer']);
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final bool isSampleQuestion;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
    this.isSampleQuestion = false,
  }) : timestamp = timestamp ?? DateTime.now();
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final Function(String)? onSampleQuestionTap;

  const ChatBubble({
    super.key, 
    required this.message,
    this.onSampleQuestionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFF2196F3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.smart_toy_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? const Color(0xFF2196F3)
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(16).copyWith(
                  bottomLeft: message.isUser
                      ? const Radius.circular(16)
                      : const Radius.circular(4),
                  bottomRight: message.isUser
                      ? const Radius.circular(4)
                      : const Radius.circular(16),
                ),
              ),
              child: message.isSampleQuestion 
                ? MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => onSampleQuestionTap?.call(message.text),
                      child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF2196F3).withOpacity(0.3),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Text(
                              message.text,
                              style: const TextStyle(
                                color: Color(0xFF2196F3),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.touch_app_rounded,
                            color: Color(0xFF2196F3),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                : Text(
                    message.text,
                    style: TextStyle(
                      color: message.isUser ? Colors.white : const Color(0xFF333333),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_rounded,
                color: Colors.grey,
                size: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
