import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'LoginForm.dart';
import 'SignupForm.dart';


class AuthPageBody extends StatelessWidget {
  const AuthPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLogin = true.obs;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        children: [
          Obx(
                () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      isLogin.value = true;
                    },
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: isLogin.value
                              ? Theme.of(context).textTheme.bodyLarge
                              : Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 5),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: isLogin.value ? 100 : 0,
                          height: 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      isLogin.value = false;
                    },
                    child: Column(
                      children: [
                        Text(
                          "Signup",
                          style: isLogin.value
                              ? Theme.of(context).textTheme.labelLarge
                              : Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 5),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: isLogin.value ? 0 : 100,
                          height: 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
                () => isLogin.value ? const LoginForm() : const SignupForm(),
          ),
        ],
      ),
    );
  }
}
