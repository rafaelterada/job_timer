import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/asuka_snack_bar.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/task/controller/task_controller.dart';
import 'package:validatorless/validatorless.dart';

class TaskPage extends StatefulWidget {
  final TaskController controller;
  const TaskPage({super.key, required this.controller});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _durationEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameEC.dispose();
    _durationEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskController, TaskStatus>(
      bloc: widget.controller,
      listener: (context, status) {
        if (status == TaskStatus.success) {
          Navigator.pop(context);
        } else if (status == TaskStatus.error) {
          AsukaSnackbar.warning('Error while trying to add new task').show();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Create New Task'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(label: Text('Task name')),
                  validator: Validatorless.required('Task name is required!'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _durationEC,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(label: Text('Task duration')),
                  validator: Validatorless.multiple([
                    Validatorless.required('Duration is required!'),
                    Validatorless.number('Only numbers allowed!')
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ButtonWithLoader<TaskController, TaskStatus>(
                    bloc: widget.controller,
                    selector: (status) {
                      return status == TaskStatus.loading;
                    },
                    onPressed: () {
                      final valid = _formKey.currentState?.validate() ?? false;
                      if (valid) {
                        final name = _nameEC.text;
                        final duration = int.parse(_durationEC.text);
                        widget.controller.save(name, duration);
                      }
                    },
                    label: 'Save',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
