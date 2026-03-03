class ProjectModel {
  final String title;
  final String description;
  final List<String> techStack;
  final String githubUrl;
  final String? liveUrl;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.techStack,
    required this.githubUrl,
    this.liveUrl,
  });
}
