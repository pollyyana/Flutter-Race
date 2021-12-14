import 'package:flutter/material.dart';
import 'package:tacaro/modules/create/create_controller.dart';
import 'package:tacaro/modules/create/repositories/create_repository_impl.dart';
import 'package:tacaro/shared/services/app_database.dart';
import 'package:tacaro/shared/widgets/button/button.dart';
import 'package:tacaro/shared/widgets/input_text/input_text.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class CreateBottomsheet extends StatefulWidget {
  const CreateBottomsheet({Key? key}) : super(key: key);

  @override
  _CreateBottomsheetState createState() => _CreateBottomsheetState();
}

class _CreateBottomsheetState extends State<CreateBottomsheet> {
  late final CreateController controller;
  @override
  void initState() {
    controller = CreateController(
      repository: CreateRepositoryImpl(database: AppDatabase.instance),
    );
    controller.addListener(() {
      controller.state.when(
          success: (_) {
            Navigator.pop(context);
          },
          orElse: () {});
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 42, vertical: 16),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            InputText(
              label: "Produto",
              hint: "Digite um nome",
              onChanged: (value) => controller.onChange(name: value),
              validator: (value) =>
                  value.isNotEmpty ? null : "Favor digitar um nome",
            ),
            SizedBox(
              height: 8,
            ),
            InputText(
              label: "Preço",
              hint: "Digite o valor",
              keyboardType: TextInputType.number,
              onChanged: (value) => controller.onChange(price: value),
              validator: (value) =>
                  value.isNotEmpty ? null : "Favor digitar um valor",
              inputFormatters: [
                MoneyInputFormatter(
                  leadingSymbol: "R\$",
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            InputText(
              keyboardType: TextInputType.datetime,
              label: "Data da compra",
              hint: "Digite dd/mm/aa",
              onChanged: (value) => controller.onChange(date: value),
              inputFormatters: [
                MaskedInputFormatter('00/00/0000'),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 20,
            ),
            AnimatedBuilder(
              animation: controller,
              builder: (_, __) => controller.state.when(
                loading: () => CircularProgressIndicator(),
                error: (message, _) => Text(message),
                orElse: () => Button(
                  label: "Adicionar",
                  onTap: () {
                    controller.create();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
