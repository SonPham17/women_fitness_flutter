abstract class ProfileEvent {}

class ProfileRefreshEvent extends ProfileEvent {
  double weight;
  double height;
  bool isKg;

  ProfileRefreshEvent({this.isKg, this.weight, this.height});
}
