import 'package:flutter_bloc/flutter_bloc.dart';

import './auth_event.dart';
import './auth_state.dart';
import '../../repositories/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepo;

  AuthBloc(this.userRepo) : assert(userRepo != null);

  @override
  AuthState get initialState => UnInitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
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

  Stream<AuthState> _mapUnInitedToState() async* {
    final isSignedIn = await userRepo.isSignedIn();
    if (isSignedIn) {
      final user = await userRepo.loadUserInfo();
      yield OAuthed(user.name);
    } 
    else {
      yield UnOAuthed(userRepo);
    }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    final user = await userRepo.loadUserInfo();
    yield OAuthed(user.name);
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield UnOAuthed(userRepo);
    userRepo.signOut(null);
  }
}
