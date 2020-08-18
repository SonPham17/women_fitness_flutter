abstract class ReportState {}

class ReportStateInitial extends ReportState {}

class ReportStateSaveEmpty extends ReportState {}

class ReportStateRefresh extends ReportState {
  double height;
  double weight;
  bool isKg;

  ReportStateRefresh({this.height, this.weight, this.isKg});
}
