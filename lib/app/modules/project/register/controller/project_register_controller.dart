import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/services/project/project_service.dart';
import 'package:job_timer/app/view_models/project_view_model.dart';

part 'project_register_state.dart';

class ProjectRegisterController extends Cubit<ProjectRegisterState> {
  final ProjectService _projectService;

  ProjectRegisterController({required ProjectService projectService})
      : _projectService = projectService,
        super(const ProjectRegisterState.initial());

  Future<void> register(String name, int hours) async {
    try {
      emit(state.copyWith(status: ProjectRegisterStatus.loading));
      final project = ProjectViewModel(
        name: name,
        hours: hours,
        status: ProjectStatus.inProgress,
        tasks: [],
      );
      await _projectService.register(project);
      emit(state.copyWith(status: ProjectRegisterStatus.success));
    } catch (e, s) {
      log('An error occurred while trying to save the project',
          error: e, stackTrace: s);
      emit(state.copyWith(
          status: ProjectRegisterStatus.error,
          errorMessage: 'An error occurred while trying to save the project'));
    }
  }
}
