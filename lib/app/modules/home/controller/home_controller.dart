import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/services/project/project_service.dart';
import 'package:job_timer/app/view_models/project_view_model.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProjectService _projectService;

  HomeController({required ProjectService projectService})
      : _projectService = projectService,
        super(HomeState.initial());

  Future<void> loadProjects() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final projects = await _projectService.findByStatus(state.filterStatus);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } catch (e, s) {
      log('An error occurred while loading projects', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.error));
    }
  }

  Future<void> filter(ProjectStatus status) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading, projects: []));
      final projects = await _projectService.findByStatus(status);
      emit(state.copyWith(
          status: HomeStatus.complete,
          projects: projects,
          filterStatus: status));
    } catch (e, s) {
      log('An error occurred while loading projects by filter',
          error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.error));
    }
  }

  void updateProjects() => filter(state.filterStatus);
}
