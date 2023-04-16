import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/asuka_snack_bar.dart';
import 'package:job_timer/app/core/ui/job_timer_icons.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:job_timer/app/modules/project/detail/widget/project_detail_appbar.dart';
import 'package:job_timer/app/modules/project/detail/widget/project_pie_chart.dart';
import 'package:job_timer/app/modules/project/detail/widget/project_task_tile.dart';
import 'package:job_timer/app/view_models/project_view_model.dart';

class ProjectDetailPage extends StatelessWidget {
  final ProjectDetailController controller;
  const ProjectDetailPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProjectDetailController, ProjectDetailState>(
        bloc: controller,
        listener: (context, state) {
          if (state.status == ProjectDetailStatus.error) {
            AsukaSnackbar.warning('Error while trying to load project details')
                .show();
          }
        },
        builder: (context, state) {
          final projectModel = state.projectViewModel;

          switch (state.status) {
            case ProjectDetailStatus.initial:
              return const Center(
                child: Text('Loading Project'),
              );

            case ProjectDetailStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ProjectDetailStatus.completed:
            case ProjectDetailStatus.error:
              if (projectModel != null) {
                return _buildProjecDetail(context, projectModel);
              }
              return const Center(
                child: Text('Error while trying to load project details'),
              );
          }
        },
      ),
    );
  }

  Widget _buildProjecDetail(BuildContext context, ProjectViewModel project) {
    return CustomScrollView(
      slivers: [
        ProjectDetailAppbar(projectModel: project),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              child: ProjectPieChart(projectModel: project),
            ),
            ...project.tasks
                .map((task) => ProjectTaskTile(task: task))
                .toList(),
          ]),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 10),
              child: Visibility(
                visible: project.status == ProjectStatus.inProgress,
                child: ElevatedButton.icon(
                    onPressed: () {
                      controller.endProject();                      
                    },
                    icon: const Icon(JobTimerIcons.check),
                    label: const Text('End Project')),
              ),
            ),
          ),
        )
      ],
    );
  }
}
