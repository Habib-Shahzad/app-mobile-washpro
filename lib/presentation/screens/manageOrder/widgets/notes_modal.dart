import 'package:washpro/business_logic/cubits/pickup_screen/cubit.dart';
import 'package:washpro/logger.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washpro/presentation/widgets/custom_elevated_button.dart';

class AddNotesModal extends StatelessWidget {
  final void Function(String) onSave;
  final String? savedNotes;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  AddNotesModal({
    Key? key,
    required this.onSave,
    this.savedNotes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<PickupScreenCubit>(context).state;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Add Notes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilder(
                  key: _formKey,
                  child: FormBuilderTextField(
                    name: 'note',
                    initialValue: savedNotes,
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
              CustomElevatedButton(
                isLoading: state.savingNotes == LoadingStatus.loading,
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (_formKey.currentState!.saveAndValidate()) {
                    String? note = _formKey.currentState!.fields['note']!.value;
                    if (note != null) {
                      logger.i('Notes Form is valid');
                      onSave(note);
                    }
                  }
                },
                buttonText: state.savingNotes == LoadingStatus.loading
                    ? 'Saving...'
                    : 'Save',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
