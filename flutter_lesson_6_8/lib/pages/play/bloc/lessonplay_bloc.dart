import 'package:bloc/bloc.dart';
import 'package:cainiaowo/models/chapter.dart';
import 'package:cainiaowo/models/course.dart';
import 'package:cainiaowo/models/video_play_info.dart';
import 'package:equatable/equatable.dart';

part 'lessonplay_event.dart';
part 'lessonplay_state.dart';

class LessonPlayBloc extends Bloc<LessonPlayEvent, LessonPlayState> {
  LessonPlayBloc() : super(LessonPlayState());
}
