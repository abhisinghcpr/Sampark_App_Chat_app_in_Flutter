import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Config/Images.dart';
import '../../../Config/Strings.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsImage.boyPic),
            SvgPicture.asset(AssetsImage.connetSVG),
            Image.asset(AssetsImage.girlPic),
          ],
        ),
        SizedBox(height: 30),
        Text(
          WelcomePageString.nowYourAre,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          WelcomePageString.connected,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(height: 30),
        Text(
          WelcomePageString.discription,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        )
      ],
    );
  }
}
