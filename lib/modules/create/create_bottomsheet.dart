import 'package:flutter/material.dart';
import 'package:tacaro/shared/widgets/button/button.dart';
import 'package:tacaro/shared/widgets/input_text/input_text.dart';

class CreateBottomsheet extends StatefulWidget {
  const CreateBottomsheet({Key? key}) : super(key: key);

  @override
  _CreateBottomsheetState createState() => _CreateBottomsheetState();
}

class _CreateBottomsheetState extends State<CreateBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 42, vertical: 16),
      child: Column(
        children: [
          SizedBox(
            height: 32,
          ),
          InputText(label: "Produto", hint: "Digite um nome"),
          SizedBox(
            height: 8,
          ),
          InputText(label: "Preço", hint: "Digite o valor"),
          SizedBox(
            height: 8,
          ),
          InputText(label: "Data da compra", hint: "Digite dd/mm/aaaa"),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 20,
          ),
          Button(label: "Adicionar", onTap: () {})
        ],
      ),
    );
  }
}
