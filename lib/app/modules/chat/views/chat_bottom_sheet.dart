import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio/shared/theme/app_colors.dart';
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
        height: Get.height * 0.85,
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(24),
            topRight: const Radius.circular(24),
            bottomLeft: isWideScreen ? const Radius.circular(24) : Radius.zero,
            bottomRight: isWideScreen ? const Radius.circular(24) : Radius.zero,
          ),
          border: Border.all(
            color: AppColors.lightAccent.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.pureBlack.withValues(alpha: 0.5),
              blurRadius: 20,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.cardBackground,
                    AppColors.secondaryBackground,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.lightAccent.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.lightAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.lightAccent.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.message,
                      color: AppColors.lightAccent,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Chat with me',
                    style: TextStyle(
                      fontFamily: 'SourceCodePro',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.pureWhite,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: AppColors.pureWhite,
                        size: 20,
                      ),
                      onPressed: () => Get.back(),
                    ),
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
                      _buildPredefinedQuestions(controller),
                    ],
                  );
                }
                // Show chat messages after interaction
                return _buildChatMessages(controller);
              }),
            ),

            // Input area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                border: Border(
                  top: BorderSide(
                    color: AppColors.lightAccent.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.pureBlack.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => TextField(
                          controller: textController,
                          style: TextStyle(
                            fontFamily: 'SourceCodePro',
                            color: AppColors.pureWhite,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            errorText: errorText.value.isEmpty
                                ? null
                                : errorText.value,
                            errorStyle: TextStyle(
                              fontFamily: 'SourceCodePro',
                              color: AppColors.errorColor,
                              fontSize: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: AppColors.lightAccent.withValues(
                                  alpha: 0.3,
                                ),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: AppColors.lightAccent.withValues(
                                  alpha: 0.3,
                                ),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: AppColors.lightAccent,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: AppColors.primaryBackground,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'SourceCodePro',
                              color: AppColors.mutedText,
                              fontSize: 14,
                            ),
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
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Obx(
                      () => controller.isLoading.value
                          ? Container(
                              width: 48,
                              height: 48,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.lightAccent.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: CircularProgressIndicator(
                                color: AppColors.lightAccent,
                                strokeWidth: 2,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                if (textController.text.trim().isEmpty) {
                                  errorText.value = 'Message cannot be empty';
                                  return;
                                }
                                errorText.value = '';
                                controller.sendMessage(textController.text);
                                textController.clear();
                              },
                              child: Image.asset(
                                'assets/images/plane_send.png',
                                width: 28,
                                height: 28,
                                color: Colors.white,
                              ),
                            ),
                    ),
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
    return Flexible(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.lightAccent.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.pureBlack.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Choose a question to get started:',
                      style: TextStyle(
                        fontFamily: 'SourceCodePro',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.pureWhite,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ...controller.predefinedQuestions.map(
                (question) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () =>
                          controller.handlePredefinedQuestion(question),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.lightAccent.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColors.lightAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Text(
                                question,
                                style: TextStyle(
                                  fontFamily: 'SourceCodePro',
                                  color: AppColors.primaryText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.mutedText,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatMessages(ChatController controller) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      reverse: true,
      physics: const BouncingScrollPhysics(),
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
        margin: EdgeInsets.only(
          bottom: 12,
          left: message.isUser ? 60 : 0,
          right: message.isUser ? 0 : 60,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: message.isUser
              ? LinearGradient(
                  colors: [AppColors.lightAccent, AppColors.pureWhite],
                )
              : LinearGradient(
                  colors: [
                    AppColors.cardBackground,
                    AppColors.secondaryBackground,
                  ],
                ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isUser ? 16 : 4),
            bottomRight: Radius.circular(message.isUser ? 4 : 16),
          ),
          border: Border.all(
            color: message.isUser
                ? AppColors.pureWhite.withValues(alpha: 0.3)
                : AppColors.lightAccent.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.pureBlack.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: message.isUser
            ? Text(
                message.message,
                style: TextStyle(
                  fontFamily: 'SourceCodePro',
                  color: AppColors.pureBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              )
            : Linkify(
                text: message.message,
                style: TextStyle(
                  fontFamily: 'SourceCodePro',
                  color: AppColors.pureWhite,
                  fontSize: 14,
                  height: 1.4,
                ),
                linkStyle: TextStyle(
                  fontFamily: 'SourceCodePro',
                  color: AppColors.lightAccent,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
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
                      backgroundColor: AppColors.errorColor,
                      colorText: AppColors.pureWhite,
                    );
                  }
                },
              ),
      ),
    );
  }
}
