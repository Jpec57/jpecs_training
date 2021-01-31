import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/login/bloc/login_bloc.dart';
import 'package:jpec_training/login/view/login_form.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        elevation: 6.0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.1,
                    0.6
                  ],
                  colors: [
                    AppColors.charlestonGreen,
                    AppColors.greenArtichokeDarker,
                  ]),
              color: AppColors.richBlack),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: _LogoContainer(),
                  ),
                  BlocProvider(
                    create: (context) {
                      return LoginBloc(
                        authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(
                                context),
                      );
                    },
                    child: LoginForm(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoContainer extends StatefulWidget {
  @override
  __LogoContainerState createState() => __LogoContainerState();
}

class __LogoContainerState extends State<_LogoContainer> {
  double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: null,
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Image.asset(
          'images/jpec_logo.png',
          height: 90,
        ),
      ),
    );
  }
}
