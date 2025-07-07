// Widget for animated social media contact buttons
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/shared/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactButtons extends StatefulWidget {
  const ContactButtons({super.key});

  @override
  State<ContactButtons> createState() => _ContactButtonsState();
}

class _ContactButtonsState extends State<ContactButtons> {
  double _iconSize = 36.0;
  double _buttonSize = 48.0;
  final RxBool _hovered = false.obs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update responsive sizes
    _iconSize = Get.width < 600 ? 24.0 : 36.0;
    _buttonSize = Get.width < 600 ? 40.0 : 48.0;
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar(
        'Error',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButton(
            icon: Image.asset(
              'assets/images/github.png',
              width: _iconSize,
              height: _iconSize,
              color: AppColors.primaryText,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.code,
                size: _iconSize,
                color: AppColors.primaryText,
              ),
            ),
            url: 'https://github.com/vignarajj',
            label: 'GitHub',
          ),
          const SizedBox(width: 16),
          _buildButton(
            icon: Image.asset(
              'assets/images/medium.png',
              width: _iconSize,
              height: _iconSize,
              color: AppColors.primaryText,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.article,
                size: _iconSize,
                color: AppColors.primaryText,
              ),
            ),
            url: 'https://medium.com/@vignarajj',
            label: 'Medium',
          ),
          const SizedBox(width: 16),
          _buildButton(
            icon: Image.asset(
              'assets/images/linkedin.png',
              width: _iconSize,
              height: _iconSize,
              color: AppColors.primaryText,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.person,
                size: _iconSize,
                color: AppColors.primaryText,
              ),
            ),
            url: 'https://www.linkedin.com/in/vignaraj-ravi-25750b59/',
            label: 'LinkedIn',
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required Widget icon,
    required String url,
    required String label,
  }) {
    return MouseRegion(
      onEnter: (_) => _hovered.value = true,
      onExit: (_) => _hovered.value = false,
      child: Obx(
        () => Tooltip(
          message: label,
          child: GestureDetector(
            onTap: () => _launchURL(url),
            child: Container(
              width: _buttonSize + 16,
              height: _buttonSize + 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _hovered.value
                    ? Colors.grey.shade700
                    : Colors.grey.shade600,
                border: Border.all(color: AppColors.borderColor, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.pureBlack.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                  BoxShadow(
                    color: AppColors.pureWhite.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Center(
                child: Container(padding: const EdgeInsets.all(8), child: icon),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
