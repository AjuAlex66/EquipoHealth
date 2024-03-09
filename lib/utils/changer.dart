import 'package:flutter/foundation.dart';

class Changer extends ChangeNotifier {
  void justChange() => notifyListeners();
}
