import 'package:isar/isar.dart';
import 'package:job_timer/app/entities/project_task.dart';

class ProjectTaskViewModel {
  final Id? id;
  final String name;
  final int duration;

  ProjectTaskViewModel({
    this.id,
    required this.name,
    required this.duration,
  });

  factory ProjectTaskViewModel.fromEntity(ProjectTask task) {
    return ProjectTaskViewModel(
      id: task.id,
      name: task.name,
      duration: task.duration,
    );
  }
}
