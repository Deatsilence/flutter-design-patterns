import 'dart:developer';

final class Singleton {
  // privatesied constructor
  Singleton._init() {
    log("Singleton Private constructor ran");
  }

  // instance of this class
  static Singleton? _instance;

  static Singleton get instance => _instance ??= Singleton._init();
}

final class SingletonWithFactory {
  // privatesied constructor
  SingletonWithFactory._init() {
    log("SingletonWithFactory Private constructor ran");
  }

  static SingletonWithFactory? _instance;

  factory SingletonWithFactory() => _instance ??= SingletonWithFactory._init();
}
