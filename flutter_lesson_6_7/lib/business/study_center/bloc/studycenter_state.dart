part of 'studycenter_bloc.dart';

class StudycenterState extends Equatable {
  const StudycenterState({
    this.studyInfo = const StudyInfo(),
    this.studiedCourses,
    this.boughtCourses,
    this.noMoreForStudied,
    this.noMoreForBought,
  });

  final StudyInfo studyInfo;
  final List<Course> studiedCourses;
  final List<BoughtCourse> boughtCourses;
  final bool noMoreForStudied;
  final bool noMoreForBought;

  StudycenterState copyWith({
    StudyInfo studyInfo,
    List<Course> studiedCourses,
    List<BoughtCourse> boughtCourses,
    bool noMoreForStudied,
    bool noMoreForBought,
  }) {
    return StudycenterState(
      studyInfo: studyInfo ?? this.studyInfo,
      studiedCourses: studiedCourses ?? this.studiedCourses,
      boughtCourses: boughtCourses ?? this.boughtCourses,
      noMoreForBought: noMoreForBought ?? this.noMoreForBought,
      noMoreForStudied: noMoreForStudied ?? this.noMoreForStudied,
    );
  }

  @override
  List<Object> get props => [studyInfo, studiedCourses, boughtCourses, noMoreForBought, noMoreForStudied];
}
