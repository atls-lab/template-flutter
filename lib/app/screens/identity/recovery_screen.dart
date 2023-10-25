// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../features/auth/auth.dart';
import '../../router/router.dart';
import '../../shared/widgets/widgets.dart';
import 'verification/timer_button.dart';
import 'verification/verification_config.dart';
import 'verification/verification_row.dart';

@RoutePage()
class RecoveryScreen extends StatefulWidget {
  final String email;

  const RecoveryScreen({super.key, required this.email});

  @override
  State<RecoveryScreen> createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  final AppRecoveryFlow _recoveryFlow = AppRecoveryFlow();
  late List<TextEditingController> _controllersList;

  @override
  void initState() {
    super.initState();
    _controllersList = List.generate(
        verificationRowLength, (index) => TextEditingController());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result =
          await _recoveryFlow.initHandlersRecovery(email: widget.email);
      showNotification(result.$1, result.$2, context);
    });
  }

  @override
  void dispose() {
    _recoveryFlow.cancelToken.cancel();
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

    final result = await _recoveryFlow.recoveryHandler(code: code);
    showNotification(result.$1, result.$2, context);
    pushByType(result.$1, const HomeScreenRoute());
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
                  onPress: () => GetIt.I<AppRouter>()
                      .push(RecoveryScreenRoute(email: widget.email)),
                  text: intl.identitySendCodeAgain)
            ],
          ),
        ),
      ),
    );
  }
}
