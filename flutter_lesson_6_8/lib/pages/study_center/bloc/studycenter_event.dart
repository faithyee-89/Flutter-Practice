part of 'studycenter_bloc.dart';

abstract class StudycenterEvent extends Equatable {
  const StudycenterEvent();

  @override
  List<Object> get props => [];
}

class GetStudyInfoEvent extends StudycenterEvent {
  const GetStudyInfoEvent();
}

class GetStudiedCoursesEvent extends StudycenterEvent {
  const GetStudiedCoursesEvent({required this.params});
  final Map<String, dynamic> params;
}

class GetBoughtCoursesEvent extends StudycenterEvent {
  const GetBoughtCoursesEvent({required this.params});
  final Map<String, dynamic> params;
}
