import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_timer/app/core/ui/asuka_snack_bar.dart';
import 'package:job_timer/app/modules/home/controller/home_controller.dart';
import 'package:job_timer/app/modules/home/widgets/header_projects_menu.dart';
import 'package:job_timer/app/modules/home/widgets/project_tile.dart';
import 'package:job_timer/app/view_models/project_view_model.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;
  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      bloc: controller,
      listener: (context, state) {
        if (state.status == HomeStatus.error) {
          AsukaSnackbar.warning('An error occurred while loading projects')
              .show();
        }
      },
      child: Scaffold(
        drawer: Drawer(
          child: SafeArea(
              child: InkWell(
            onTap: () {
              GoogleSignIn().signOut();
              FirebaseAuth.instance.signOut();
            },
            child: const ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('LogOut'),
            ),
          )),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Projects'),
                expandedHeight: 100,
                toolbarHeight: 100,
                centerTitle: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                )),
              ),
              SliverPersistentHeader(
                delegate: HeaderProjectsMenu(controller: controller),
                pinned: true,
              ),
              BlocSelector<HomeController, HomeState, bool>(
                bloc: controller,
                selector: (state) {
                  return state.status == HomeStatus.loading;
                },
                builder: (context, showLoading) {
                  return SliverVisibility(
                    visible: showLoading,
                    sliver: const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    ),
                  );
                },
              ),
              BlocSelector<HomeController, HomeState, List<ProjectViewModel>>(
                bloc: controller,
                selector: (state) => state.projects,
                builder: (context, projects) {
                  return SliverList(
                      delegate: SliverChildListDelegate(
                    projects
                        .map(
                          (project) => ProjectTile(project: project),
                        )
                        .toList(),
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
