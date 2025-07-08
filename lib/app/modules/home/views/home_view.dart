import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart' as rive;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:portfolio/app/modules/chat/views/chat_bottom_sheet.dart';
import 'package:portfolio/app/modules/medium/views/medium_story_widget.dart';
import 'package:portfolio/app/modules/flutter_plugins/views/flutter_plugins_widget.dart';
import 'package:portfolio/shared/widgets/animated_section.dart';
import 'package:portfolio/shared/widgets/contact_buttons.dart';
import 'package:portfolio/shared/widgets/skill_chip.dart';
import 'package:portfolio/shared/widgets/calendly_widget.dart';
import 'package:portfolio/shared/widgets/project_card.dart';
import 'package:portfolio/shared/widgets/project_marquee.dart';
import 'package:portfolio/shared/theme/text_styles.dart';
import 'package:portfolio/shared/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Stack(
        children: [
          // Background Rive animation
          Positioned.fill(
            child:
                rive.RiveAnimation.asset(
                      'assets/images/cosmos.riv',
                      fit: BoxFit.cover,
                    )
                    .animate()
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutBack,
                    )
                    .fadeIn(duration: const Duration(milliseconds: 600)),
          ),
          // Content overlay
          Container(
            color: AppColors.primaryBackground.withValues(alpha: 0.7),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  _buildProfilePicture(),
                  const SizedBox(height: 30),
                  _buildTitleSection(),
                  AnimatedSection(delay: 200, child: _buildSummary()),
                  AnimatedSection(delay: 400, child: _buildSkillsSection()),
                  _buildSectionTitle('Core Competencies', 1000),
                  _buildAnimatedChipSection(
                    controller.coreCompetencies.map((e) => e.title).toList(),
                    1200,
                  ),
                  _buildSectionTitle('Future Goals', 1400),
                  _buildAnimatedChipSection([
                    'Master the Flutter 3.0 ecosystem',
                    'Advance in Kotlin Multiplatform',
                    'Deepen AI/ML expertise',
                    'Explore the ML and AI implementations',
                  ], 1600),
                  _buildSectionTitle('Hobbies & Interests', 1800),
                  _buildAnimatedChipSection([
                    'Mobile Tech Articles',
                    'Open Source Contributions',
                    'Fitness & Outdoor Activities',
                    'Photography',
                  ], 2000),
                  AnimatedSection(
                    delay: 1400,
                    child: _buildSectionTitle('Personal Projects', 2200),
                  ),
                  AnimatedSection(delay: 1500, child: _buildProjectsSection()),
                  AnimatedSection(
                    delay: 1600,
                    child: _buildSectionTitle('Latest Medium Stories', 2600),
                  ),
                  AnimatedSection(delay: 1700, child: _buildMediumStories()),
                  // AnimatedSection(
                  //   delay: 1800,
                  //   child: _buildSectionTitle('Flutter Plugins', 2800),
                  // ),
                  // AnimatedSection(delay: 1900, child: _buildFlutterPlugins()),
                  const SizedBox(height: 40),
                  const ContactButtons(),
                  const SizedBox(height: 20),
                  _buildBookMeetingButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildProfilePicture() {
    return Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.pureWhite, width: 3),
            boxShadow: [
              BoxShadow(
                color: AppColors.pureBlack.withValues(alpha: 0.5),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/profile_pic.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        )
        .animate()
        .slideX(
          begin: 1.0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        )
        .fadeIn(duration: const Duration(milliseconds: 300));
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        Text(
              'VIGNARAJ R.R.',
              style: TextStyles.heroTitle,
              textAlign: TextAlign.center,
            )
            .animate(delay: const Duration(milliseconds: 400))
            .fadeIn(duration: const Duration(milliseconds: 600))
            .shimmer(
              duration: const Duration(milliseconds: 1500),
              colors: [
                AppColors.primaryText,
                AppColors.lightAccent,
                AppColors.pureWhite,
                AppColors.lightAccent,
                AppColors.primaryText,
              ],
            ),
        const SizedBox(height: 16),
        Text(
              'Tech Architect for Mobile Futures | Flutter | Kotlin | AI Curious',
              style: TextStyles.heroSubtitle,
              textAlign: TextAlign.center,
            )
            .animate(delay: const Duration(milliseconds: 800))
            .fadeIn(duration: const Duration(milliseconds: 600))
            .slideY(begin: 0.2, duration: const Duration(milliseconds: 400)),
      ],
    );
  }

  Widget _buildSummary() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderColor, width: 0.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.pureBlack.withValues(alpha: 0.5),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Mobile Architect with a focus on AI-driven experiences, combining deep expertise in Flutter, Kotlin, and Java with backend strengths in Python and FastAPI. Skilled in deploying scalable apps via Railway and automating workflows with CodeMagic. Proficient in modern testing practices including Maestro and unit testing. Well-versed in Agile and lean development methodologies. Passionate about researching AI models and applying machine learning to real-world mobile solutions.',
                textStyle: TextStyles.consoleBody.copyWith(
                  color: AppColors.primaryText,
                ),
                textAlign: TextAlign.center,
                speed: const Duration(milliseconds: 30),
              ),
            ],
            totalRepeatCount: 1,
            pause: const Duration(milliseconds: 500),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        )
        .animate(delay: const Duration(milliseconds: 600))
        .slideY(
          begin: 0.3,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
        )
        .fadeIn(duration: const Duration(milliseconds: 600));
  }

  Widget _buildSkillsSection() {
    return Obx(
      () => Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 4.0,
        spacing: 6.0,
        children: controller.skills
            .map(
              (skill) => SkillChip(
                skill: skill,
                onTap: () => controller.openSkillDetail(skill),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSectionTitle(String title, int delayMs) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Text(title, style: TextStyles.sectionTitle)
              .animate(delay: Duration(milliseconds: delayMs))
              .slideX(
                begin: -1,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
              )
              .fadeIn(duration: const Duration(milliseconds: 600)),
          const SizedBox(height: 12),
          Container(
                height: 2,
                width: 80,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.pureWhite,
                      AppColors.lightAccent,
                      AppColors.pureWhite,
                    ],
                  ),
                ),
              )
              .animate(delay: Duration(milliseconds: delayMs + 300))
              .scaleX(
                begin: 0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
              ),
        ],
      ),
    );
  }

  Widget _buildAnimatedChipSection(List<String> items, int delayMs) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.borderColor, width: 1),
              ),
              child: Text(
                item,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            )
            .animate(delay: Duration(milliseconds: delayMs + index * 100))
            .scale(
              begin: const Offset(0.8, 0.8),
              duration: const Duration(milliseconds: 400),
              curve: Curves.elasticOut,
            )
            .fadeIn(duration: const Duration(milliseconds: 300));
      }).toList(),
    );
  }

  Widget _buildBookMeetingButton() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.pureWhite, AppColors.lightAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.pureWhite, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.pureBlack.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Get.to(() => CalendlyPage());
              },
              borderRadius: BorderRadius.circular(12),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: AppColors.pureBlack,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Book a Meeting",
                      style: TextStyle(
                        color: AppColors.pureBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate(delay: const Duration(milliseconds: 2200))
        .fadeIn(duration: const Duration(milliseconds: 400))
        .slideX(
          begin: -0.2,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
        );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
          onPressed: () => _showChatBottomSheet(),
          backgroundColor: Colors.grey.shade700,
          foregroundColor: AppColors.pureWhite,
          elevation: 8,
          child: LottieBuilder.asset(
            'assets/lottie/chatbot_loader.json',
            width: 60,
            height: 60,
          ),
        )
        .animate(delay: const Duration(milliseconds: 2500))
        .scale(
          begin: const Offset(0.5, 0.5),
          duration: const Duration(milliseconds: 800),
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: const Duration(milliseconds: 400));
  }

  void _showChatBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          Container(
            height: Get.height * 0.8,
            decoration: const BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: const ChatBottomSheet(),
          ).animate().slideY(
            begin: 1.0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
          ),
    );
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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ProjectMarquee(projects: projects, cardWidth: cardWidth),
    );
  }

  Widget _buildMediumStories() {
    return const MediumStoriesWidget();
  }

  Widget _buildFlutterPlugins() {
    return const FlutterPluginsWidget();
  }
}
