import 'package:firebase_core/firebase_core.dart';
import 'package:genie_luck/firebase/dev/firebase_options.dart' as dev;
import 'package:genie_luck/firebase/prd/firebase_options.dart' as prod;
import 'package:genie_luck/firebase/stg/firebase_options.dart' as stg;

enum Flavor { dev, stg, prod }

class F {
  static late final Flavor appFlavor;

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://genie-luck-backend.onrender.com';
      case Flavor.stg:
        return 'ajustar';
      case Flavor.prod:
        return 'ajustar';
    }
  }

  static FirebaseOptions get firebaseConfigOptions {
    switch (appFlavor) {
      case Flavor.dev:
        return dev.DefaultFirebaseOptions.currentPlatform;
      case Flavor.prod:
        return prod.DefaultFirebaseOptions.currentPlatform;
      case Flavor.stg:
        return stg.DefaultFirebaseOptions.currentPlatform;
    }
  }
}
