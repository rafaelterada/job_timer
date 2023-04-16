import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/services/project/project_service.dart';
import 'package:job_timer/app/view_models/project_task_view_model.dart';
import 'package:job_timer/app/view_models/project_view_model.dart';

part 'task_state.dart';

class TaskController extends Cubit<TaskStatus> {
  late final ProjectViewModel _projectModel;
  final ProjectService _projectService;

  TaskController({required ProjectService projectService})
      : _projectService = projectService,
        super(TaskStatus.initial);

  void setProject(ProjectViewModel projectModel) =>
      _projectModel = projectModel;

  Future<void> save(String name, int duration) async {
    try {
      emit(TaskStatus.loading);
      final task = ProjectTaskViewModel(name: name, duration: duration);
      await _projectService.addTask(_projectModel.id!, task);
      emit(TaskStatus.success);
    } catch (e, s) {
      log('Error while trying to add new task', error: e, stackTrace: s);
      emit(TaskStatus.error);
    }
  }
}
