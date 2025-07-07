import 'package:get/get.dart';
import 'package:portfolio/network/api_services.dart';
import 'package:portfolio/routes/app_pages.dart';
import 'package:portfolio/shared/models/core_compentency.dart';
import 'package:portfolio/shared/models/skill_model.dart';

class HomeController extends GetxController {
  final skills = [
    Skill(
      name: 'Flutter',
      description:
          'Expert in building cross-platform mobile applications using Flutter. '
          'Capable of delivering high-performance apps with a single codebase for both Android and iOS. '
          'Proficient in using Flutter’s widget-based framework to create intuitive and responsive UIs.',
      proficiency: 0.9,
      iconPath: 'assets/images/flutter.svg',
    ),
    Skill(
      name: 'Dart',
      description:
          'Skilled in using Dart, the primary language for Flutter development. '
          'Experienced in writing clean and maintainable code with a focus on UI-centric applications. '
          'Adept at leveraging Dart’s asynchronous programming features for smooth app performance.',
      proficiency: 0.85,
      iconPath: 'assets/images/dart.svg',
    ),
    Skill(
      name: 'JavaScript',
      description:
          'Proficient in JavaScript for developing dynamic and interactive web applications. '
          'Experienced with various frameworks and libraries like React and Angular for front-end development. '
          'Capable of creating responsive designs and enhancing user experience through scripting.',
      proficiency: 0.6,
      iconPath: 'assets/images/javascript.svg',
    ),
    Skill(
      name: 'Android',
      description:
          'Extensive experience in developing native Android applications using Java and Kotlin. '
          'Skilled in creating robust, high-performance apps optimized for various Android devices. '
          'Proficient in utilizing Android SDK and APIs for feature-rich applications.',
      proficiency: 0.7,
      iconPath: 'assets/images/android.svg',
    ),
    Skill(
      name: 'Kotlin',
      description:
          'Expertise in Kotlin for modern Android app development. '
          'Utilizes Kotlin’s concise syntax and powerful features to write safer and more efficient code. '
          'Experience in converting legacy Java codebases to Kotlin for improved performance and readability.',
      proficiency: 0.7,
      iconPath: 'assets/images/kotlin.svg',
    ),
    Skill(
      name: 'Java',
      description:
          'Solid foundation in Java for object-oriented programming across various platforms. '
          'Proficient in building scalable and secure applications using Java’s robust ecosystem. '
          'Experienced in using Java for Android development, web services, and enterprise solutions.',
      proficiency: 0.8,
      iconPath: 'assets/images/java.svg',
    ),
    Skill(
      name: 'POSTMAN',
      description:
          'Highly skilled in using POSTMAN for API development and testing. '
          'Capable of automating API testing and ensuring seamless integration between services. '
          'Proficient in designing and maintaining API documentation, collections, and environments.',
      proficiency: 0.8,
      iconPath: 'assets/images/postman.svg',
    ),
    Skill(
      name: 'Manual Testing',
      description:
          'Experienced in conducting thorough manual testing to ensure software quality. '
          'Proficient in identifying bugs, verifying fixes, and performing regression testing. '
          'Focused on maintaining high standards for usability, functionality, and performance.',
      proficiency: 0.9,
      iconPath: 'assets/images/manual.svg',
    ),
    Skill(
      name: 'Automation Testing',
      description:
          'Specialized in using automation tools like Selenium and Appium for efficient testing. '
          'Able to design, write, and maintain automated test scripts for various platforms. '
          'Ensures faster release cycles while maintaining software quality and reliability.',
      proficiency: 0.7,
      iconPath: 'assets/images/automation.svg',
    ),
    Skill(
      name: 'Code Magic',
      description:
          'Proficient in using Code Magic for continuous integration and deployment (CI/CD) automation. '
          'Expert in setting up build pipelines to streamline development processes. '
          'Ensures reliable and repeatable builds, leading to faster and more frequent releases.',
      proficiency: 0.6,
      iconPath: 'assets/images/code_magic.svg',
    ),
    Skill(
      name: 'Jira',
      description:
          'Experienced in using Jira for project management, issue tracking, and team collaboration. '
          'Adept at creating and managing tasks, sprints, and backlogs in Agile environments. '
          'Utilizes Jira to monitor progress, report on project status, and ensure timely delivery.',
      proficiency: 0.7,
      iconPath: 'assets/images/jira.svg',
    ),
    Skill(
      name: 'Documentation',
      description:
          'Highly skilled in writing clear, comprehensive, and accessible documentation for projects. '
          'Experienced in creating technical documents, user manuals, and API guides. '
          'Ensures that documentation is up-to-date, accurate, and easy to follow for all stakeholders.',
      proficiency: 0.9,
      iconPath: 'assets/images/documentation.svg',
    ),
    Skill(
      name: 'Code Review',
      description:
          'Expert in conducting thorough code reviews to ensure code quality and adherence to best practices. '
          'Adept at identifying potential issues, providing constructive feedback, and mentoring peers. '
          'Focused on maintaining high standards for code maintainability, readability, and performance.',
      proficiency: 0.9,
      iconPath: 'assets/images/review.svg',
    ),
    Skill(
      name: 'Git',
      description:
          'Proficient in using Git for version control, collaboration, and managing codebases. '
          'Experienced in branching, merging, and resolving conflicts to maintain clean project histories. '
          'Utilizes Git for both individual projects and team collaborations, ensuring code integrity.',
      proficiency: 0.7,
      iconPath: 'assets/images/git.svg',
    ),
    Skill(
      name: 'Photoshop',
      description:
          'Experienced in using Adobe Photoshop for graphic design and image editing. '
          'Capable of creating custom graphics, logos, and UI elements for web and mobile applications. '
          'Applies creative techniques to enhance visual designs and improve user interfaces.',
      proficiency: 0.5,
      iconPath: 'assets/images/photoshop.svg',
    ),
    Skill(
      name: 'Figma',
      description:
          'Proficient in using Figma for UI/UX design, prototyping, and collaboration. '
          'Skilled in creating interactive and responsive designs that align with user needs and project goals. '
          'Experience in working with design systems and ensuring consistency across products.',
      proficiency: 0.5,
      iconPath: 'assets/images/medium.svg',
    ),
    Skill(
      name: 'Architecture Formation',
      description:
          'Expert in designing software architectures that are scalable, maintainable, and efficient. '
          'Experienced in breaking down complex systems into modular components and services. '
          'Focused on selecting appropriate design patterns and technologies to meet project requirements.',
      proficiency: 0.6,
      iconPath: 'assets/images/architecture.svg',
    ),
    Skill(
      name: 'SonarQube/Lint',
      description:
          'Experienced in using SonarQube and Lint for static code analysis and ensuring code quality. '
          'Capable of integrating these tools into CI/CD pipelines for continuous code quality monitoring. '
          'Focused on identifying code smells, vulnerabilities, and ensuring adherence to coding standards.',
      proficiency: 0.6,
      iconPath: 'assets/images/lint.svg',
    ),
    Skill(
      name: 'GitHub Workflow',
      description:
          'Skilled in automating development workflows using GitHub Actions. '
          'Capable of setting up CI/CD pipelines, automating testing, and deployment processes. '
          'Ensures consistent and reliable builds, allowing for faster iterations and releases.',
      proficiency: 0.6,
      iconPath: 'assets/images/github_skill.svg',
    ),
    Skill(
      name: "Rest API's",
      description:
          'Proficient in designing and implementing RESTful APIs for seamless data exchange. '
          'Experienced in creating secure, scalable, and maintainable APIs for various applications. '
          'Focused on adhering to best practices and standards to ensure API reliability and performance.',
      proficiency: 0.6,
      iconPath: 'assets/images/apis.svg',
    ),
    Skill(
      name: 'Web Sockets',
      description:
          'Experienced in using WebSockets for real-time, bi-directional communication in web applications. '
          'Capable of implementing WebSocket connections for features like live chats, notifications, and updates. '
          'Focused on optimizing WebSocket performance for responsive and engaging user experiences.',
      proficiency: 0.6,
      iconPath: 'assets/images/websocket.svg',
    ),
    Skill(
      name: 'POS (Point of Sale)',
      description:
          'Skilled in developing and integrating POS systems for seamless retail transactions. '
          'Experience in creating and managing software for inventory management, sales tracking, and payment processing. '
          'Focused on delivering user-friendly POS solutions that enhance operational efficiency and customer satisfaction.',
      proficiency: 0.6,
      iconPath: 'assets/images/pos.svg',
    ),
    Skill(
      name: 'Device Integration',
      description:
          'Expert in integrating wireless devices and ensuring seamless connectivity across platforms. '
          'Experience in working with various protocols and standards for IoT and smart devices. '
          'Focused on delivering robust and scalable solutions for device communication and control.',
      proficiency: 0.6,
      iconPath: 'assets/images/connectivity.svg',
    ),
    Skill(
      name: 'ML/AI',
      description:
          'Experienced in building intelligent systems using machine learning and artificial intelligence. '
          'Skilled in developing models for predictive analytics, automation, and data-driven decision-making. '
          'Focused on applying AI techniques to solve complex problems and enhance business processes.',
      proficiency: 0.6,
      iconPath: 'assets/images/ai.svg',
    ),
  ].obs;

