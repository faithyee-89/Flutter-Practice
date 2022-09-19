part of 'recommend_bloc.dart';

abstract class RecommendEvent extends Equatable {
  const RecommendEvent();

  @override
  List<Object> get props => [];
}

class RecommendEventLoadData extends RecommendEvent {
  const RecommendEventLoadData();
}
