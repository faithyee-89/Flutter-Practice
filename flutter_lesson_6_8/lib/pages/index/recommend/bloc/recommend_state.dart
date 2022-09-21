part of 'recommend_bloc.dart';

class RecommendState extends Equatable {
  final List<PageModule>? modules;
  final List<AdBanner>? banners;
  const RecommendState({
    this.modules,
    this.banners,
  }) : super();

  RecommendState copyWith({
    List<PageModule>? modules,
    List<AdBanner>? banners,
  }) {
    return RecommendState(
      modules: modules ?? this.modules,
      banners: banners ?? this.banners,
    );
  }

  @override
  List<Object> get props => [modules ?? "", banners ?? ""];
}
