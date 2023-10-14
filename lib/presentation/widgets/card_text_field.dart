import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormBuilderCardTextField extends StatelessWidget {
  final String name;
  final List<FormFieldValidator<String>> validators;
  final String initialValue;

  const FormBuilderCardTextField({
    Key? key,
    required this.name,
    this.validators = const [],
    this.initialValue = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: initialValue);

    return FormBuilderField(
      name: name,
      validator: FormBuilderValidators.compose([...validators]),
      initialValue: initialValue,
      builder: (FormFieldState<dynamic> field) {
        return Column(
          children: [
            Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
                controller: controller,
                onChanged: (value) {
                  field.didChange(value);
                },
              ),
            ),
            if (field.errorText != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  field.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
