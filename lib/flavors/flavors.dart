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
}
