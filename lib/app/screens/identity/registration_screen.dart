// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../features/auth/auth.dart';
import '../../router/router.dart';
import '../../shared/widgets/widgets.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  AppRegistrationFlow registrationFlow = AppRegistrationFlow();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isRenderPromo = false;

  @override
  void initState() {
    super.initState();

    passwordController.addListener(shouldPromoRender);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result = await registrationFlow.initHandlersRegistrationScreen();
      showNotification(result.$1, result.$2, context);
    });
  }

  void shouldPromoRender() {
    bool result = passwordController.text.length > 3;

    if (result) {
      setState(() {
        isRenderPromo = true;
      });
    }
  }

  @override
  void dispose() {
    registrationFlow.cancelToken.cancel();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  renderPromo(bool value) {
    if (value) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Input(
          props: InputProps(
            width: double.infinity,
            label: AppLocalizations.of(context)!.identityInviteCodeInput,
            type: TextInputType.text,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  void onPressHandler() async {
    final result = await registrationFlow.registrationHandler(
      password: passwordController.text,
      email: emailController.text,
    );
    showNotification(result.$1, result.$2, context);
    pushByType(result.$1, VerificationScreenRoute(email: emailController.text));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations intl = AppLocalizations.of(context)!;

    return Column(
      children: [
        Text(
          intl.registrationTitle,
          style: theme.textTheme.headlineLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 8),
          child: Input(
            props: InputProps(
              width: double.infinity,
              label: intl.email,
              type: TextInputType.emailAddress,
              controller: emailController,
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
        renderPromo(isRenderPromo),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Button(
            props: ButtonProps(
              text: intl.signUp,
              fill: true,
              onPressed: onPressHandler,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: HorizontalLineText(
                props:
                    HorizontalLineTextProps(text: intl.identityAccountExist))),
        Button(
          props: ButtonProps(
            text: intl.logIn,
            variant: ButtonVariant.secondary,
            onPressed: () =>
                GetIt.I<AppRouter>().replaceAll([const LoginScreenRoute()]),
            fill: true,
          ),
        )
      ],
    );
  }
}
