
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'app_module.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => $initGetIt(getIt);

