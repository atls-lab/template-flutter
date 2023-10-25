// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../features/auth/auth.dart';
import '../../router/router.dart';
import '../../shared/shared.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AppLoginFlow loginFlow = AppLoginFlow();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result = await loginFlow.initHandlersLoginScreen();
      showNotification(result.$1, result.$2, context);
    });
  }

  @override
  void dispose() {
    loginFlow.cancelToken.cancel();
    emailController.dispose();
    passwordController.dispose();
    loginFlow.clearAll();
    super.dispose();
  }

  void onPressHandler() async {
    final result = await loginFlow.loginHandler(
      password: passwordController.text,
      email: emailController.text,
    );
    showNotification(result.$1, result.$2, context);
    pushByType(result.$1, const IndexScreenRoute());
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations intl = AppLocalizations.of(context)!;

    return Column(
      children: [
        Text(
          intl.loginTitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 24),
          child: Input(
            props: InputProps(
              width: double.infinity,
              label: intl.email,
              controller: emailController,
              type: TextInputType.emailAddress,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Input(
            props: InputProps(
              width: double.infinity,
              label: intl.password,
              type: TextInputType.visiblePassword,
              controller: passwordController,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Button(
            props: ButtonProps(
              text: intl.logIn,
              fill: true,
              onPressed: onPressHandler,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: HorizontalLineText(
                props:
                    HorizontalLineTextProps(text: intl.identityRegisterNew))),
        Button(
          props: ButtonProps(
              text: intl.signUp,
              variant: ButtonVariant.secondary,
              fill: true,
              onPressed: () => GetIt.I<AppRouter>()
                  .replaceAll([const RegistrationScreenRoute()])),
        )
      ],
    );
  }
}
