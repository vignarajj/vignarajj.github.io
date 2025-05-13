import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/views/contact_screen.dart';
import 'package:portfolio/shared/theme/app_colors.dart';

class ContactLinkWidget extends StatefulWidget {
  const ContactLinkWidget({super.key});

  @override
  _ContactLinkWidgetState createState() => _ContactLinkWidgetState();
}

class _ContactLinkWidgetState extends State<ContactLinkWidget> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: MouseRegion(
        onEnter: (_) => setState(() => _scale = 1.05),
        onExit: (_) => setState(() => _scale = 1.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_scale),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.appAccentColor,
                Colors.black54,
                AppColors.appAccentColor
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(30),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              Get.to(ContactView());
            },
            child: const Text(
              'Get in Touch',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
