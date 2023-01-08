import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/navigation/router_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation/root_router_delegate.dart';

class AppRoot extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  AppRoot({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => RouterCubit(),
        child: MaterialApp(home: _router),
      );

  Widget get _router => BlocBuilder<RouterCubit, RouterState>(
        builder: (context, state) => Router(
          routerDelegate: RootRouterDelegate(
            navigatorKey,
            context.read<RouterCubit>(),
          ),
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      );
}
