
abstract class SplashEvent {
}

class SplashGetDataEvent extends SplashEvent {
  final bool first;

  SplashGetDataEvent({this.first = false});
}
