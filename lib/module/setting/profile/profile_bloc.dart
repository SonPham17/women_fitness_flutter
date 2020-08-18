import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/module/report/report_bloc.dart';
import 'package:women_fitness_flutter/module/report/report_events.dart';
import 'package:women_fitness_flutter/module/setting/profile/profile_events.dart';
import 'package:women_fitness_flutter/module/setting/profile/profile_states.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ReportBloc _reportBloc;

  ProfileBloc({@required ReportBloc reportBloc})
      : _reportBloc = reportBloc,
        super(ProfileStateInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent profileEvent) async* {
    switch (profileEvent.runtimeType) {
      case ProfileRefreshEvent:
        ProfileRefreshEvent refreshEvent = profileEvent as ProfileRefreshEvent;
        _reportBloc.add(ReportRefreshEvent(
          height: refreshEvent.height,
          weight: refreshEvent.weight,
          isKg: refreshEvent.isKg,
        ));
        break;
    }
  }
}
