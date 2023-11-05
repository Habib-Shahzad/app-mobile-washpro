import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/material.dart';
import 'package:washpro/logger.dart';
import 'package:washpro/presentation/widgets/custom_elevated_button.dart';

class AddNotesModal extends StatefulWidget {
  final Future<void> Function(String) onSave;
  final String? savedNotes;

  const AddNotesModal({
    Key? key,
    required this.onSave,
    this.savedNotes,
  }) : super(key: key);

  @override
  AddNotesModalState createState() => AddNotesModalState();
}

class AddNotesModalState extends State<AddNotesModal> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Notes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              FormBuilder(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FormBuilderTextField(
                    name: 'note',
                    initialValue: widget.savedNotes,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Enter your notes here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([]),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.maxFinite,
                height: 48,
                child: CustomElevatedButton(
                    isLoading: isLoading,
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      FormBuilderState? formState = _formKey.currentState!;

                      if (formState.saveAndValidate()) {
                        String? note = formState.fields['note']!.value;
                        if (note != null) {
                          logger.i('Saving Note $note');
                          setState(() {
                            isLoading = true;
                          });
                          await widget.onSave(note);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    buttonText: 'Save'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
