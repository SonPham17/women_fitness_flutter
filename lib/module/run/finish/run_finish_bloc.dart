import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/data/repo/workout_repo.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/module/report/report_bloc.dart';
import 'package:women_fitness_flutter/module/report/report_events.dart';
import 'package:women_fitness_flutter/module/run/finish/run_finish_events.dart';
import 'package:women_fitness_flutter/module/run/finish/run_finish_states.dart';
import 'package:women_fitness_flutter/shared/utils.dart';

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
        RunFinishGetAllSectionEvent getAllSectionEvent =
            runFinishEvent as RunFinishGetAllSectionEvent;
        double weight = await SPref.instance.getDouble(Utils.sPrefWeight);
        bool isChooseKg = await SPref.instance.getBool(Utils.sPrefIsKgCm);
        if (!isChooseKg) {
          weight = Utils.convertLbsToKg(weight);
        }
        int totalTime = 0;
        double totalCalories = 0;
        getAllSectionEvent.listWorkOuts.forEach((workOut) {
          totalTime += workOut.timeDefault;
          if (workOut.type == 0) {
            totalCalories += (workOut.calories * workOut.timeDefault) * weight;
          } else {
            totalCalories += (workOut.calories * workOut.countDefault) * weight;
          }
        });
        final dataMainSection = await _workOutRepo.getDataMainSection();
        yield RunFinishStateGetAllSectionDone(
          listSections: dataMainSection,
          totalTime: totalTime + 60,
          totalCalories: totalCalories * 2,
        );
        break;
    }
  }
}
