part of 'recommend_bloc.dart';

abstract class RecommendEvent extends Equatable {
  const RecommendEvent();

  @override
  List<Object> get props => [];
}

class GetBannerEvent extends RecommendEvent {
  const GetBannerEvent();
}

class GetPageModuleEvent extends RecommendEvent {
  const GetPageModuleEvent();
}

class RecommendEventLoadData extends RecommendEvent {
  const RecommendEventLoadData();
}
