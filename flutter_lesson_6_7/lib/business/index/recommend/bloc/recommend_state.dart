part of 'recommend_bloc.dart';

class RecommendState extends Equatable {
  final List<Module> modules;
  final List<AdBanner> banners;
  const RecommendState({
    this.modules = const [],
    this.banners = const [],
  }) : super();

  RecommendState copyWith({
    List<Module> modules,
    List<AdBanner> banners,
  }) {
    return RecommendState(
      modules: modules ?? this.modules,
      banners: banners ?? this.banners,
    );
  }

  @override
  List<Object> get props => [modules, banners];
}
