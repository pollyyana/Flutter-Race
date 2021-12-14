import 'package:flutter/widgets.dart';
import 'package:tacaro/shared/utils/app_state.dart';
import 'repositories/create_repository.dart';

class CreateController extends ChangeNotifier {
  final ICreateRepository repository;
  AppState state = AppState.empty();
  final formKey = GlobalKey<FormState>();
  String _name = "";
  String _price = "";
  String _date = "";
  CreateController({required this.repository});
  //A função onChange irá armazenar os valores dos campos nas variáveis
  void onChange({String? name, String? price, String? date}) {
    _name = name ?? _name;
    _price = price ?? _price;
    _date = date ?? _date;
  }

  void update(AppState state) {
    this.state = state;
    notifyListeners();
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

  Future<void> create() async {
    if (validate()) {
      try {
        update(AppState.loading());
        final response = await repository.create(
          name: _name,
          date: _date,
          price: _price,
        );
        if (response) {
          update(
            AppState.success<bool>(response),
          );
        } else {
          throw Exception("Não foi possível cadastrar");
        }
      } catch (e) {
        update(
          AppState.error(e.toString()),
        );
      }
    }
  }
}
