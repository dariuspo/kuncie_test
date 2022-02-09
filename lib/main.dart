import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncie_test/app/app_bloc_observer.dart';
import 'package:kuncie_test/app/app_logger.dart';
import 'package:kuncie_test/repositories/song_repository.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    logger.d(details.exceptionAsString());
    logger.d(details.stack.toString());
  };

  final songRepository = SongRepository();

  runZonedGuarded(
    () => runApp(
      App(
        songRepository: songRepository,
      ),
    ),
    (error, stackTrace) {
      logger.d(error.toString());
      logger.d(stackTrace.toString());
    },
  );
}
