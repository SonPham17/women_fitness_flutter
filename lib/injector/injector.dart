import 'package:kiwi/kiwi.dart';

abstract class Injector {
  static KiwiContainer container;

  static void setup() {
    container = KiwiContainer();
  }

  static final resolve = container.resolve;

  void _configure(){
    _configureBlocs();

  }
}
