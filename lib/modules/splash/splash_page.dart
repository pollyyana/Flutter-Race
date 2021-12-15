import 'package:flutter/material.dart';
import 'package:tacaro/shared/theme/app_theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Para definir o tempo da splash screen, é necessário um Future
    //Nele defini-se a duração, o valor se anulará ao final
    Future.delayed(
      Duration(
        seconds: 3,
      ),
    ).then((value) {
      Navigator.pushNamed(context, "/login");
    });
    return Scaffold(
      // TODO: Alterar o tema
      backgroundColor: AppTheme.colors.background,
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
