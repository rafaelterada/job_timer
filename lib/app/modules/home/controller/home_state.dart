part of 'home_controller.dart';

enum HomeStatus {
  initial,
  loading,
  complete,
  error,
}

class HomeState extends Equatable {
  final List<ProjectViewModel> projects;
  final HomeStatus status;
  final ProjectStatus filterStatus;

  const HomeState._({
    required this.projects,
    required this.status,
    required this.filterStatus,
  });

  HomeState.initial()
      : this._(
          projects: [],
          status: HomeStatus.initial,
          filterStatus: ProjectStatus.inProgress,
        );

  @override
  List<Object?> get props => [projects, status, filterStatus];

  HomeState copyWith({
    List<ProjectViewModel>? projects,
    HomeStatus? status,
    ProjectStatus? filterStatus,
  }) {
    return HomeState._(
      projects: projects ?? this.projects,
      status: status ?? this.status,
      filterStatus: filterStatus ?? this.filterStatus,
    );
  }
}
