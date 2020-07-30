import 'package:kiwi/kiwi.dart';
import 'package:women_fitness_flutter/data/repo/workout_repo.dart';
import 'package:women_fitness_flutter/db/work_out_provider.dart';
import 'package:women_fitness_flutter/module/workout/home/workout_home_bloc.dart';

part 'injector.g.dart';

abstract class Injector {
  static KiwiContainer container;

  static void setup() {
    container = KiwiContainer();
    _$Injector()._configure();
  }

  static final resolve = container.resolve;

  void _configure() {
    _configureBlocs();
    _configureRepo();
    _configureProvider();
  }

  // ============BLOCS==============
  @Register.factory(WorkOutHomeBloc)
  void _configureBlocs();

  // ============REPO==============
  @Register.factory(WorkOutRepo)
  void _configureRepo();

  // ============PROVIDER==============
  @Register.factory(WorkOutProvider)
  void _configureProvider();
}
