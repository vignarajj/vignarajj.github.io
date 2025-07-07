class Skill {
  final String name;
  final String description;
  final double proficiency; // e.g., 0.8 for 80%
  final String iconPath;

  Skill({
    required this.name,
    required this.description,
    required this.proficiency,
    required this.iconPath,
  });
}
