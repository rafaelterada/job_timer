import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:job_timer/app/view_models/project_view_model.dart';

class ProjectDetailAppbar extends SliverAppBar {
  ProjectDetailAppbar({super.key, required ProjectViewModel projectModel})
      : super(
          expandedHeight: 100,
          pinned: true,
          toolbarHeight: 100,
          title: Text(projectModel.name),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          )),
          flexibleSpace: Stack(
            children: [
              Align(
                alignment: const Alignment(0, 1.6),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${projectModel.tasks.length} tasks',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Visibility(
                            visible:
                                projectModel.status == ProjectStatus.inProgress,
                            replacement: const Text(
                              'Project Finished',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: _NewTask(projectModel: projectModel),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
}

class _NewTask extends StatelessWidget {
  final ProjectViewModel projectModel;
  const _NewTask({required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          await Modular.to.pushNamed('/project/task/', arguments: projectModel);
          Modular.get<ProjectDetailController>().updateProject();
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CircleAvatar(
                maxRadius: 15,
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            const Text(
              'Add New Task',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
