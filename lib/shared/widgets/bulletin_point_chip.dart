// Widget to display a bulletin point chip with animated hover/tap effects
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/routes/app_pages.dart';
import 'package:portfolio/shared/models/core_compentency.dart';
import 'package:portfolio/shared/theme/app_colors.dart';

class BulletPointChip extends StatefulWidget {
  final String text;
  final CoreCompetency? competency;
  final bool isNavigable;

  const BulletPointChip({
    required this.text,
    this.competency,
    this.isNavigable = false,
    super.key,
  });

  @override
  _BulletPointChipState createState() => _BulletPointChipState();
}

class _BulletPointChipState extends State<BulletPointChip> {
  double _scale = 1.0;
  double _fontSize = 16.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update responsive font size
    _fontSize = Get.width < 600 ? 14.0 : 16.0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isNavigable && widget.competency != null
          ? () {
        Get.toNamed(
          AppRoutes.coreCompetency,
          arguments: widget.competency,
        );
      }
          : null,
      child: MouseRegion(
        onEnter: (_) => setState(() => _scale = 1.05),
        onExit: (_) => setState(() => _scale = 1.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_scale),
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.appAccentColor, AppColors.appAccentColor.withAlpha(80)],
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
              child: Chip(
                label: Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _fontSize,
                  ),
                ),
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                avatar: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
                labelPadding: const EdgeInsets.only(left: 4, right: 8),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                clipBehavior: Clip.antiAlias,
              ),
            ),
          ),
        ),
      ),
    );
  }
}