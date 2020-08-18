abstract class ReportEvent {}

class ReportSaveEmptyEvent extends ReportEvent {}

class ReportRefreshEvent extends ReportEvent {
  double weight;
  double height;
  bool isKg;

  ReportRefreshEvent({this.weight, this.height,this.isKg});
}
