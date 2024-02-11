import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Config/Images.dart';

class LoginUserInfo extends StatelessWidget {
  const LoginUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      // height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsImage.boyPic,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Nitish Kumar",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "nitishr@gmail.com",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Row(children: [
                        SvgPicture.asset(
                          AssetsImage.profileAudioCall,
                          width: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Call",
                          style: TextStyle(
                            color: Color(0xff039C00),
                          ),
                        )
                      ]),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Row(children: [
                        SvgPicture.asset(
                          AssetsImage.profileVideoCall,
                          width: 25,
                          color: Color(0xffFF9900),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Video",
                          style: TextStyle(
                            color: Color(0xffFF9900),
                          ),
                        )
                      ]),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Row(children: [
                        SvgPicture.asset(
                          AssetsImage.appIconSVG,
                          width: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Chat",
                          style: TextStyle(
                            color: Color(0xff0057FF),
                          ),
                        )
                      ]),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
