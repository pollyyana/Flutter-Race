//classes aceitam guardar valores, enum não conseguem
//Typedef atribui a um tipo de função um nome que você pode usar ao declarar campos e retornar tipos.
typedef Empty = Function();
typedef Loading = Function();
typedef Success<T> = Function(T data);
typedef Error = Function(String message, Exception? e);
typedef OrElse = Function();

abstract class AppState {
  //Para evitar ficar criando if/else nos forms, foi criado o macete abaixo com when
  dynamic when({
    Empty? empty,
    Loading? loading,
    Success? success,
    Error? error,
    //OrElse é sempre required, evita que o código quebre com algum erro
    required OrElse orElse,
  });

  static empty() => StateEmpty();
  static loading() => StateLoading();
  static success<T>(T data) => StateSuccess(data);
  static error(String message, {Exception? e}) => StateError(message, e: e);
}

class StateEmpty extends AppState {
  @override
  when(
      {Empty? empty,
      Loading? loading,
      Success? success,
      Error? error,
      required OrElse orElse}) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }
}

class StateLoading extends AppState {
  @override
  when(
      {Empty? empty,
      Loading? loading,
      Success? success,
      Error? error,
      required OrElse orElse}) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }
}

//A variável do tipo T retorna valores que ficarão disponíveis para serem
//acessadas na aplicação, por isso está sendo informada no Estado
class StateSuccess<T> extends AppState {
  final T data;
  StateSuccess(
    this.data,
  );
  @override
  when(
      {Empty? empty,
      Loading? loading,
      Success? success,
      Error? error,
      required OrElse orElse}) {
    if (success != null) {
      //com o sucesso retorna os dados
      return success(data);
    }
    return orElse();
  }
}

class StateError extends AppState {
  final String message;
  final Exception? e;
  StateError(this.message, {this.e});
  @override
  when(
      {Empty? empty,
      Loading? loading,
      Success? success,
      Error? error,
      required OrElse orElse}) {
    if (error != null) {
      //com o erro retorna a mensagem e a exceção
      return error(message, e);
    }
    return orElse();
  }
}
