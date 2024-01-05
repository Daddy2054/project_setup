import 'package:project_setup/core/flavor/flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final flavorProvider = StateProvider<Flavor>((ref) {
  return Flavor.dev;
});
