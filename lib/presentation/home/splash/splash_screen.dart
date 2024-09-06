import 'package:animals_app/presentation/home/home_screen.dart';
import 'package:animals_app/presentation/home/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  void openHome(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen.init(_)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColor.primary, AppColor.primaryLight],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Catbreeds",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.white),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 30.0),
              duration: const Duration(milliseconds: 1500),
              onEnd: () => openHome(context),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: SvgPicture.asset(
                    "assets/cat.svg",
                    height: 100,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
