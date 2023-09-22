import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CardDropdown extends StatelessWidget {
  final String initialValue;
  final List<String> items;
  final String labelText;
  final String attribute;

  const CardDropdown({
    super.key,
    required this.initialValue,
    required this.items,
    required this.labelText,
    required this.attribute,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Card(
        elevation: 8.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 4.0,
            bottom: 4.0,
          ),
          child: FormBuilderDropdown<String>(
            name: attribute,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            initialValue: initialValue,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            decoration: InputDecoration(
              labelStyle: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
              labelText: FormBuilder.of(context)!.fields[attribute]?.value,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
            items: items
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
