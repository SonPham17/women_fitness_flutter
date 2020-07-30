// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void _configureBlocs() {
    final KiwiContainer container = KiwiContainer();
    container
        .registerFactory((c) => WorkOutHomeBloc(workOutRepo: c<WorkOutRepo>()));
  }

  void _configureRepo() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory(
        (c) => WorkOutRepo(workOutProvider: c<WorkOutProvider>()));
  }

  void _configureProvider() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => WorkOutProvider());
  }
}
