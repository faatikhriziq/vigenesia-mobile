import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:vigenesia/bloc/delete_motivation/delete_motivation_bloc.dart';
import 'package:vigenesia/bloc/get_all_motivation/get_all_motivation_bloc.dart';
import 'package:vigenesia/bloc/get_motivation_user/get_motivation_user_bloc.dart';
import 'package:vigenesia/bloc/motivation/motivation_bloc.dart';
import 'package:vigenesia/bloc/register/register_bloc.dart';
import 'package:vigenesia/data/datasource/local/auth_local_datasource.dart';
import 'package:vigenesia/data/datasource/remote/auth_datasource.dart';
import 'package:vigenesia/data/datasource/remote/motivation_datasource.dart';
import 'package:vigenesia/page/home_page.dart';
import 'package:vigenesia/page/login_page.dart';
import 'package:vigenesia/page/welcome_page.dart';

import 'bloc/login/login_bloc.dart';
import 'page/register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterBloc(AuthDatasource())),
        BlocProvider(create: (context) => LoginBloc(AuthDatasource())),
        BlocProvider(create: (context) => MotivationBloc(MotivationDatasource())),
        BlocProvider(create: (context) => GetAllMotivationBloc(MotivationDatasource())),
        BlocProvider(create: (context) => GetMotivationUserBloc(MotivationDatasource(), AuthLocalDatasource())),
        BlocProvider(create: (context) => DeleteMotivationBloc(MotivationDatasource())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Vigenesia',
        routerConfig: GoRouter(
          initialLocation: HomePage.routeName,
          routes: [
            GoRoute(
              path: WelcomePage.routeName,
              builder: (context, state) => const WelcomePage(),
              redirect: (context, state) async {
                final isEverLaunched = await AuthLocalDatasource().getEverLaunched();
                if (isEverLaunched) {
                  return LoginPage.routeName;
                } else {
                  return null;
                }
              },
            ),
            GoRoute(
              path: LoginPage.routeName,
              builder: (context, state) => const LoginPage(),
            ),
            GoRoute(
              path: RegisterPage.routeName,
              builder: (context, state) => const RegisterPage(),
            ),
            GoRoute(
              path: HomePage.routeName,
              builder: (context, state) => const HomePage(),
              redirect: (context, state) async {
                final isLogin = await AuthLocalDatasource().isLogin();
                if (isLogin) {
                  return null;
                } else {
                  return WelcomePage.routeName;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
