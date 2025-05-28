import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/chat_controller.dart';
import '../models/chat_message.dart';

class ChatBottomSheet extends StatelessWidget {
  const ChatBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    final textController = TextEditingController();
    final isWideScreen = Get.width > 600;
    final errorText = RxString('');

    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isWideScreen ? const Radius.circular(20) : Radius.zero,
            bottomRight: isWideScreen ? const Radius.circular(20) : Radius.zero,
          ),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    child: FaIcon(
                      FontAwesomeIcons.message,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Chat with me',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),

            // Chat messages or predefined questions
            Expanded(
              child: Obx(() {
                if (controller.isFirstTime.value) {
                  return Column(
                    children: [
                      // Show initial bot message
                      if (controller.messages.isNotEmpty)
                        _buildMessageBubble(controller.messages.first),
                      // Show predefined questions
                      Expanded(
                        child: _buildPredefinedQuestions(controller),
                      ),
                    ],
                  );
                }
                // Show chat messages after interaction
                return _buildChatMessages(controller);
              }),
            ),

            // Input area
            Material(
              color: Get.theme.cardColor,
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() => TextField(
                            controller: textController,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Type your message...',
                              errorText: errorText.value.isEmpty
                                  ? null
                                  : errorText.value,
                              errorStyle: const TextStyle(color: Colors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              hintStyle: const TextStyle(color: Colors.black38),
                            ),
                            onSubmitted: (value) {
                              if (value.trim().isEmpty) {
                                errorText.value = 'Message cannot be empty';
                                return;
                              }
                              errorText.value = '';
                              controller.sendMessage(value);
                              textController.clear();
                            },
                          )),
                    ),
                    const SizedBox(width: 8),
                    Obx(() => controller.isLoading.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: const FaIcon(
                                FontAwesomeIcons.play,
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {
                                if (textController.text.trim().isEmpty) {
                                  errorText.value = 'Message cannot be empty';
                                  return;
                                }
                                errorText.value = '';
                                controller.sendMessage(textController.text);
                                textController.clear();
                              },
                            ),
                          )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPredefinedQuestions(ChatController controller) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Choose a question to get started:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ...controller.predefinedQuestions.map((question) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ElevatedButton(
                  onPressed: () =>
                      controller.handlePredefinedQuestion(question),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    question,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildChatMessages(ChatController controller) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      reverse: true,
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        final message =
            controller.messages[controller.messages.length - 1 - index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isUser
              ? Get.theme.primaryColor
              : Get.theme.brightness == Brightness.dark
                  ? Colors.grey[900]
                  : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        constraints: BoxConstraints(
          maxWidth: Get.width * 0.7,
        ),
        child: message.isUser
            ? Text(
                message.message,
                style: const TextStyle(color: Colors.white),
              )
            : Linkify(
                text: message.message,
                style: const TextStyle(color: Colors.white),
                linkStyle: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                onOpen: (link) async {
                  final uri = Uri.parse(link.url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    Get.snackbar(
                      'Error',
                      'Could not open ${link.url}',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
              ),
      ),
    );
  }
}
