import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/login/login_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';

import './login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Login')),
      body: BlocBuilder<AuthBloc, AuthState>(
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