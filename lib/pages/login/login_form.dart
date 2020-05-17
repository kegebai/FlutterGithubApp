import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/router.dart';
import '../../blocs/oauth/oauth_bloc.dart';
import '../../blocs/oauth/oauth_event.dart';
import '../../blocs/login/login_bloc.dart';
import '../../blocs/login/login_event.dart';
import '../../blocs/login/login_state.dart';
import '../../repositories/itf/user_repository.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepos;

  LoginForm({this.userRepos});

  @override
  _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _pwdController = new TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get userRepos => widget.userRepos;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _pwdController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();

    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _pwdController.addListener(_onPwdChanged);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Center(
        child: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.isFailure) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Login Failure'),
                        Icon(Icons.error),
                      ],
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ));
              }
              if (state.isSubmitting) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Logging In ...'),
                        ],
                      ),
                      // backgroundColor: ,
                    ),
                  );
              }
              if (state.isSuccess) {
                BlocProvider.of<OAuthBloc>(context).add(LoggedIn());
                Navigator.of(context).pushReplacementNamed(Router.module_scaffold);
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Image.asset('assets/images/Octocat.png',
                                height: 200),
                          ),
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autovalidate: true,
                          autocorrect: false,
                          validator: (_) {
                            return !state.isEmailValid ? 'Invalid Email' : null;
                          },
                        ),
                        TextFormField(
                          controller: _pwdController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          autovalidate: true,
                          autocorrect: false,
                          validator: (_) {
                            return !state.isPwdValid ? 'Invalid Password' : null;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              LoginButton(
                                onPressed: isLoginButtonEnabled(state)
                                    ? _onFormSubmitted
                                    : null,
                              ),
                              // GoogleLoginButton(),
                              // CreateAccountButton(userRepos: userRepos),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  void _onEmailChanged() => _loginBloc.add(EmailChanged(_emailController.text));

  void _onPwdChanged() => _loginBloc.add(PwdChanged(_pwdController.text));

  void _onFormSubmitted() {
    _loginBloc.add(
      LogIn(
        context,
        email: _emailController.text,
        pwd: _pwdController.text,
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  LoginButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: onPressed,
      child: Text('Login'),
    );
  }
}
