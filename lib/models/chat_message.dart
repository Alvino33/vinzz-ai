class ChatMessage {
      final String id;
        final String text;
          final bool isUser;
            final DateTime timestamp;
              final bool isStreaming;

                const ChatMessage({
                    required this.id,
                        required this.text,
                            required this.isUser,
                                required this.timestamp,
                                    this.isStreaming = false,
                                      });

                                        ChatMessage copyWith({String? text, bool? isStreaming}) => ChatMessage(
                                                id: id,
                                                        text: text ?? this.text,
                                                                isUser: isUser,
                                                                        timestamp: timestamp,
                                                                                isStreaming: isStreaming ?? this.isStreaming,
                                                                                      );
                                                                                      }
}