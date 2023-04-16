import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/asuka_snack_bar.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/register/controller/project_register_controller.dart';
import 'package:validatorless/validatorless.dart';

class ProjectRegisterPage extends StatefulWidget {
  final ProjectRegisterController controller;
  const ProjectRegisterPage({super.key, required this.controller});

  @override
  State<ProjectRegisterPage> createState() => _ProjectRegisterPageState();
}

class _ProjectRegisterPageState extends State<ProjectRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _hoursEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameEC.dispose();
    _hoursEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectRegisterController, ProjectRegisterState>(
      bloc: widget.controller,
      listener: (context, state) {
        switch (state.status) {
          case ProjectRegisterStatus.error:
            AsukaSnackbar.alert(state.errorMessage!).show();
            break;
          case ProjectRegisterStatus.success:
            Navigator.of(context).pop();
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Create New Project',
          ),
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
                  decoration:
                      const InputDecoration(label: Text('Project name')),
                  validator: Validatorless.required('Name is required!'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _hoursEC,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(label: Text('Estimated hours')),
                  validator: Validatorless.multiple([
                    Validatorless.required('Estimated hours is required!'),
                    Validatorless.number('Only numbers allowed!')
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ButtonWithLoader<ProjectRegisterController,
                      ProjectRegisterState>(
                    bloc: widget.controller,
                    selector: (state) {
                      var status = widget.controller.state.status;

                      return status == ProjectRegisterStatus.loading;
                    },
                    onPressed: () {
                      final valid = _formKey.currentState?.validate() ?? false;
                      if (valid) {
                        final name = _nameEC.text;
                        final hours = int.parse(_hoursEC.text);
                        widget.controller.register(name, hours);
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
