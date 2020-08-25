import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/data/repo/workout_repo.dart';
import 'package:women_fitness_flutter/module/report/report_bloc.dart';
import 'package:women_fitness_flutter/module/report/report_events.dart';
import 'package:women_fitness_flutter/module/run/finish/run_finish_events.dart';
import 'package:women_fitness_flutter/module/run/finish/run_finish_states.dart';

class RunFinishBloc extends Bloc<RunFinishEvent, RunFinishState> {
  ReportBloc _reportBloc;
  WorkOutRepo _workOutRepo;

  RunFinishBloc(
      {@required ReportBloc reportBloc, @required WorkOutRepo workOutRepo})
      : _reportBloc = reportBloc,
        _workOutRepo = workOutRepo,
        super(RunFinishStateInitial());

  @override
  Stream<RunFinishState> mapEventToState(RunFinishEvent runFinishEvent) async* {
    switch (runFinishEvent.runtimeType) {
      case RunFinishRefreshEvent:
        RunFinishRefreshEvent runFinishRefreshEvent =
            runFinishEvent as RunFinishRefreshEvent;
        _reportBloc.add(ReportRefreshEvent(
          height: runFinishRefreshEvent.height,
          weight: runFinishRefreshEvent.weight,
        ));
        break;
      case RunFinishGetAllSectionEvent:
        final dataMainSection = await _workOutRepo.getDataMainSection();
        yield RunFinishStateGetAllSectionDone(listSections: dataMainSection);
        break;
    }
  }
}
