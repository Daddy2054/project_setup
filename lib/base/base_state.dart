import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  Logger get log => Logger(T.toString());
  AppLocalizations get translation => AppLocalizations.of(context)!;

  @override
  void initState() {
    log.info("$T initState");
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    log.info("$T dispose");
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
