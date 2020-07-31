import 'package:women_fitness_flutter/shared/model/section.dart';

class TrainingRepo {
  Future<List<Section>> getListSectionFavorite(List<Section> lists) async {
    return lists.where((section) => section.isLiked).toList();
  }
}
