import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/login/login_bloc.dart';
import '../../blocs/oauth/oauth_bloc.dart';
import '../../blocs/oauth/oauth_event.dart';
import '../../blocs/oauth/oauth_state.dart';

import './login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Login')),
      body: BlocBuilder<OAuthBloc, OAuthState>(
        builder: (_, state) {
          if (state is UnOAuthed) {
            return BlocProvider<LoginBloc>(
              create: (_) => LoginBloc(userRepo: state.userRepo),
              child: LoginForm(userRepo: state.userRepo),
            );
          }
          return Container();
        },        
      ),
    );
  }
}