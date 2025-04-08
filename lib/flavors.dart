enum Flavor { dev, stg, prod }

class F {
  static late final Flavor appFlavor;

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'http://127.0.0.1:5050';
      case Flavor.stg:
        return 'https://672ba4801600dda5a9f5dcbf.mockapi.io/api/v1';
      case Flavor.prod:
        return 'https://672ba4801600dda5a9f5dcbf.mockapi.io/api/v1';
    }
  }
}
