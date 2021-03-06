import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kuncie_test/app/app_logger.dart';

/// To watch and debug bloc state
class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if(kDebugMode){
      logger.d('onTransition(${bloc.runtimeType}, $transition)');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if(kDebugMode){
      logger.e('onError(${bloc.runtimeType}, $error, $stackTrace)');
    }
    super.onError(bloc, error, stackTrace);
  }
}
