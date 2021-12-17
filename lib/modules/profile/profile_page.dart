import 'package:flutter/material.dart';

import 'package:tacaro/shared/models/user_model.dart';
import 'package:tacaro/shared/theme/app_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
    this.user,
  }) : super(key: key);
  final UserModel? user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 42, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Perfil",
              style: AppTheme.textStyles.title.copyWith(fontSize: 25),
            ),
            SizedBox(height: 60),
            Center(
              child: Container(
                width: 220,
                decoration: BoxDecoration(
                  color: Colors.red[400],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  title: Text("Sair do aplicativo",
                      textAlign: TextAlign.center,
                      style: AppTheme.textStyles.logout),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
