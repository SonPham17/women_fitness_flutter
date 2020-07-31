// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void _configureBlocs() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory(
        (c) => WorkOutHomeBloc(trainingBloc: c<TrainingBloc>()));
    container
        .registerFactory((c) => WorkOutBloc(workOutRepo: c<WorkOutRepo>()));
    container.registerFactory((c) => SplashBloc(workOutRepo: c<WorkOutRepo>()));
    container.registerSingleton(
        (c) => TrainingBloc(trainingRepo: c<TrainingRepo>()));
  }

  void _configureRepo() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton(
        (c) => WorkOutRepo(workOutProvider: c<WorkOutProvider>()));
    container.registerFactory((c) => TrainingRepo());
  }

  void _configureProvider() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => WorkOutProvider());
  }
}