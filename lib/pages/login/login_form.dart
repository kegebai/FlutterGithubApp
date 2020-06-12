import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_app/widgets/toast.dart';

import '../../app/router.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/login/login_bloc.dart';
import '../../blocs/login/login_event.dart';
import '../../blocs/login/login_state.dart';
import '../../repositories/user_repository.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepo;

  LoginForm({this.userRepo});

  @override
  _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get userRepos => widget.userRepo;

  bool get isPopulated =>
      _usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();

    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _usernameController.addListener(_onUsernameChanged);
    _passwordController.addListener(_onPasswordChanged);
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
                Toast.show(context, 'Login Failure');
              }
              if (state.isSubmitting) {
                Toast.show(context, 'Loading In ...');
              }
              if (state.isSuccess) {
                BlocProvider.of<AuthBloc>(context).add(LoggedIn());
                Navigator.of(context).pushReplacementNamed(Router.app_scaffold);
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
                            child: Image.asset('assets/images/Octocat.png', height: 200),
                          ),
                        ),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            labelText: 'Username',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autovalidate: true,
                          autocorrect: false,
                          validator: (_) {
                            return !state.isUsernameValid ? 'Invalid Username' : null;
                          },
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          autovalidate: true,
                          autocorrect: false,
                          validator: (_) {
                            return !state.isPasswordValid ? 'Invalid Password' : null;
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
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onUsernameChanged() => _loginBloc.add(UsernameChanged(_usernameController.text));

  void _onPasswordChanged() => _loginBloc.add(PasswordChanged(_passwordController.text));

  void _onFormSubmitted() {
    _loginBloc.add(
      LogIn(
        context,
        username: _usernameController.text,
        password: _passwordController.text,
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
