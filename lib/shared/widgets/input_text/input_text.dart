import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tacaro/shared/theme/app_text.dart';
import 'package:tacaro/shared/theme/app_theme.dart';

class InputText extends StatelessWidget {
  //criação de variável para utilizar parâmetros nomeados
  final String label;
  final String hint;
  final bool obscure;
  final String? Function(String)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  const InputText({
    Key? key,
    required this.label,
    required this.hint,
    this.obscure = false,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //repare que foi usada a variável label criada acima
        Text(label).label,
        SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          //O validator abaixo valida se o valor do form é diferente de nulo para retornar o valor ou vazio
          validator: (value) {
            if (validator != null) {
              return validator!(value ?? "");
            }
          },
          onChanged: onChanged,
          obscureText: obscure,
          style: AppTheme.textStyles.input,
          decoration: InputDecoration(
            hintStyle: AppTheme.textStyles.hint,
            //repare que foi usada a variável hint criada acima
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
              borderSide: BorderSide(
                color: AppTheme.colors.border,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
