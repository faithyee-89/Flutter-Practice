part of 'studycenter_bloc.dart';

abstract class StudycenterEvent extends Equatable {
  const StudycenterEvent();

  @override
  List<Object> get props => [];
}

class StudycenterEventLoadStudyInfo extends StudycenterEvent {
  const StudycenterEventLoadStudyInfo();
}


class StudycenterEventLoadStudiedCourses extends StudycenterEvent {
  const StudycenterEventLoadStudiedCourses({this.params});
  final Map params;
}

class StudycenterEventLoadBoughtCourses extends StudycenterEvent {
  const StudycenterEventLoadBoughtCourses({this.params});
  final Map params;
}

