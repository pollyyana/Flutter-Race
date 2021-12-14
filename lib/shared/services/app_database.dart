import 'package:tacaro/shared/models/user_model.dart';
import 'package:tacaro/shared/services/supabase_database.dart';

//Criação de uma Interface
abstract class AppDatabase {
  //Utilização do padrão Singleton na linha abaixo, caso queira utilizar outro database
  //basta alterar no final qual banco de dados
  static final AppDatabase instance = SupabaseDatabase();
  void init();
  Future<List<Map<String, dynamic>>> getAll(String table);
  Future<bool> create(
      {required String table, required Map<String, dynamic> data});
  Future<UserModel> createUser(
    UserModel user,
  );
  Future<UserModel> getUser(
    String id,
  );
  Future<UserModel> login({
    required String email,
    required String password,
  });
  Future<UserModel> createAccount({
    required String email,
    required String password,
    required String name,
  });
}
