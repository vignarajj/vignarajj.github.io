// Widget for animated social media contact buttons
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/shared/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactButtons extends StatefulWidget {
  const ContactButtons({super.key});

  @override
  State<ContactButtons> createState() => _ContactButtonsState();
}

class _ContactButtonsState extends State<ContactButtons> {
  double _iconSize = 24.0;
  double _buttonSize = 48.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update responsive sizes
    _iconSize = Get.width < 600 ? 20.0 : 24.0;
    _buttonSize = Get.width < 600 ? 40.0 : 48.0;

    // Precache SVGs
    precachePicture(
        SvgPicture.asset('assets/images/github.svg').pictureProvider, context);
    precachePicture(
        SvgPicture.asset('assets/images/medium.svg').pictureProvider, context);
    precachePicture(
        SvgPicture.asset('assets/images/linkedin.svg').pictureProvider,
        context);
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
            icon: SvgPicture.asset(
              'assets/images/github.svg',
              width: _iconSize,
              height: _iconSize,
              color: Colors.white,
            ),
            url: 'https://github.com/vignarajj',
            color: AppColors.appAccentColor.withAlpha(90),
          ),
          const SizedBox(width: 16),
          _buildButton(
            icon: SvgPicture.asset(
              'assets/images/medium.svg',
              width: _iconSize,
              height: _iconSize,
              color: Colors.white,
            ),
            url: 'https://medium.com/@vignarajj',
            color: AppColors.appAccentColor.withAlpha(90),
          ),
          const SizedBox(width: 16),
          _buildButton(
            icon: SvgPicture.asset(
              'assets/images/linkedin.svg',
              width: _iconSize,
              height: _iconSize,
              color: Colors.white,
            ),
            url: 'https://www.linkedin.com/in/vignaraj-ravi-25750b59/',
            color: AppColors.appAccentColor.withAlpha(90),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      {required Widget icon, required String url, required Color color}) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: GestureDetector(
        onTap: () => _launchURL(url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _buttonSize,
          height: _buttonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [color, color.withValues(alpha: 0.7)],
              center: Alignment.center,
              radius: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(child: icon),
        ),
      ),
    );
  }
}
