import 'package:firebase_core/firebase_core.dart';

import 'package:payroll_system/src/utils/firebase_options.dart';

/// A class that handles dependency injection for the payroll system.
class DependencyInjection {
  /// The singleton instance of the [DependencyInjection] class.
  static final DependencyInjection _singleton = DependencyInjection._internal();

  /// Returns the singleton instance of the [DependencyInjection] class.
  factory DependencyInjection() {
    return _singleton;
  }

  /// Creates a new instance of the [DependencyInjection] class.
  DependencyInjection._internal();

  /// Initializes Firebase for the payroll system.
  ///
  /// This method initializes Firebase using the default Firebase options
  /// for the current platform.
  Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
