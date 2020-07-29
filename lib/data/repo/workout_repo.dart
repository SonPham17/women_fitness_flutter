import 'package:women_fitness_flutter/db/work_out_provider.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';

class WorkOutRepo {
  WorkOutProvider _workOutProvider;

  WorkOutRepo({WorkOutProvider workOutProvider})
      : _workOutProvider = workOutProvider;

  Future<List<Section>> getDataMainWorkOut() async{
    return await _workOutProvider.getAllSection();
  }
}
