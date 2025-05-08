import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/views/medium_story_widget.dart';
import 'package:portfolio/shared/models/core_compentency.dart';
import 'package:portfolio/shared/theme/text_styles.dart';
import 'package:portfolio/shared/widgets/animated_section.dart';
import 'package:portfolio/shared/widgets/bulletin_point_chip.dart';
import 'package:portfolio/shared/widgets/contact_buttons.dart';
import 'package:portfolio/shared/widgets/contact_link_widget.dart';
import 'package:portfolio/shared/widgets/project_card.dart';
import 'package:portfolio/shared/widgets/project_marquee.dart';
import 'package:portfolio/shared/widgets/skill_chip.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetResponsiveView<HomeController> {
  HomeView({super.key});

  @override
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedSection(
              delay: 0,
              child: _buildHeader(),
            ),
            AnimatedSection(delay: 200, child: _buildSummary()),
            AnimatedSection(delay: 400, child: _buildSkillsSection()),
            AnimatedSection(
                delay: 600, child: _buildSectionTitle('Core Competencies')),
            AnimatedSection(
                delay: 800,
                child: _buildChipSection(controller.coreCompetencies, true)),
            AnimatedSection(
                delay: 1000, child: _buildSectionTitle('Future Goals')),
            AnimatedSection(
              delay: 1100,
              child: _buildChipSection(
                [
                  'Beginning with RUST',
                  'Contribute to Open Source Projects',
                  'Explore the ML and AI implementations',
                ],
              ),
            ),
            AnimatedSection(
                delay: 1200, child: _buildSectionTitle('Hobbies & Interests')),
            AnimatedSection(
              delay: 1300,
              child: _buildChipSection(
                [
                  'Tech Gadgets',
                  'Traveling',
                  'Playing Cricket',
                  'Gaming',
                ],
              ),
            ),
            AnimatedSection(
                delay: 1400, child: _buildSectionTitle('Personal Projects')),
            AnimatedSection(delay: 1500, child: _buildProjectsSection()),
            AnimatedSection(
                delay: 1600, child: _buildSectionTitle('Latest Medium Stories')),
            AnimatedSection(delay: 1700, child: _buildMediumStories()),
            const AnimatedSection(delay: 1800, child: ContactLinkWidget()),
            const SizedBox(height: 80),
            const ContactButtons(),
            AnimatedSection(delay: 1400, child: _buildFooter()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 75,
            backgroundImage: AssetImage("assets/images/profile_pic.jpeg"),
          ),
          const SizedBox(height: 20),
          _buildAnimatedText(
              'VIGNARAJ R.R.', TextStyles.consoleHeader.copyWith()),
          const SizedBox(height: 10),
          _buildAnimatedText(
              'TECH LEAD (MOBILE ENGINEERING)', TextStyles.consoleSubHeader),
        ],
      ),
    );
  }

  Widget _buildAnimatedText(String text, TextStyle style) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: style,
          textAlign: TextAlign.center,
          speed: const Duration(milliseconds: 100),
        ),
      ],
      totalRepeatCount: 1,
    );
  }

  Widget _buildSummary() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: Text(
        'Experienced Tech Lead with 13+ years in mobile app development. Proficient in Android, Kotlin, Java, Flutter, and Dart. Skilled in testing (manual, unit, and automation), CI/CD with Code Magic, and project management using Jira. Expert in code reviews, documentation, and UI/UX design using Photoshop and Figma.',
        textAlign: TextAlign.center,
        style: TextStyles.consoleBody,
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: controller.skills
            .map((skill) => SkillChip(
                  skill: skill,
                  onTap: () => controller.openSkillDetail(skill),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildChipSection(List<dynamic> items, [bool isNavigable = false]) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: items.map((item) {
          if (isNavigable && item is CoreCompetency) {
            return BulletPointChip(
              text: item.title,
              competency: item,
              isNavigable: true,
            );
          } else {
            return BulletPointChip(text: item.toString());
          }
        }).toList(),
      ),
    );
  }

  Widget _buildMediumStories() {
    return const MediumStoriesWidget();
  }

  Widget _buildProjectsSection() {
    final projects = [
      Project(
        title: 'Repo Generator',
        description:
        'A tool to automate the creation and setup of Git repositories with customizable templates.',
        url: 'https://vignaraj.dev/repo_generator/',
      ),
      Project(
        title: 'Color Picker',
        description:
        'A Flutter-based tool for selecting and generating color palettes for app development.',
        url: 'https://vignaraj.dev/color_picker/',
      ),
      Project(
        title: 'Theme Builder',
        description:
        'A tool to create and customize themes for Flutter applications with real-time previews.',
        url: 'https://vignaraj.dev/theme_generator/',
      ),
    ];

    final cardWidth = Get.width < 600 ? Get.width * 0.6 : 300.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ProjectMarquee(projects: projects, cardWidth: cardWidth),
    );
  }


  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(30),
      color: Colors.black,
      child: Column(
        children: [
          // const VisitCountWidget(),
          // const SizedBox(height: 10),
          const Text(
            'Developed using Flutter',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 5),
          SvgPicture.asset(
            'assets/images/flutter.svg',
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
