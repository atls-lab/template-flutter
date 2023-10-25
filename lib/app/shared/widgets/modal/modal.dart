import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../generated/assets.gen.dart';
import '../../themes/src/colors.dart';
import '../widgets.dart';

class Modal extends StatelessWidget {
  final ModalProps props;

  const Modal({super.key, required this.props});

  Widget renderTitle(ThemeData theme) {
    if (props.titleDirection == TitleDirection.horizontal) {
      return Row(children: [
        props.titleIcon ?? const SizedBox.shrink(),
        SizedBox(width: props.titleIcon != null ? 10 : 0),
        Text(props.title,
            style: theme.textTheme.headlineLarge!
                .copyWith(color: AppColors.toxicGreen))
      ]);
    } else {
      return SizedBox(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              props.titleIcon ?? const SizedBox.shrink(),
              SizedBox(width: props.titleIcon != null ? 10 : 0),
              Text(props.title,
                  style: theme.textTheme.headlineLarge!
                      .copyWith(color: AppColors.toxicGreen))
            ]),
      );
    }
  }

  Widget renderSubTitle(ThemeData theme) {
    final subTitle = props.subTitle;

    if (subTitle is String) {
      return Text(
        subTitle,
        style:
            theme.textTheme.bodySmall!.copyWith(color: AppColors.slightlyGrey),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size currentSize = MediaQuery.of(context).size;
    final double closeButtonHeight = currentSize.height * 0.08;
    const double closeButtonWidth = 5;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.mildlyBlack,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(24),
                    margin: EdgeInsets.only(
                        top: closeButtonHeight / 2, right: closeButtonWidth),
                    // height: sizeOfModal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: renderTitle(theme),
                        ),
                        renderSubTitle(theme),
                        Container(child: props.child),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Button(
                        props: ButtonProps(
                      variant: ButtonVariant.secondary,
                      icon: Assets.icons.solarCloseCircleBold.svg(),
                      onPressed: () => Navigator.pop(context),
                    )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
