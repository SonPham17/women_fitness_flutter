import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/module/report/report_events.dart';
import 'package:women_fitness_flutter/module/report/report_states.dart';
import 'package:women_fitness_flutter/shared/utils.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportStateInitial());

  @override
  Stream<ReportState> mapEventToState(ReportEvent reportEvent) async* {
    switch (reportEvent.runtimeType) {
      case ReportSaveEmptyEvent:
        yield ReportStateSaveEmpty();
        break;
      case ReportRefreshEvent:
        ReportRefreshEvent refreshEvent = reportEvent as ReportRefreshEvent;
        double height = refreshEvent.height;
        double weight = refreshEvent.weight;
        yield ReportStateRefresh(
          height: height,
          weight: weight,
        );
        break;
    }
  }
}
