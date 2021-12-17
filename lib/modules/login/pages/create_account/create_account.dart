import 'package:flutter/material.dart';
import 'package:tacaro/modules/login/pages/create_account_controller.dart';
import 'package:tacaro/modules/login/pages/repositories/login_repository_impl.dart';
import 'package:tacaro/shared/services/app_database.dart';
import 'package:tacaro/shared/theme/app_theme.dart';
import 'package:tacaro/shared/widgets/button/button.dart';
import 'package:tacaro/shared/widgets/input_text/input_text.dart';
import 'package:validators/validators.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  late final CreateAccountController controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    controller = CreateAccountController(
      repository: LoginRepositoryImpl(database: AppDatabase.instance),
    );
    controller.addListener(() {
      controller.state.when(
        success: (value) => Navigator.pop(context),
        error: (message, _) => scaffoldKey.currentState!.showBottomSheet(
          (context) => BottomSheet(
            onClosing: () {},
            builder: (context) => Container(
              child: Text(message),
            ),
          ),
        ),
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
      appBar: AppBar(
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
        leading: BackButton(
          color: AppTheme.colors.backButton,
        ),
      ),
      backgroundColor: AppTheme.colors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Criando uma conta", style: AppTheme.textStyles.title),
                //O texto no app do curso está Mantenha seus gastos em dia
                //Alterei porque o objetivo do app é encontrar o menor preço
                SizedBox(
                  height: 10,
                ),
                Text("Compre pelo menor preço",
                    style: AppTheme.textStyles.subtitle),
                SizedBox(
                  height: 38,
                ),
                //Foi utilizado parâmetros nomeados, assim fica fácil reconhecer
                InputText(
                  label: "Nome",
                  hint: "Digite seu nome completo",
                  onChanged: (value) => controller.onChange(name: value),
                  validator: (value) =>
                      value.isNotEmpty ? null : "Digite seu nome completo",
                  inputFormatters: [],
                ),
                SizedBox(
                  height: 18,
                ),
                InputText(
                  label: "Email",
                  hint: "Digite seu email",
                  onChanged: (value) => controller.onChange(email: value),
                  validator: (value) =>
                      isEmail(value) ? null : "Digite um e-mail válido",
                  inputFormatters: [],
                ),
                SizedBox(
                  height: 18,
                ),
                InputText(
                  label: "Senha",
                  hint: "Digite sua senha",
                  obscure: true,
                  onChanged: (value) => controller.onChange(password: value),
                  validator: (value) =>
                      //No curso o texto abaixo é Digite uma senha mais forte
                      //Contudo uma senha forte pode conter apenas 5 dígitos mas não será validado
                      value.length >= 6
                          ? null
                          : "Digite uma senha acima de 6 dígitos",
                  inputFormatters: [],
                ),
                SizedBox(
                  height: 14,
                ),
                AnimatedBuilder(
                  animation: controller,
                  builder: (_, __) => controller.state.when(
                    loading: () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                    orElse: () => Button(
                      label: "Criar Conta",
                      onTap: () {
                        controller.create();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
