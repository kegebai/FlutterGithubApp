import 'package:flutter_bloc/flutter_bloc.dart';

import './oauth_event.dart';
import './oauth_state.dart';
import '../../repositories/itf/user_repository.dart';

class OAuthBloc extends Bloc<OAuthEvent, OAuthState> {
  final UserRepository userRepo;

  OAuthBloc(this.userRepo) : assert(userRepo != null);

  @override
  OAuthState get initialState => UnInitialized();

  @override
  Stream<OAuthState> mapEventToState(OAuthEvent event) async* {
    if (event is UnInited) {
      yield* _mapUnInitedToState();
    }
    else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    }  
    else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<OAuthState> _mapUnInitedToState() async* {
    final isSignedIn = await userRepo.isSignedIn();
    if (isSignedIn) {
      final user = await userRepo.getLocalUserInfo();
      yield OAuthed(user.name);
    } 
    else {
      yield UnOAuthed(userRepo);
    }
  }

  Stream<OAuthState> _mapLoggedInToState() async* {
    final user = await userRepo.getLocalUserInfo();
    yield OAuthed(user.name);
  }

  Stream<OAuthState> _mapLoggedOutToState() async* {
    yield UnOAuthed(userRepo);
    userRepo.signOut(null);
  }
}
