import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:washpro/singletons.dart';

import 'business_logic/app_bloc_observer.dart';
import 'logger.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    logger.e(details.summary,
        error: details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await setupSingletons();

      Bloc.observer = AppBlocObserver();
      runApp(await builder());
    },
    (error, stackTrace) =>
        logger.e('Exception', error: error, stackTrace: stackTrace),
  );
}
