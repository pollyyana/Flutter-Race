//A classe criada abaixo não poderá ser modificada em tempo de execução, somente buildando
//Para criar em tempo de execução é necessário criar Interface
import 'package:tacaro/shared/theme/app_colors.dart';
import 'package:tacaro/shared/theme/app_text_styles.dart';
export 'app_text.dart';
//O export é utilizado para deixar disponível o import

class AppTheme {
  // // ****** Padrão Singleton ******
  //Só que não está disponível para acessar em qualquer momento
  // static AppTheme? _instance;
  // static AppTheme get instance {
  //   // ignore: prefer_conditional_assignment
  //   if (_instance == null) {
  //     _instance = AppTheme();
  //   }
  //   return _instance!;
  // }
  // // ****** Padrão Singleton ******

  //Da forma abaixo o Apptheme fica disponível em qualquer momento
  static final AppTheme instance = AppTheme();
  static final _colors = AppColors();
  //para tornar as variárias privadas _colors e _textStyles é necessário criar um get
  static AppColors get colors => _colors;
  static final _textStyles = AppTextStyles();
  static AppTextStyles get textStyles => _textStyles;
}
