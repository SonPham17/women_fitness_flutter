import 'package:kiwi/kiwi.dart';
import 'package:women_fitness_flutter/data/repo/training_repo.dart';
import 'package:women_fitness_flutter/data/repo/workout_repo.dart';
import 'package:women_fitness_flutter/db/work_out_provider.dart';
import 'package:women_fitness_flutter/module/home/home_bloc.dart';
import 'package:women_fitness_flutter/module/report/report_bloc.dart';
import 'package:women_fitness_flutter/module/run/finish/run_finish_bloc.dart';
import 'package:women_fitness_flutter/module/setting/profile/profile_bloc.dart';
import 'package:women_fitness_flutter/module/splash/splash_bloc.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_bloc.dart';
import 'package:women_fitness_flutter/module/training/training_bloc.dart';
import 'package:women_fitness_flutter/module/workout/home/workout_home_bloc.dart';
import 'package:women_fitness_flutter/module/workout/routines/workout_routines_bloc.dart';
import 'package:women_fitness_flutter/module/workout/workout_bloc.dart';

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
  @Register.singleton(WorkOutHomeBloc)
  @Register.singleton(WorkOutRoutinesBloc)
  @Register.singleton(HomeBloc)
  @Register.factory(WorkOutBloc)
  @Register.factory(ProfileBloc)
  @Register.factory(RunFinishBloc)
  @Register.singleton(ReportBloc)
  @Register.factory(FavoriteTrainingBloc)
  @Register.factory(SplashBloc)
  @Register.singleton(TrainingBloc)
  void _configureBlocs();

  // ============REPO==============
  @Register.singleton(WorkOutRepo)
  @Register.singleton(TrainingRepo)
  void _configureRepo();

  // ============PROVIDER==============
  @Register.factory(WorkOutProvider)
  void _configureProvider();
}
