import 'package:flutter_bloc/flutter_bloc.dart';

import './global_event.dart';
import './global_state.dart';
import '../../storages/local_storage.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final LocalStorage storage;

  GlobalBloc(this.storage) : assert(storage != null);

  @override
  GlobalState get initialState => GlobalState(storage);

  @override
  Stream<GlobalState> mapEventToState(GlobalEvent event) async* {
    if (event is LoadApp) {
      yield await storage.initApp();
    } 
    else if (event is SwitchFontFamily) {
      yield* _mapSwitchFontFamilyToState(event);
    } 
    else if (event is SwitchThemeColor) {
      yield* _mapSwitchThemeColorToState(event);
    } 
    else if (event is SwitchLanguage) {
      yield* _mapSwitchLanguageToState(event);
    }
  }

  _mapSwitchFontFamilyToState(SwitchFontFamily event) async* {
    storage.setFontFamily(event.fontFamily);
    yield state.copyWith(storage.copyWith(fontFamily: event.fontFamily));
  }

  _mapSwitchThemeColorToState(SwitchThemeColor event) async* {
    storage.setThemeColor(event.color);
    yield state.copyWith(storage.copyWith(color: event.color));
  }

  _mapSwitchLanguageToState(SwitchLanguage event) async* {
    storage.setLanguage(event.language);
    yield state.copyWith(storage.copyWith(language: event.language));
  }
}
