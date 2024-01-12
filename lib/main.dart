import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:project_setup/common/logging/logging_provider.dart';
import 'package:project_setup/core/firebase/analytics/analytics.dart';
import 'package:project_setup/core/firebase/crashlytics/crashlytics.dart';
import 'package:project_setup/core/firebase/firebase_options.dev.dart';
import 'package:project_setup/core/flavor/flavor.dart';
import 'package:project_setup/core/local/db/hive_db.dart';
import 'package:project_setup/core/providers/flavor_provider.dart';
import 'package:project_setup/core/providers/internet_connection_observer.dart';
import 'package:project_setup/main_widget.dart';

void mainApp(Flavor flavor) async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // An object that stores the state of the providers and allows overriding the behavior of a specific provider.
      final container = ProviderContainer();

      // Set the flavor state
      container.read(flavorProvider.notifier).state = flavor;
      // ignore: prefer_typing_uninitialized_variables
      // final firebaseOptions = container.read(firebaseOptionsProvider(flavor));

      // var  firebaseOptions;
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Pass all uncaught errors from the framework to Crashlytics.
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      // Enables/disables automatic data collection by Crashlytics.
      container.read(crashlyticsProvider);

      // Initialize firebase analytics
      final analytics = container.read(analyticsProvider);
      await analytics.logAppOpen();

      // Setup Logger
      container.read(setupLoggingProvider);

      // setup the hive database
      final db = container.read(hiveDbProvider);
      await db.init();

      // Observer internet connection
      container.read(internetConnectionObserverProvider);

      runApp(
        // Expose a [ProviderContainer] to the widget tree.
        UncontrolledProviderScope(
          container: container,
          child: const MainWidget(),
        ),
      );
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}
