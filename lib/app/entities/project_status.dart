enum ProjectStatus {
  inProgress (label: 'In Progress'),
  finished (label: 'Finished');

  final String label;

  const ProjectStatus({required this.label});
}
