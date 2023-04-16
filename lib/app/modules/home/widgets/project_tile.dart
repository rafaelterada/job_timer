import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/ui/job_timer_icons.dart';
import 'package:job_timer/app/modules/home/controller/home_controller.dart';
import 'package:job_timer/app/view_models/project_view_model.dart';

class ProjectTile extends StatelessWidget {
  final ProjectViewModel project;

  const ProjectTile({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Modular.to.pushNamed('/project/detail/', arguments: project);
        Modular.get<HomeController>().updateProjects();
      },
      child: Container(
        constraints: const BoxConstraints(maxHeight: 90),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, width: 2),
        ),
        child: Column(
          children: [
            _ProjectName(project: project),
            _ProjectProgress(project: project),
          ],
        ),
      ),
    );
  }
}

class _ProjectName extends StatelessWidget {
  final ProjectViewModel project;

  const _ProjectName({required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(project.name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Icon(
            JobTimerIcons.angle_double_right,
            color: Theme.of(context).primaryColor,
            size: 22,
          )
        ],
      ),
    );
  }
}

class _ProjectProgress extends StatelessWidget {
  final ProjectViewModel project;

  const _ProjectProgress({required this.project});

  @override
  Widget build(BuildContext context) {
    final totalTasks = project.tasks.fold<int>(
        0, ((previousValue, task) => previousValue += task.duration));

    var percent = 0.0;

    if (totalTasks > 0) {
      percent = totalTasks / project.hours;
    }

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey.shade300),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.grey.shade400,
              color: Theme.of(context).primaryColor,
              minHeight: 5,
            )),
            const SizedBox(
              width: 8,
            ),
            Text('${project.hours}h')
          ],
        ),
      ),
    );
  }
}
