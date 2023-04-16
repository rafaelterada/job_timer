import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/entities/project_task.dart';
import 'package:job_timer/app/repositories/projects/project_repository.dart';
import 'package:job_timer/app/services/project/project_service.dart';
import 'package:job_timer/app/view_models/project_task_view_model.dart';
import 'package:job_timer/app/view_models/project_view_model.dart';

class ProjectServiceImpl implements ProjectService {
  final ProjectRepository _repository;

  ProjectServiceImpl({
    required ProjectRepository repository,
  }) : _repository = repository;

  @override
  Future<void> register(ProjectViewModel projectViewModel) async {
    final project = Project()
      ..id = projectViewModel.id
      ..name = projectViewModel.name
      ..status = projectViewModel.status
      ..hours = projectViewModel.hours;

    await _repository.register(project);
  }

  @override
  Future<List<ProjectViewModel>> findByStatus(ProjectStatus status) async {
    final projects = await _repository.findByStatus(status);
    return projects.map(ProjectViewModel.fromEntity).toList();
  }

  @override
  Future<ProjectViewModel> findById(int projectId) async {
    final project = await _repository.findById(projectId);
    return ProjectViewModel.fromEntity(project);
  }

  @override
  Future<ProjectViewModel> addTask(
      int projectId, ProjectTaskViewModel task) async {
    final projectTask = ProjectTask()
      ..id = task.id
      ..name = task.name
      ..duration = task.duration;

    final project = await _repository.addTask(projectId, projectTask);
    return ProjectViewModel.fromEntity(project);
  }

  @override
  Future<void> endProject(int projectId) async {
    _repository.endProject(projectId);
  }
}
