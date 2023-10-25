// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

import '../../../features/auth/auth.dart';
import '../../router/router.dart';
import '../../shared/widgets/widgets.dart';
import 'verification/timer_button.dart';
import 'verification/verification_config.dart';
import 'verification/verification_row.dart';

@RoutePage()
class VerificationScreen extends StatefulWidget {
  final String email;

  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  AppVerificationFlow verificationFlow = AppVerificationFlow();
  late List<TextEditingController> _controllersList;

  @override
  void initState() {
    super.initState();
    _controllersList = List.generate(
        verificationRowLength, (index) => TextEditingController());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result = await verificationFlow.initHandlersVerification();
      showNotification(result.$1, result.$2, context);
    });
  }

  @override
  void dispose() {
    verificationFlow.cancelToken.cancel();
    for (var element in _controllersList) {
      element.dispose();
    }
    super.dispose();
  }

  onPressHandler() async {
    String code = '';

    for (var element in _controllersList) {
      code += element.text;
    }

    final result = await verificationFlow.verificationHandler(
        code: code, email: widget.email);
    showNotification(result.$1, result.$2, context);
    pushByType(result.$1, const LoginScreenRoute());
    handleSuccessfulVerification(result.$1);
  }

  void handleSuccessfulVerification(UiTextTypeEnum type) {
    if (type == UiTextTypeEnum.success) {
      showNotification(UiTextTypeEnum.info,
          AppLocalizations.of(context)!.identityLogIn, context);
    }
  }

  Future<void> handleResendCode() async {
    final response = await verificationFlow.resendCode(email: widget.email);
    showNotification(response.$1, response.$2, context);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations intl = AppLocalizations.of(context)!;
    final Size currentSize = MediaQuery.of(context).size;
    final double verificationRowHeight = currentSize.height * 0.1;

    return Scaffold(
      appBar: TopBar(props: TopBarProps(title: intl.emailVerification)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          height: currentSize.height,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: currentSize.height * 0.05,
                  bottom: currentSize.height * 0.15,
                ),
                child: Column(
                  children: [
                    Text(intl.verificationTitle,
                        style: theme.textTheme.headlineLarge),
                    Padding(
                      padding: EdgeInsets.only(top: currentSize.height * 0.02),
                      child: VerificationRow(
                          height: verificationRowHeight,
                          controllersList: _controllersList),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.onInverseSurface,
                        ),
                        children: [
                          TextSpan(
                            text: intl.verificationBottomTextPart1,
                          ),
                          TextSpan(
                            text: intl.verificationBottomTextCode,
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          TextSpan(
                            text: intl.verificationBottomTextPart2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Button(
                props: ButtonProps(
                  onPressed: onPressHandler,
                  fill: true,
                  text: intl.continueButton,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: currentSize.height * 0.02),
                child: HorizontalLineText(
                    props: HorizontalLineTextProps(
                        text: intl.verificationBottomRetryCode)),
              ),
              TimerButton(
                  timer: codeResendTimer,
                  onPress: () => handleResendCode(),
                  text: intl.identitySendCodeAgain)
            ],
          ),
        ),
      ),
    );
  }
}
