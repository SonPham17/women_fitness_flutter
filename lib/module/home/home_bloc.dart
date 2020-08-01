import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/module/home/home_events.dart';
import 'package:women_fitness_flutter/module/home/home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeStateInitial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent homeEvent) async* {
    switch (homeEvent.runtimeType) {
      case HomeShowTabWorkOutEvent:
        yield HomeStateShowTabWorkOut();
        break;
    }
  }
}
