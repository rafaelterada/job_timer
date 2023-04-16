part of 'project_register_controller.dart';

enum ProjectRegisterStatus {
  initial,
  loading,
  success,
  error,
}

class ProjectRegisterState extends Equatable {
  final ProjectRegisterStatus status;
  final String? errorMessage;

  const ProjectRegisterState({
    required this.status,
    this.errorMessage,
  });

  const ProjectRegisterState.initial() : this(status: ProjectRegisterStatus.initial);


  @override
  List<Object?> get props => [status, errorMessage];

  ProjectRegisterState copyWith({
    ProjectRegisterStatus? status,
    String? errorMessage,
  }) {
    return ProjectRegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
