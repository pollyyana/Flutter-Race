import 'package:flutter/material.dart';
import 'package:tacaro/shared/theme/app_theme.dart';

//extension funciona como uma propriedade personalizada, assim não precisa ficar declarando
//constantemente a mesma propriedade todas as vezes que precisar.
//Exemplo, quando precisar do estilo abaixo, basta chamar como se fosse objeto
//inserindo um ponto depois do texto: Text("teste").label

extension TextExt on Text {
  Text get label => Text(
        // ignore: unnecessary_this
        this.data!,
        style: AppTheme.textStyles.label,
      );
}
