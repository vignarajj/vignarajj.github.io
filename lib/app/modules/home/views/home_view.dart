import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/app/modules/chat/views/chat_bottom_sheet.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:portfolio/shared/theme/app_colors.dart';
import 'package:portfolio/shared/theme/text_styles.dart';
import 'package:portfolio/shared/constants/app_constants.dart';
import 'package:portfolio/shared/widgets/contact_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final ScrollController _scrollController = ScrollController();
  final RxBool _isLoading = true.obs;
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _worksKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Simulate loading
    Future.delayed(const Duration(milliseconds: AppDimensions.loadingDelayMilliseconds), () {
      _isLoading.value = false;
    });

    return Obx(
      () => _isLoading.value
          ? _buildLoadingScreen()
          : LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth > AppDimensions.homeDesktopBreakpoint;
                return Scaffold(
                  backgroundColor: AppColors.primaryBackground,
                  drawer: !isDesktop ? _buildMobileDrawer() : null,
                  appBar: !isDesktop ? _buildMobileAppBar() : null,
                  body: _buildMainContent(context, isDesktop, constraints),
                  bottomNavigationBar: _buildActionBottomBar(isDesktop),
                  extendBody: true,
                );
              },
            ),
    );
  }

  Widget _buildMainContent(
    BuildContext context,
    bool isDesktop,
    BoxConstraints constraints,
  ) {
    final horizontalPadding = isDesktop ? AppDimensions.homeHorizontalPaddingDesktop : AppDimensions.homeHorizontalPaddingMobile;
    final maxContentWidth = AppDimensions.maxContentWidth;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isDesktop ? AppDimensions.homeVerticalPaddingDesktop : AppDimensions.homeVerticalPaddingMobile,
              ),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isDesktop ? maxContentWidth : constraints.maxWidth,
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (isDesktop) _buildNavigationBar(),
                        _buildProfileSection(isDesktop),
                        const SizedBox(height: AppDimensions.spacing32),
                        Container(
                          key: _aboutKey,
                          child: _buildKnowledgeSection(isDesktop),
                        ),
                        const SizedBox(height: AppDimensions.spacing32),
                        Container(
                          key: _projectsKey,
                          child: _buildProjectsSection(isDesktop),
                        ),
                        const SizedBox(height: AppDimensions.spacing32),
                        Container(key: _worksKey, child: _buildWorksSection(isDesktop)),
                        const SizedBox(height: AppDimensions.spacing32),
                        Container(
                          key: _servicesKey,
                          child: _buildServicesSection(isDesktop),
                        ),
                        const SizedBox(height: AppDimensions.spacing32),
                        Container(
                          key: _contactKey,
                          child: _buildContactSection(isDesktop),
                        ),
                        SizedBox(height: isDesktop ? AppDimensions.spacing24 : AppDimensions.bottomBarHeightDesktop),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileSection(bool isDesktop) {
    final avatarRadius = isDesktop ? AppDimensions.profileAvatarRadiusDesktop : AppDimensions.profileAvatarRadiusMobile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.lightAccent.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: avatarRadius,
            backgroundColor: AppColors.lightAccent,
            child: CircleAvatar(
              radius: avatarRadius - AppDimensions.profileAvatarBorderWidth,
              backgroundImage: AssetImage(AppAssets.profilePic),
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spacing24),
        Text(
          AppStrings.profileName,
          style: isDesktop ? TextStyles.profileName : TextStyles.profileNameMobile,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.spacing12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge, vertical: AppDimensions.paddingSmall),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
            border: Border.all(
              color: AppColors.lightAccent.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            AppStrings.profileSubtitle,
            style: isDesktop ? TextStyles.profileSubtitle : TextStyles.profileSubtitleMobile,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildKnowledgeSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.aboutMeTitle,
          style: isDesktop ? TextStyles.sectionTitle : TextStyles.sectionTitleMobile,
        ),
        const SizedBox(height: 12),
        Text(
          AppStrings.aboutDescription,
          style: isDesktop ? TextStyles.sectionDescription : TextStyles.sectionDescriptionMobile,
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.skillsTitle,
          style: isDesktop ? TextStyles.sectionTitle : TextStyles.sectionTitleMobile,
        ),
        const SizedBox(height: 8),
        _buildInteractiveSkills(isDesktop),
      ],
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: AppDimensions.loadingAnimationSize,
              height: AppDimensions.loadingAnimationSize,
              child: Lottie.asset(
                AppAssets.loaderAnimation,
                fit: BoxFit.contain,
                repeat: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveSkills(bool isDesktop) {
    final skills = [
      {'name': AppStrings.flutterSkill, 'asset': AppAssets.flutterIcon},
      {'name': AppStrings.dartSkill, 'asset': AppAssets.dartIcon},
      {'name': AppStrings.androidSkill, 'asset': AppAssets.androidIcon},
      {'name': AppStrings.kotlinSkill, 'asset': AppAssets.kotlinIcon},
      {'name': AppStrings.javaSkill, 'asset': AppAssets.javaIcon},
      {'name': AppStrings.javascriptSkill, 'asset': AppAssets.javascriptIcon},
      {'name': AppStrings.aiSkill, 'asset': AppAssets.aiIcon},
      {'name': AppStrings.gitSkill, 'asset': AppAssets.gitIcon},
      {'name': 'Postman', 'asset': AppAssets.postmanIcon},
      {'name': 'CodeMagic', 'asset': AppAssets.codeMagicIcon},
      {'name': 'APIs', 'asset': AppAssets.apisIcon},
      {'name': 'Architecture', 'asset': AppAssets.architectureIcon},
    ];

    return isDesktop
        ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppDimensions.skillsGridCrossAxisCountDesktop,
              crossAxisSpacing: AppDimensions.skillsGridSpacingDesktop,
              mainAxisSpacing: AppDimensions.skillsGridSpacingDesktop,
              childAspectRatio: AppDimensions.skillsGridAspectRatioDesktop,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) =>
                _buildSkillCard(skills[index], isDesktop),
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppDimensions.skillsGridCrossAxisCountMobile,
              crossAxisSpacing: AppDimensions.skillsGridSpacingMobile,
              mainAxisSpacing: AppDimensions.skillsGridSpacingMobile,
              childAspectRatio: AppDimensions.skillsGridAspectRatioMobile,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) =>
                _buildSkillCard(skills[index], isDesktop),
          );
  }

  Widget _buildSkillCard(Map<String, dynamic> skill, bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingSmall),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 2,
            child: SvgPicture.asset(
              skill['asset'] as String,
              width: isDesktop ? AppDimensions.skillIconSizeDesktop : AppDimensions.skillIconSizeMobile,
              height: isDesktop ? AppDimensions.skillIconSizeDesktop : AppDimensions.skillIconSizeMobile,
              colorFilter: ColorFilter.mode(
                AppColors.pureWhite,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(height: AppDimensions.spacing4),
          Flexible(
            flex: 1,
            child: Text(
              skill['name'] as String,
              style: isDesktop ? TextStyles.skillName : TextStyles.skillNameMobile,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection(bool isDesktop) {
    final projects = [
      {
        'name': 'Repository Generator',
        'description':
            'A comprehensive tool for generating well-structured repositories with proper documentation, README files, and project templates for various programming languages and frameworks.',
        'url': 'https://vignaraj.dev/repo_generator/',
        'tech': ['Flutter Web', 'Dart', 'GitHub API'],
        'type': 'Web Application',
      },
      {
        'name': 'Color Picker',
        'description':
            'An advanced color picker tool with support for multiple color formats including HEX, RGB, HSL, and HSV. Features color palette generation and accessibility testing.',
        'url': 'https://vignaraj.dev/color_picker/',
        'tech': ['Flutter Web', 'Color Theory', 'UI/UX'],
        'type': 'Design Tool',
      },
      {
        'name': 'Theme Builder',
        'description':
            'A powerful theme generation tool for creating consistent design systems with support for light/dark modes, Material Design guidelines, and custom color schemes.',
        'url': 'https://vignaraj.dev/theme_generator/',
        'tech': ['Flutter Web', 'Material Design', 'CSS'],
        'type': 'Developer Tool',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.featuredProjectsTitle,
          style: isDesktop ? TextStyles.sectionTitle : TextStyles.sectionTitleMobile,
        ),
        const SizedBox(height: AppDimensions.spacing16),
        isDesktop
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) =>
                    _buildProjectCard(projects[index], isDesktop),
              )
            : Column(
                children: projects
                    .map(
                      (project) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildProjectCard(project, isDesktop),
                      ),
                    )
                    .toList(),
              ),
      ],
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project, bool isDesktop) {
    return InkWell(
      onTap: () async {
        final url = project['url'] as String;
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        }
      },
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: Container(
        height: isDesktop ? null : AppDimensions.projectCardHeightMobile,
        padding: EdgeInsets.all(isDesktop ? AppDimensions.paddingLarge : AppDimensions.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project['name'] as String,
                        style: TextStyle(
                          fontFamily: 'SourceCodePro',
                          fontSize: isDesktop ? 16 : 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.pureWhite,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        project['type'] as String,
                        style: TextStyle(
                          fontFamily: 'SourceCodePro',
                          fontSize: 12,
                          color: AppColors.lightAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.launch, color: AppColors.primaryText, size: 16),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Text(
                project['description'] as String,
                style: TextStyle(
                  fontFamily: 'SourceCodePro',
                  fontSize: isDesktop ? 13 : 11,
                  color: AppColors.primaryText,
                  height: 1.4,
                ),
                maxLines: isDesktop ? 5 : 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height: 20,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: (project['tech'] as List<String>).length,
                    itemBuilder: (context, index) {
                      final tech = (project['tech'] as List<String>)[index];
                      return Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.borderColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tech,
                          style: TextStyle(
                            fontFamily: 'SourceCodePro',
                            fontSize: 9,
                            color: AppColors.pureWhite,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorksSection(bool isDesktop) {
    final plugins = [
      {
        'name': 'Logitx',
        'description':
            'A developer-friendly Flutter plugin to capture, view, and manage logs inside your app. Features floating UI, segmented navigation, and powerful search capabilities with automatic API logging.',
        'icon': Icons.bug_report,
        'color': 0xFF4CAF50,
        'link': 'https://pub.dev/packages/logitx',
        'version': '1.0.0+',
        'platforms': ['Android', 'iOS', 'Web'],
        'features': [
          'Debug logs',
          'API monitoring',
          'Export functionality',
          'Search & filter',
        ],
      },
      {
        'name': 'Theme Maker',
        'description':
            'A Flutter package for easy theme management with predefined light/dark themes and dynamic theme generation from any color. Supports Material 3 design principles.',
        'icon': Icons.palette,
        'color': 0xFF2196F3,
        'link': 'https://pub.dev/packages/theme_maker',
        'version': '2.1.0+',
        'platforms': ['Android', 'iOS', 'Web', 'Desktop'],
        'features': [
          'Material 3',
          'Dynamic themes',
          'Light/Dark modes',
          'Color schemes',
        ],
      },
      {
        'name': 'QUtils',
        'description':
            'A comprehensive utility package for Dart & Flutter developers with 195+ countries database, colorful logging, datetime utilities, and cross-platform support.',
        'icon': Icons.build,
        'color': 0xFFFF9800,
        'link': 'https://pub.dev/packages/qutils',
        'version': '3.0.0+',
        'platforms': ['Android', 'iOS', 'Web', 'Desktop'],
        'features': [
          'Countries data',
          'QLogger',
          'DateTime utils',
          'Type conversion',
        ],
      },
      {
        'name': 'Quik Locale',
        'description':
            'Manual, typed, effortless Flutter localization plugin. Define translations as Dart constants with full IDE support, type safety, and 72 built-in locales.',
        'icon': Icons.language,
        'color': 0xFF9C27B0,
        'link': 'https://pub.dev/packages/quik_locale',
        'version': '1.5.0+',
        'platforms': ['Android', 'iOS', 'Web', 'Desktop'],
        'features': [
          'Type safety',
          'IDE support',
          '72 locales',
          'Runtime switching',
        ],
      },
      {
        'name': 'QfTools',
        'description':
            'A comprehensive command-line interface tool for streamlining Flutter project management and development workflows with asset management and automation.',
        'icon': Icons.terminal,
        'color': 0xFFF44336,
        'link': 'https://pub.dev/packages/qftools',
        'version': '1.0.4+',
        'platforms': ['CLI Tool'],
        'features': [
          'Asset management',
          'Code organization',
          'Build automation',
          'Project operations',
        ],
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.flutterPluginsTitle,
          style: isDesktop ? TextStyles.sectionTitle : TextStyles.sectionTitleMobile,
        ),
        const SizedBox(height: 16),
        isDesktop
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: AppDimensions.pluginsGridCrossAxisCountDesktop,
                  crossAxisSpacing: AppDimensions.pluginsGridSpacingDesktop,
                  mainAxisSpacing: AppDimensions.pluginsGridSpacingDesktop,
                  childAspectRatio: AppDimensions.pluginsGridAspectRatioDesktop,
                ),
                itemCount: plugins.length,
                itemBuilder: (context, index) =>
                    _buildPluginCard(plugins[index], isDesktop),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: AppDimensions.pluginsGridCrossAxisCountMobile,
                  crossAxisSpacing: AppDimensions.pluginsGridSpacingMobile,
                  mainAxisSpacing: AppDimensions.pluginsGridSpacingMobile,
                  childAspectRatio: AppDimensions.pluginsGridAspectRatioMobile,
                ),
                itemCount: plugins.length,
                itemBuilder: (context, index) =>
                    _buildPluginCard(plugins[index], isDesktop),
              ),
      ],
    );
  }

  Widget _buildPluginCard(Map<String, dynamic> plugin, bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 16 : 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plugin['name'] as String,
                      style: TextStyle(
                        fontFamily: 'SourceCodePro',
                        fontSize: isDesktop ? 16 : 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.pureWhite,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lightAccent.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            plugin['version'] as String,
                            style: TextStyle(
                              fontFamily: 'SourceCodePro',
                              fontSize: 10,
                              color: AppColors.lightAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'pub.dev',
                          style: TextStyle(
                            fontFamily: 'SourceCodePro',
                            fontSize: 12,
                            color: AppColors.primaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Flexible(
            flex: 2,
            child: Text(
              plugin['description'] as String,
              style: TextStyle(
                fontFamily: 'SourceCodePro',
                fontSize: isDesktop ? 13 : 10,
                color: AppColors.primaryText,
                height: 1.3,
              ),
              maxLines: isDesktop ? 3 : 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Platforms:',
            style: TextStyle(
              fontFamily: 'SourceCodePro',
              fontSize: 11,
              color: AppColors.lightAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: (plugin['platforms'] as List<String>)
                .take(isDesktop ? 3 : 2)
                .map(
                  (platform) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 8 : 6,
                      vertical: isDesktop ? 4 : 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.pureBlack,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                      border: Border.all(color: AppColors.pureWhite, width: 1),
                    ),
                    child: Text(
                      platform,
                      style: TextStyle(
                        fontFamily: 'SourceCodePro',
                        fontSize: isDesktop ? 9 : 8,
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          Text(
            'Key Features:',
            style: TextStyle(
              fontFamily: 'SourceCodePro',
              fontSize: 11,
              color: AppColors.lightAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: isDesktop ? 4 : 2),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: (plugin['features'] as List<String>)
                    .take(isDesktop ? 2 : 1)
                    .map(
                      (feature) => Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 6 : 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.white, width: 0.5),
                        ),
                        child: Text(
                          feature,
                          style: TextStyle(
                            fontFamily: 'SourceCodePro',
                            fontSize: isDesktop ? 8 : 7,
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [const SizedBox(height: 12), const ContactButtons()],
    );
  }

  Widget? _buildActionBottomBar(bool isDesktop) {
    return Container(
      height: isDesktop ? AppDimensions.bottomBarHeightDesktop : AppDimensions.bottomBarHeightMobile,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? AppDimensions.bottomBarPaddingDesktop : AppDimensions.bottomBarPaddingMobile,
        vertical: AppDimensions.spacing12,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(
            color: AppColors.lightAccent.withValues(alpha: 0.15),
            width: 0.5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.pureBlack.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: _buildActionBarButton(
                icon: FontAwesomeIcons.message,
                label: AppStrings.chatAction,
                isSecondary: false,
                onPressed: _showChatBottomSheet,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionBarButton(
                icon: Icons.calendar_today,
                label: isDesktop ? AppStrings.meetingAction : AppStrings.bookAction,
                isSecondary: true,
                onPressed: _openCalendly,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBarButton({
    required IconData icon,
    required String label,
    required bool isSecondary,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Container(
          height: AppDimensions.bottomBarButtonHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isSecondary 
                ? AppColors.primaryBackground
                : AppColors.lightAccent,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            border: Border.all(
              color: isSecondary 
                  ? AppColors.lightAccent.withValues(alpha: 0.3)
                  : AppColors.pureWhite.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSecondary ? AppColors.lightAccent : AppColors.pureBlack,
                size: 18,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'SourceCodePro',
                    fontSize: 14,
                    color: isSecondary ? AppColors.pureWhite : AppColors.pureBlack,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChatBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: AppColors.primaryBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const ChatBottomSheet(),
    );
  }

  void _openCalendly() async {
    const url = AppStrings.calendlyUrl;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  PreferredSizeWidget _buildMobileAppBar() {
    return AppBar(
      title: Text(
        '',
        style: TextStyles.sectionTitle,
      ),
      backgroundColor: AppColors.primaryBackground,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.pureWhite),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: AppColors.primaryBackground,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.lightAccent.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.lightAccent,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage(AppAssets.profilePic),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      AppStrings.profileName,
                      style: TextStyles.cardTitle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildMobileNavItem(AppStrings.aboutNav, _aboutKey, Icons.person),
                  _buildMobileNavItem(AppStrings.projectsNav, _projectsKey, Icons.code),
                  _buildMobileNavItem(AppStrings.worksNav, _worksKey, Icons.work_outline),
                  _buildMobileNavItem(AppStrings.servicesNav, _servicesKey, Icons.business),
                  _buildMobileNavItem(
                    AppStrings.contactNav,
                    _contactKey,
                    Icons.contact_mail,
                    isContactScreen: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(
    String title,
    GlobalKey key,
    IconData icon, {
    bool isContactScreen = false,
  }) {
    final Map<String, String> navImages = {
      AppStrings.aboutNav: AppAssets.infoIcon,
      AppStrings.projectsNav: AppAssets.projectsIcon,
      AppStrings.worksNav: AppAssets.worksIcon,
      AppStrings.servicesNav: AppAssets.servicesIcon,
      AppStrings.contactNav: AppAssets.contactIcon,
    };

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        color: AppColors.cardBackground.withValues(alpha: 0.3),
        border: Border.all(
          color: AppColors.lightAccent.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 32,
          height: 32,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.lightAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: navImages.containsKey(title)
              ? Image.asset(
                  navImages[title]!,
                  width: 24,
                  height: 24,
                  color: AppColors.pureWhite,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    icon,
                    color: AppColors.pureWhite,
                    size: 20,
                  ),
                )
              : Icon(
                  icon,
                  color: AppColors.pureWhite,
                  size: 20,
                ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'SourceCodePro',
            fontSize: 16,
            color: AppColors.pureWhite,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () {
          Navigator.pop(Get.context!);
          if (isContactScreen) {
            Future.delayed(const Duration(milliseconds: AppDimensions.navigationDelayMs), () {
              Get.toNamed('/contact');
            });
          } else {
            Future.delayed(const Duration(milliseconds: AppDimensions.navigationDelayMs), () {
              _scrollToSection(key);
            });
          }
        },
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        border: Border.all(
          color: AppColors.lightAccent.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.pureBlack.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(AppStrings.aboutNav, _aboutKey),
          _buildNavItem(AppStrings.projectsNav, _projectsKey),
          _buildNavItem(AppStrings.worksNav, _worksKey),
          _buildNavItem(AppStrings.servicesNav, _servicesKey),
          _buildNavItem(AppStrings.contactNav, _contactKey),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, GlobalKey key) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: TextButton(
        onPressed: () {
          if (title == AppStrings.contactNav) {
            Get.toNamed('/contact');
          } else {
            _scrollToSection(key);
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.primaryText,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'SourceCodePro',
            fontSize: 14,
            color: AppColors.primaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _scrollToSection(GlobalKey key) {
    Future.delayed(const Duration(milliseconds: AppDimensions.loadingInitialDelayMs), () {
      final context = key.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: AppDimensions.scrollAnimationDurationMs),
          curve: Curves.easeOutCubic,
          alignment: 0.1,
        );
      }
    });
  }

  Widget _buildServicesSection(bool isDesktop) {
    final services = [
      {
        'name': 'Flutter Mobile Development',
        'description':
            'Expert cross-platform mobile applications using Flutter with native performance, custom UI/UX, and seamless user experiences across iOS and Android platforms.',
        'icon': Icons.phone_android,
        'color': 0xFF02569B,
        'features': [
          'Cross-platform apps',
          'Custom UI/UX',
          'Native performance',
        ],
      },
      {
        'name': 'Android Native Development',
        'description':
            'Native Android applications using Kotlin and Java with modern architecture patterns, Material Design guidelines, and platform-specific optimizations.',
        'icon': Icons.android,
        'color': 0xFF3DDC84,
        'features': [
          'Kotlin & Java',
          'Material Design',
          'Architecture patterns',
        ],
      },
      {
        'name': 'API Development & Integration',
        'description':
            'RESTful API development using FastAPI and Python, seamless third-party integrations, and robust backend services with comprehensive documentation.',
        'icon': Icons.api,
        'color': 0xFF009485,
        'features': ['FastAPI & Python', 'RESTful services', 'Documentation'],
      },
      {
        'name': 'AI/ML Integration',
        'description':
            'Machine learning model integration into mobile applications, AI-driven user experiences, and intelligent automation solutions for enhanced functionality.',
        'icon': Icons.smart_toy,
        'color': 0xFFFF6F00,
        'features': [
          'Model integration',
          'AI-driven UX',
          'Intelligent automation',
        ],
      },
      {
        'name': 'Testing & Quality Assurance',
        'description':
            'Comprehensive testing strategies including manual testing, automated testing with Selenium and Appium, and quality assurance processes.',
        'icon': Icons.bug_report,
        'color': 0xFFE91E63,
        'features': ['Manual testing', 'Automation tools', 'QA processes'],
      },
      {
        'name': 'CI/CD & DevOps',
        'description':
            'Continuous integration and deployment pipelines using CodeMagic, automated build processes, and streamlined development workflows.',
        'icon': Icons.settings_applications,
        'color': 0xFF9C27B0,
        'features': [
          'CI/CD pipelines',
          'Automated builds',
          'Workflow optimization',
        ],
      },
      {
        'name': 'Code Review & Mentoring',
        'description':
            'Professional code reviews, best practices guidance, team mentoring, and knowledge transfer sessions to improve development quality and team skills.',
        'icon': Icons.school,
        'color': 0xFF673AB7,
        'features': ['Code reviews', 'Best practices', 'Team mentoring'],
      },
      {
        'name': 'Technical Consulting',
        'description':
            'Strategic technical consulting, architecture planning, technology stack recommendations, and project roadmap development for successful implementations.',
        'icon': Icons.lightbulb,
        'color': 0xFFFFC107,
        'features': [
          'Architecture planning',
          'Tech stack advice',
          'Project roadmaps',
        ],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          AppStrings.servicesTitle,
          style: isDesktop ? TextStyles.sectionTitle : TextStyles.sectionTitleMobile,
        ),
        const SizedBox(height: 16),
        isDesktop
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) =>
                    _buildServiceCard(services[index], isDesktop),
              )
            : Column(
                children: services
                    .map(
                      (service) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildServiceCard(service, isDesktop),
                      ),
                    )
                    .toList(),
              ),
      ],
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service, bool isDesktop) {
    return Container(
      height: isDesktop ? null : 180,
      padding: EdgeInsets.all(isDesktop ? 16 : 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service['name'] as String,
                style: TextStyle(
                  fontFamily: 'SourceCodePro',
                  fontSize: isDesktop ? 16 : 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.pureWhite,
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Text(
              service['description'] as String,
              style: TextStyle(
                fontFamily: 'SourceCodePro',
                fontSize: isDesktop ? 13 : 11,
                color: AppColors.primaryText,
                height: 1.4,
              ),
              maxLines: isDesktop ? 6 : 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height: 28,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: (service['features'] as List<String>).length,
                  itemBuilder: (context, index) {
                    final feature = (service['features'] as List<String>)[index];
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.pureBlack,
                        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                        border: Border.all(color: AppColors.pureWhite, width: 1),
                      ),
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontFamily: 'SourceCodePro',
                          fontSize: 10,
                          color: AppColors.pureWhite,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
