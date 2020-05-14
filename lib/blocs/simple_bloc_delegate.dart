import 'package:bloc/bloc.dart';

import '../app/dlog.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    Dlog.log('onEvent $event');
    super.onEvent(bloc, event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    Dlog.log('onTransition $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    Dlog.log('onError $error, stackTrace: $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}