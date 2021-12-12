import 'package:flutter/material.dart';
import 'package:tacaro/modules/login/login_controller.dart';
import 'package:tacaro/modules/login/repositories/login_repository_impl.dart';
import 'package:tacaro/shared/services/app_database.dart';
import 'package:tacaro/shared/theme/app_theme.dart';
import 'package:tacaro/shared/widgets/button/button.dart';
import 'package:tacaro/shared/widgets/input_text/input_text.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginController controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller = LoginController(
      repository: LoginRepositoryImpl(database: AppDatabase.instance),
    );
    controller.addListener(() {
      controller.state.when(
        success: (value) =>
            Navigator.pushNamed(context, "/home", arguments: value),
        error: (message, _) => scaffoldKey.currentState!.showBottomSheet(
          (context) => BottomSheet(
            onClosing: () {},
            builder: (context) => Container(
              child: Text(message),
            ),
          ),
        ),

        /* Mesmo que o backend não esteja pronto, com print pode simular o login
        success: (value) => print(value),
        error: (message, _) => print(message),
        loading: () => print("loading..."),
         */
        orElse: () {},
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.colors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          //Com esse formkey, teremos acesso ao estado do form renderizado
          //e conseguiremos chamar o validator de todos os ítens do form
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: 200,
              ),
              //Foi utilizado parâmetros nomeados, assim fica fácil reconhecer
              InputText(
                label: "Email",
                hint: "Digite seu email",
                //O package validators, analisa se o value é um email ou nulo, caso seja nulo, pede
                //para inserir um email válido
                validator: (value) =>
                    isEmail(value) ? null : "Digite um e-mail válido",
                onChanged: (value) => controller.onChange(email: value),
              ),
              SizedBox(
                height: 18,
              ),
              InputText(
                label: "Senha",
                hint: "Digite sua senha",
                obscure: true,
                onChanged: (value) => controller.onChange(password: value),
                //O validator abaixo não é o recomendado, pois não analisa a segurança da senha de
                //apenas se possui mais de 6 caracteres.
                validator: (value) =>
                    //No curso o texto abaixo é Digite uma senha mais forte
                    //Contudo o correto é Digite a senha correta
                    //Contudo uma senha forte pode conter apenas 5 dígitos mas não será validado
                    //Digite uma senha acima de 6 dígitos
                    value.length >= 6 ? null : "Digite a senha correta",
              ),
              SizedBox(
                height: 14,
              ),
              AnimatedBuilder(
                  animation: controller,
                  builder: (_, __) {
                    return controller.state.when(
                      loading: () => CircularProgressIndicator(),
                      orElse: () => Column(
                        children: [
                          Button(
                            label: "Entrar",
                            onTap: () {
                              controller.login();
                            },
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Button(
                            label: "Criar Conta",
                            type: ButtonType.outline,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "/login/create_account");
                            },
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
