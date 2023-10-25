import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets.gen.dart';
import 'logo/logo.dart';

@RoutePage()
class IdentityScreen extends StatelessWidget {
  const IdentityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double logoSize = MediaQuery.of(context).size.height * 0.5;
    final double boxSize = MediaQuery.of(context).size.height * 0.4;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.background.path),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: boxSize,
                child: Stack(
                  children: [
                    Positioned(
                      left: -15,
                      top: 0,
                      height: logoSize,
                      width: logoSize,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Assets.images.lightEffect.path),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Logo(props: LogoProps(fill: true)),
                  ],
                ),
              ),
              const Expanded(child: AutoRouter()),
            ],
          ),
        ),
      ),
    );
  }
}
