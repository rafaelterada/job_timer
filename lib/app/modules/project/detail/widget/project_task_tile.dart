import 'package:flutter/material.dart';
import 'package:job_timer/app/view_models/project_task_view_model.dart';

class ProjectTaskTile extends StatelessWidget {
  final ProjectTaskViewModel task;
  const ProjectTaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(task.name),
            const Spacer(),
            const Text(
              'Duration:',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '${task.duration}h',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
