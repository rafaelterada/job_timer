import 'package:isar/isar.dart';
import 'package:job_timer/app/entities/project.dart';

import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/view_models/project_task_view_model.dart';

class ProjectViewModel {
  final Id? id;
  final String name;
  final int hours;
  final ProjectStatus status;
  final List<ProjectTaskViewModel> tasks;

  ProjectViewModel({
    this.id,
    required this.name,
    required this.hours,
    required this.status,
    required this.tasks,
  });

  factory ProjectViewModel.fromEntity(Project project) {
    //! Necessário carregar as tasks do DB, pq o Project tem apenas os "links" (IsarLinks<ProjectTask>)
    project.tasks.loadSync();

    return ProjectViewModel(
      id: project.id,
      name: project.name,
      hours: project.hours,
      status: project.status,
      tasks: project.tasks.map(ProjectTaskViewModel.fromEntity).toList(),
    );
  }
}
