// Contact form page with validation
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/contact/controllers/contact_controller.dart';
import 'package:portfolio/shared/theme/app_colors.dart';

class ContactView extends StatelessWidget {
  final ContactController controller = Get.put(ContactController());

  ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text(
          "Say Hello",
          style: TextStyle(
            fontFamily: 'SourceCodePro',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.pureWhite,
          ),
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
            size: isDesktop ? 24 : 20,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 600 : double.infinity,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isDesktop ? 32.0 : 20.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'Get in Touch',
                    style: TextStyle(
                      fontFamily: 'SourceCodePro',
                      fontSize: isDesktop ? 24 : 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'I\'d love to hear from you. Send me a message and I\'ll respond as soon as possible.',
                    style: TextStyle(
                      fontFamily: 'SourceCodePro',
                      fontSize: isDesktop ? 14 : 12,
                      color: AppColors.primaryText,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildFormField(
                    controller: controller.nameController,
                    label: 'Full Name',
                    assetName: 'assets/images/user.png',
                    validator: controller.validateName,
                  ),
                  const SizedBox(height: 20),
                  _buildFormField(
                    controller: controller.emailController,
                    label: 'Email Address',
                    assetName: 'assets/images/email.png',
                    keyboardType: TextInputType.emailAddress,
                    validator: controller.validateEmail,
                  ),
                  const SizedBox(height: 20),
                  _buildFormField(
                    controller: controller.phoneController,
                    label: 'Phone Number',
                    assetName: 'assets/images/phone.png',
                    keyboardType: TextInputType.phone,
                    validator: controller.validatePhone,
                  ),
                  const SizedBox(height: 20),
                  _buildFormField(
                    controller: controller.messageController,
                    label: 'Your Message',
                    assetName: 'assets/images/message.png',
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
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
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
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.pureBlack.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 12,
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
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          color: AppColors.pureWhite,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: Text(
                                          'Sending...',
                                          style: TextStyle(
                                            fontFamily: 'SourceCodePro',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
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
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          'Send Message',
                                          style: TextStyle(
                                            fontFamily: 'SourceCodePro',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
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
                  const SizedBox(height: 20),
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
    required String assetName,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'SourceCodePro',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.lightAccent,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(
            fontFamily: 'SourceCodePro',
            fontSize: 14,
            color: AppColors.pureWhite,
          ),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                assetName,
                width: 18,
                height: 18,
                color: Colors.white,
              ),
            ),
            filled: true,
            fillColor: AppColors.cardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.borderColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.lightAccent, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.errorColor, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.errorColor, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            hintStyle: TextStyle(
              fontFamily: 'SourceCodePro',
              color: AppColors.mutedText,
              fontSize: 14,
            ),
            errorStyle: TextStyle(
              fontFamily: 'SourceCodePro',
              color: AppColors.errorColor,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
