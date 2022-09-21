part of 'lessonplay_bloc.dart';

abstract class LessonPlayEvent extends Equatable {
  const LessonPlayEvent();

  @override
  List<Object> get props => [];
}

class LessonPlayEventChangeLesson extends LessonPlayEvent {
  const LessonPlayEventChangeLesson(this.lessonKey);

  final String lessonKey;
}
