import 'package:vibration/vibration.dart';

class FeatureVibration {
  static success() async {
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(pattern: [20, 20, 20, 20]);
    }
  }
  static feedback() async {
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(pattern: [20, 20, 20, 20]);
    }
  }
  static invalid() async {
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(pattern: [50, 80, 50, 80]);
    }
  }
}
