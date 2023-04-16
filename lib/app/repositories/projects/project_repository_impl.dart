import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_timer/app/core/database/database.dart';
import 'package:job_timer/app/core/exceptions/failure.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/entities/project_task.dart';

import './project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Database _database;

  ProjectRepositoryImpl({
    required Database database,
  }) : _database = database;

  @override
  Future<void> register(Project project) async {
    try {
      final connection = await _database.openConnection();

      await connection.writeTxn(() {
        return connection.projects.put(project);
      });
    } on IsarError catch (e, s) {
      log('An error occurred while trying to save the project',
          error: e, stackTrace: s);
      throw Failure(
          message: 'An error occurred while trying to save the project');
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    final connection = await _database.openConnection();
    final projects =
        await connection.projects.filter().statusEqualTo(status).findAll();
    return projects;
  }

  @override
  Future<Project> addTask(int projectId, ProjectTask task) async {
    final connection = await _database.openConnection();
    final project = await findById(projectId);

    // Save the task at ProjectTasks Collection
    await connection.writeTxn(() => connection.projectTasks.put(task));

    // Link and save the above task to the project
    project.tasks.add(task);
    await connection.writeTxn(() => project.tasks.save());

    return project;
  }

  @override
  Future<Project> findById(int projectId) async {
    final connection = await _database.openConnection();
    final project = await connection.projects.get(projectId);
    if (project == null) {
      throw Failure(message: 'Project not found');
    }
    return project;
  }

  @override
  Future<void> endProject(int projectId) async {
    try {
      final connection = await _database.openConnection();
      final project = await findById(projectId);
      project.status = ProjectStatus.finished;
      await connection.writeTxn(() => connection.projects.put(project));
    } on IsarError catch (e, s) {
      log('An error occurred while trying to end the project',
          error: e, stackTrace: s);
      throw Failure(
          message: 'An error occurred while trying to end the project');
    }
  }
}
