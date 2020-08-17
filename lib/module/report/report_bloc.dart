import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/module/report/report_events.dart';
import 'package:women_fitness_flutter/module/report/report_states.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportStateInitial());

  @override
  Stream<ReportState> mapEventToState(ReportEvent reportEvent) async* {
    switch (reportEvent.runtimeType) {
      case ReportSaveEmptyEvent:
        yield ReportStateSaveEmpty();
        break;
      case ReportRefreshEvent:
        print('refresh report');
        yield ReportStateRefresh();
        break;
    }
  }
}
