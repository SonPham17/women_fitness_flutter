import 'package:women_fitness_flutter/db/work_out_provider.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';

class WorkOutRepo {
  WorkOutProvider _workOutProvider;

  WorkOutRepo({WorkOutProvider workOutProvider})
      : _workOutProvider = workOutProvider;

  Future<List<WorkOut>> getDataMainWorkOut() async{
    return await _workOutProvider.getAllWorkOut();
  }

  Future<List<Section>> getDataMainSection() async{
    return await _workOutProvider.getAllSection();
  }
}