  final List<CoreCompetency> coreCompetencies = [
    CoreCompetency(
      title: 'Team Management',
      description:
          'With over a decade of experience in leading diverse teams across various projects, I have honed my ability to inspire and guide team members toward achieving collective goals. My approach to team management involves fostering a collaborative environment where open communication is encouraged, and every team member feels valued. I believe in empowering individuals by providing them with the tools and support they need to excel in their roles while also maintaining accountability. My experience includes managing cross-functional teams, handling conflicts with diplomacy, and ensuring that projects are delivered on time and within budget. I am adept at aligning team objectives with organizational goals, driving motivation, and facilitating continuous learning and development. By cultivating a positive team culture, I have consistently achieved high levels of productivity and job satisfaction among team members, resulting in successful project outcomes and long-term employee retention.',
    ),
    CoreCompetency(
      title: 'Project Planning',
      description:
          'Project planning is the cornerstone of any successful project, and my extensive experience in this area has equipped me with the skills to meticulously plan, execute, and deliver projects on time and within scope. I am proficient in creating detailed project plans that include clear timelines, resource allocation, risk assessments, and contingency strategies. My approach to project planning is methodical and data-driven, ensuring that every aspect of the project is carefully considered and accounted for. I have successfully managed projects ranging from small-scale initiatives to large, complex undertakings, consistently meeting deadlines and staying within budget. I excel in coordinating with stakeholders to align project goals with business objectives, ensuring that all parties are informed and engaged throughout the project lifecycle. My ability to foresee potential challenges and proactively address them has been key to the successful delivery of numerous projects, often exceeding expectations.',
    ),
    CoreCompetency(
      title: 'Mentorship and Coaching',
      description:
          'Mentorship and coaching are integral parts of my leadership philosophy, and I am deeply committed to helping others grow both personally and professionally. I have mentored and coached numerous individuals throughout my career, providing them with guidance, feedback, and support as they navigate their career paths. My approach to mentorship is tailored to each individual, focusing on their unique strengths, challenges, and aspirations. I believe in fostering a growth mindset, encouraging continuous learning, and providing opportunities for mentees to take on new challenges and expand their skill sets. Through regular one-on-one sessions, goal-setting, and constructive feedback, I have helped many team members achieve significant milestones in their careers, from mastering new technical skills to stepping into leadership roles. My coaching extends beyond technical expertise; I also emphasize the importance of soft skills such as communication, problem-solving, and emotional intelligence, which are crucial for success in any professional setting.',
    ),
    CoreCompetency(
      title: 'Audience Engagement',
      description:
          'Audience engagement is a critical aspect of my role, and I have developed a deep understanding of how to effectively connect with diverse audiences across various platforms. My expertise lies in crafting messages and content that resonate with the target audience, whether it’s through digital channels, presentations, or face-to-face interactions. I have a proven track record of successfully engaging stakeholders, clients, and end-users, ensuring that their needs are understood and addressed throughout the project lifecycle. My approach to audience engagement is both strategic and empathetic, focusing on building trust and fostering long-term relationships. I am skilled in utilizing data and analytics to tailor my communication strategies, ensuring that they are relevant and impactful. By consistently delivering value and maintaining open lines of communication, I have been able to drive higher levels of engagement, satisfaction, and loyalty among audiences. My experience spans across industries, allowing me to adapt my strategies to meet the unique needs of different audiences effectively.',
    ),
  ];

  void openSkillDetail(Skill skill) {
    Get.toNamed(AppRoutes.skill, arguments: skill);
  }

  RxInt visitorsCount = 4534.obs;
  RxBool isLoading = false.obs;
  ApiServices apiServices = GetInstance().find<ApiServices>();

  @override
  Future<void> onInit() async {
    await getVisitorsCount();
    super.onInit();
  }

  Future<void> getVisitorsCount() async {
    print("call1");
    isLoading.value = true;
    try {
      print("call2");
      visitorsCount.value = await apiServices.getVisitorsCount();
      print("visitors_count:: ${visitorsCount.value}");
      isLoading.value = false;
    } catch (e) {
      print("failed to get the visitors count");
      isLoading.value = false;
    }
  }
}
