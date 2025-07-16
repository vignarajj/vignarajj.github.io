import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio/shared/theme/app_colors.dart';
import 'package:portfolio/shared/theme/text_styles.dart';
import 'package:portfolio/shared/constants/app_dimensions.dart';
import 'package:portfolio/shared/constants/app_strings.dart';
import 'package:portfolio/shared/constants/app_assets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/chat_controller.dart';
import '../models/chat_message.dart';

class ChatBottomSheet extends StatelessWidget {
  const ChatBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    final textController = TextEditingController();
    final isWideScreen = Get.width > AppDimensions.mobileBreakpoint;
    final errorText = RxString('');

    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: Get.height * 0.85,
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusXXLarge),
            topRight: Radius.circular(AppDimensions.radiusXXLarge),
            bottomLeft: isWideScreen ? Radius.circular(AppDimensions.radiusXXLarge) : Radius.zero,
            bottomRight: isWideScreen ? Radius.circular(AppDimensions.radiusXXLarge) : Radius.zero,
          ),
          border: Border.all(
            color: AppColors.lightAccent.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.pureBlack.withValues(alpha: 0.5),
              blurRadius: AppDimensions.shadowBlurXLarge,
              offset: Offset(0, -AppDimensions.spacing8),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingXLarge),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.cardBackground,
                    AppColors.secondaryBackground,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppDimensions.radiusXXLarge),
                  topRight: Radius.circular(AppDimensions.radiusXXLarge),
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
                    padding: EdgeInsets.all(AppDimensions.paddingMedium),
                    decoration: BoxDecoration(
                      color: AppColors.lightAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                      border: Border.all(
                        color: AppColors.lightAccent.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.message,
                      color: AppColors.lightAccent,
                      size: AppDimensions.iconMedium,
                    ),
                  ),
                  SizedBox(width: AppDimensions.spacing16),
                  Text(
                    AppStrings.chatTitle,
                    style: TextStyles.chatTitle.copyWith(
                      color: AppColors.pureWhite,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: AppColors.pureWhite,
                        size: AppDimensions.iconMedium,
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
              padding: EdgeInsets.all(AppDimensions.paddingLarge),
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
                    blurRadius: AppDimensions.shadowBlurMedium,
                    offset: Offset(0, -AppDimensions.spacing4),
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
                          style: TextStyles.formInput,
                          decoration: InputDecoration(
                            hintText: AppStrings.chatInputHint,
                            errorText: errorText.value.isEmpty
                                ? null
                                : errorText.value,
                            errorStyle: TextStyles.formError,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                              borderSide: BorderSide(
                                color: AppColors.lightAccent.withValues(
                                  alpha: 0.3,
                                ),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                              borderSide: BorderSide(
                                color: AppColors.lightAccent.withValues(
                                  alpha: 0.3,
                                ),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                              borderSide: BorderSide(
                                color: AppColors.lightAccent,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: AppColors.primaryBackground,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: AppDimensions.paddingLarge,
                              vertical: AppDimensions.paddingMedium,
                            ),
                            hintStyle: TextStyles.formHint,
                          ),
                          onSubmitted: (value) {
                            if (value.trim().isEmpty) {
                              errorText.value = AppStrings.chatEmptyMessageError;
                              return;
                            }
                            errorText.value = '';
                            controller.sendMessage(value);
                            textController.clear();
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: AppDimensions.spacing12),
                    Obx(
                      () => controller.isLoading.value
                          ? Container(
                              width: AppDimensions.containerHeight,
                              height: AppDimensions.containerHeight,
                              padding: EdgeInsets.all(AppDimensions.paddingMedium),
                              decoration: BoxDecoration(
                                color: AppColors.lightAccent.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                              ),
                              child: CircularProgressIndicator(
                                color: AppColors.lightAccent,
                                strokeWidth: 2,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                if (textController.text.trim().isEmpty) {
                                  errorText.value = AppStrings.chatEmptyMessageError;
                                  return;
                                }
                                errorText.value = '';
                                controller.sendMessage(textController.text);
                                textController.clear();
                              },
                              child: Image.asset(
                                AppAssets.planeSendIcon,
                                width: AppDimensions.iconXLarge,
                                height: AppDimensions.iconXLarge,
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
        padding: EdgeInsets.all(AppDimensions.paddingXLarge),
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(AppDimensions.paddingXLarge),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            border: Border.all(
              color: AppColors.lightAccent.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.pureBlack.withValues(alpha: 0.3),
                blurRadius: AppDimensions.shadowBlurLarge,
                offset: Offset(0, AppDimensions.spacing4),
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
                      AppStrings.chatQuestionPrompt,
                      style: TextStyles.chatQuestion.copyWith(
                        color: AppColors.pureWhite,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.spacing20),
              ...controller.predefinedQuestions.map(
                (question) => Padding(
                  padding: EdgeInsets.only(bottom: AppDimensions.spacing12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () =>
                          controller.handlePredefinedQuestion(question),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimensions.paddingLarge,
                          horizontal: AppDimensions.paddingLarge,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                          border: Border.all(
                            color: AppColors.lightAccent.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: AppDimensions.spacing4 + 2,
                              height: AppDimensions.spacing4 + 2,
                              decoration: BoxDecoration(
                                color: AppColors.lightAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: AppDimensions.spacing12),
                            Flexible(
                              child: Text(
                                question,
                                style: TextStyles.chatMessage.copyWith(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.mutedText,
                              size: AppDimensions.iconSmall - 4,
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
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge, vertical: AppDimensions.paddingSmall),
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
          bottom: AppDimensions.spacing12,
          left: message.isUser ? AppDimensions.spacing64 - 4 : 0,
          right: message.isUser ? 0 : AppDimensions.spacing64 - 4,
        ),
        padding: EdgeInsets.all(AppDimensions.paddingLarge),
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
            topLeft: Radius.circular(AppDimensions.radiusLarge),
            topRight: Radius.circular(AppDimensions.radiusLarge),
            bottomLeft: Radius.circular(message.isUser ? AppDimensions.radiusLarge : AppDimensions.spacing4),
            bottomRight: Radius.circular(message.isUser ? AppDimensions.spacing4 : AppDimensions.radiusLarge),
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
              blurRadius: AppDimensions.shadowBlurMedium,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: message.isUser
            ? Text(
                message.message,
                style: TextStyles.chatMessage.copyWith(
                  color: AppColors.pureBlack,
                  fontWeight: FontWeight.w700,
                ),
              )
            : Linkify(
                text: message.message,
                style: TextStyles.chatMessage.copyWith(
                  color: AppColors.pureWhite,
                  height: 1.4,
                ),
                linkStyle: TextStyles.chatMessage.copyWith(
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
                      AppStrings.error,
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
