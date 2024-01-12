import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import 'package:project_setup/core/firebase/analytics/analytics.dart';

abstract class BaseConsumerState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> with WidgetsBindingObserver {
  Logger get log => Logger(T.toString());
  AppLocalizations get translation => AppLocalizations.of(context)!;

  @override
  void initState() {
    log.info("$T initState");
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(analyticsProvider).setCurrentScreen(screenName: T.toString());
  }

  @override
  void dispose() {
    log.info("$T dispose");
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
