import 'package:flutter_bloc/flutter_bloc.dart';

import './oauth_event.dart';
import './oauth_state.dart';
import '../../repositories/itf/user_repository.dart';

class OAuthBloc extends Bloc<OAuthEvent, OAuthState> {
  final UserRepository userRepos;

  OAuthBloc(this.userRepos) : assert(userRepos != null);

  @override
  OAuthState get initialState => Uninitialized();

  @override
  Stream<OAuthState> mapEventToState(OAuthEvent event) async* {
    if (event is Uninited) {
      yield* _mapAppStartedToState();
    }
    else if (event is LoggedInStarted) {
      yield* _mapLoggedInStartedToState();
    }
    else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    }  
    else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<OAuthState> _mapAppStartedToState() async* {
    final isSignedIn = await userRepos.isSignedIn();
    if (isSignedIn) {
      final user = await userRepos.getLocalUserInfo();
      yield OAuthed(user.name);
    } 
    else {
      yield UnOAuthed(userRepos);
    }
  }

  Stream<OAuthState> _mapLoggedInStartedToState() async* {
    yield UnOAuthed(userRepos);
  }

  Stream<OAuthState> _mapLoggedInToState() async* {
    final user = await userRepos.getLocalUserInfo();
    yield OAuthed(user.name);
  }

  Stream<OAuthState> _mapLoggedOutToState() async* {
    yield UnOAuthed(userRepos);
    userRepos.signOut(null);
  }
}
