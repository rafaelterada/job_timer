import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:job_timer/app/view_models/project_view_model.dart';

class ProjectPieChart extends StatelessWidget {
  final ProjectViewModel projectModel;
  const ProjectPieChart({super.key, required this.projectModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalTasksDuration = projectModel.tasks.fold<int>(
      0,
      (totalValue, task) => totalValue += task.duration,
    );
    final durationLeft = projectModel.hours - totalTasksDuration;

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.loose,
        children: [
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: totalTasksDuration.toDouble(),
                  color: theme.primaryColor,
                  showTitle: true,
                  title: '${totalTasksDuration}h',
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  value: durationLeft.toDouble(),
                  color: theme.primaryColorLight,
                  showTitle: true,
                  title: '${durationLeft}h',
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            swapAnimationDuration: const Duration(seconds: 1), // Optional
            swapAnimationCurve: Curves.linearToEaseOut, // Optional
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${projectModel.hours}h',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  color: theme.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
