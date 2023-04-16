import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/services/project/project_service.dart';
import 'package:job_timer/app/view_models/project_view_model.dart';

part 'project_detail_state.dart';

class ProjectDetailController extends Cubit<ProjectDetailState> {
  final ProjectService _projectService;

  ProjectDetailController({required ProjectService projectService})
      : _projectService = projectService,
        super(const ProjectDetailState.initial());

  void setProject(ProjectViewModel project) {
    emit(state.copyWith(
        projectViewModel: project, status: ProjectDetailStatus.completed));
  }

  Future<void> updateProject() async {
    emit(state.copyWith(status: ProjectDetailStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));

    final projectUpdate =
        await _projectService.findById(state.projectViewModel!.id!);
    emit(state.copyWith(
        projectViewModel: projectUpdate,
        status: ProjectDetailStatus.completed));
  }

  Future<void> endProject() async {
    try {
      emit(state.copyWith(status: ProjectDetailStatus.loading));
      final projectId = state.projectViewModel!.id!;
      await _projectService.endProject(projectId);
      await updateProject();
    } catch (e, s) {
      log('Error while trying to end the project',
          error: e, stackTrace: s);
      emit(state.copyWith(status: ProjectDetailStatus.error));
    }
  }
}
