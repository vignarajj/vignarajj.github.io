// Contact form page with validation
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/contact/controllers/contact_controller.dart';
import 'package:portfolio/shared/theme/app_colors.dart';
import 'package:portfolio/shared/theme/text_styles.dart';
import 'package:portfolio/shared/constants/app_dimensions.dart';
import 'package:portfolio/shared/constants/app_strings.dart';
import 'package:portfolio/shared/constants/app_assets.dart';

class ContactView extends StatelessWidget {
  final ContactController controller = Get.put(ContactController());

  ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = AppDimensions.isDesktop(screenWidth);
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text(
          AppStrings.contactPageTitle,
          style: TextStyles.chatTitle.copyWith(color: AppColors.pureWhite),
        ),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.pureWhite),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: AppColors.pureWhite,
            size: isDesktop ? AppDimensions.iconLarge : AppDimensions.iconMedium,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? AppDimensions.maxFormWidth : double.infinity,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppDimensions.getPadding(screenWidth, mobile: AppDimensions.paddingXXLarge, desktop: AppDimensions.paddingXXXLarge)),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimensions.spacing24),
                  Text(
                    AppStrings.getInTouchTitle,
                    style: TextStyles.getResponsiveTextStyle(screenWidth,
                      desktop: TextStyles.sectionTitle,
                      mobile: TextStyles.sectionTitleMobile,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing8),
                  Text(
                    AppStrings.contactPageDescription,
                    style: TextStyles.getResponsiveTextStyle(screenWidth,
                      desktop: TextStyles.sectionDescription,
                      mobile: TextStyles.sectionDescriptionMobile,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing32),
                  _buildFormField(
                    controller: controller.nameController,
                    label: AppStrings.fullNameLabel,
                    assetName: AppAssets.userIcon,
                    hintText: AppStrings.fullNameHint,
                    validator: controller.validateName,
                  ),
                  const SizedBox(height: AppDimensions.spacing20),
                  _buildFormField(
                    controller: controller.emailController,
                    label: AppStrings.emailLabel,
                    assetName: AppAssets.emailIcon,
                    hintText: AppStrings.emailHint,
                    keyboardType: TextInputType.emailAddress,
                    validator: controller.validateEmail,
                  ),
                  const SizedBox(height: AppDimensions.spacing20),
                  _buildFormField(
                    controller: controller.phoneController,
                    label: AppStrings.phoneLabel,
                    assetName: AppAssets.phoneIcon,
                    hintText: AppStrings.phoneHint,
                    keyboardType: TextInputType.phone,
                    validator: controller.validatePhone,
                  ),
                  const SizedBox(height: AppDimensions.spacing20),
                  _buildFormField(
                    controller: controller.messageController,
                    label: AppStrings.messageLabel,
                    hintText: AppStrings.messageHint,
                    maxLines: 5,
                    validator: controller.validateMessage,
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: controller.isSubmitting.value
                              ? null
                              : controller.submitForm,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.paddingXXXLarge,
                              vertical: AppDimensions.paddingLarge,
                            ),
                            decoration: BoxDecoration(
                              gradient: controller.isSubmitting.value
                                  ? LinearGradient(
                                      colors: [
                                        AppColors.mutedText,
                                        AppColors.mediumAccent,
                                      ],
                                    )
                                  : LinearGradient(
                                      colors: [
                                        AppColors.lightAccent,
                                        AppColors.pureWhite,
                                      ],
                                    ),
                              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.pureBlack.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: AppDimensions.shadowBlurLarge,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: controller.isSubmitting.value
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: AppDimensions.iconSmall,
                                        height: AppDimensions.iconSmall,
                                        child: CircularProgressIndicator(
                                          color: AppColors.pureWhite,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                      const SizedBox(width: AppDimensions.spacing12),
                                      Flexible(
                                        child: Text(
                                          AppStrings.sendingText,
                                          style: TextStyles.buttonText.copyWith(
                                            color: AppColors.pureWhite,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.send,
                                        color: AppColors.pureBlack,
                                        size: AppDimensions.iconSmall,
                                      ),
                                      const SizedBox(width: AppDimensions.spacing8),
                                      Flexible(
                                        child: Text(
                                          AppStrings.sendButtonText,
                                          style: TextStyles.buttonText.copyWith(
                                            color: AppColors.pureBlack,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    String? assetName,
    String? hintText,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.formLabel,
        ),
        const SizedBox(height: AppDimensions.spacing8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: TextStyles.formInput,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: assetName != null
                ? Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                    child: Image.asset(
                      assetName,
                      width: AppDimensions.iconMedium,
                      height: AppDimensions.iconMedium,
                      color: AppColors.mutedText,
                    ),
                  )
                : null,
            filled: true,
            fillColor: AppColors.cardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              borderSide: BorderSide(color: AppColors.borderColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              borderSide: BorderSide(color: AppColors.borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              borderSide: BorderSide(color: AppColors.lightAccent, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              borderSide: BorderSide(color: AppColors.errorColor, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              borderSide: BorderSide(color: AppColors.errorColor, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
              vertical: AppDimensions.paddingMedium,
            ),
            hintStyle: TextStyles.formHint,
            errorStyle: TextStyles.formError,
          ),
        ),
      ],
    );
  }
}
