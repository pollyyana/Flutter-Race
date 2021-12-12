import 'package:flutter/widgets.dart';
import 'package:tacaro/modules/login/repositories/login_repository.dart';
import 'package:tacaro/shared/models/user_model.dart';
import 'package:tacaro/shared/utils/app_state.dart';

//Com o ChangeNotifier, o controller poderá manipular o estado onde for setado
class LoginController extends ChangeNotifier {
  final LoginRepository repository;
  //A variável state inicializará o estado de forma vazia
  AppState state = AppState.empty();
  final formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  LoginController({
    required this.repository,
  });
  //A função onChange irá armazenar os valores dos campos nas variáveis
  void onChange({String? email, String? password}) {
    _email = email ?? _email;
    _password = password ?? _password;
  }

  bool validate() {
    //com formKey.currentState, estarei identificando o ID atual do campo na árvore de widgets
    //quando dá o .currentState, pega o estado atual deste widget
    final form = formKey.currentState!;
    //Com o estado atual, conseguir acessar o estado atual do form e chamar o validate
    //Se o form for validado, salva dentro do form, senão, retorna o erro
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void update(AppState state) {
    this.state = state;
    notifyListeners();
  }

  Future<void> login() async {
    if (validate()) {
      try {
        update(AppState.loading());
        //CHAMADA DO BACKEND
        final response =
            await repository.login(email: _email, password: _password);
        update(
          AppState.success<UserModel>(response),
        );
      } catch (e) {
        update(
          AppState.error(e.toString()),
        );
      }
    }
  }
}
