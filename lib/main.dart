import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncie_test/app/app_bloc_observer.dart';
import 'package:kuncie_test/app/app_logger.dart';
import 'package:kuncie_test/repositories/song_repository.dart';
import 'app/app.dart';

void main() async {
  final songRepository = SongRepository();
  FlutterError.onError = (details) {
    logger.e(details.exceptionAsString());
    logger.e(details.stack.toString());
  };
  //catch error when the error is not caught by flutter
  runZonedGuarded(
    //watch bloc transition changed
    () => BlocOverrides.runZoned(
      () => runApp(
        App(
          songRepository: songRepository,
        ),
      ),
      blocObserver: AppBlocObserver(),
    ),
    (error, stackTrace) {
      logger.e(error.toString());
    },
  );
}
