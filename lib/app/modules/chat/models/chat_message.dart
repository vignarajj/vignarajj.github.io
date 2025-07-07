class ChatMessage {
  final String message;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.message,
    required this.isUser,
    required this.timestamp,
  });

  factory ChatMessage.user(String message) {
    return ChatMessage(
      message: message,
      isUser: true,
      timestamp: DateTime.now(),
    );
  }

  factory ChatMessage.bot(String message) {
    return ChatMessage(
      message: message,
      isUser: false,
      timestamp: DateTime.now(),
    );
  }
}
