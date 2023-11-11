import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:washpro/business_logic/cubits/login_screen/cubit.dart';
import 'package:washpro/data/repositories/auth/base.dart';
import 'package:washpro/logger.dart';
import 'package:washpro/presentation/widgets/custom_elevated_button.dart';
import 'package:washpro/presentation/widgets/custom_text_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: FormBuilder(
            key: formKey,
            child: BlocProvider<LoginScreenCubit>(
              create: (context) => LoginScreenCubit(
                  authRepository:
                      RepositoryProvider.of<AuthRepository>(context)),
              child: BlocListener<LoginScreenCubit, LoginScreenState>(
                listener: (context, state) {
                  if (state is LoginScreenError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.errorMessage),
                    ));
                  }
                },
                child: BlocConsumer<LoginScreenCubit, LoginScreenState>(
                    listener: ((context, state) => {}),
                    builder: (context, state) {
                      final cubit = BlocProvider.of<LoginScreenCubit>(context);
                      final formState = FormBuilder.of(context)!;

                      return Scaffold(
                        body: Center(
                            child: SingleChildScrollView(
                                child: SafeArea(
                                    child: Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center, // Center vertically
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center, // Ce
                                            children: [
                                              const Image(
                                                image: AssetImage(
                                                    'assets/logo.png'),
                                                width: 200,
                                                height: 200,
                                              ),
                                              const SizedBox(height: 20),
                                              Text(
                                                'Washpro Core',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                              ),
                                              const SizedBox(height: 20),
                                              CustomFormBuilderTextField(
                                                name: "username",
                                                controller: _emailController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                labelText: "User Name",
                                                prefixIcon: const Icon(
                                                    Icons.account_circle),
                                                validators:
                                                    FormBuilderValidators
                                                        .compose([
                                                  FormBuilderValidators
                                                      .required(),
                                                ]),
                                              ),
                                              const SizedBox(height: 16 / 2),
                                              CustomFormBuilderTextField(
                                                name: "password",
                                                controller: _passwordController,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                labelText: "Password",
                                                isPassword: true,
                                                prefixIcon:
                                                    const Icon(Icons.lock),
                                                validators:
                                                    FormBuilderValidators
                                                        .compose([
                                                  FormBuilderValidators
                                                      .required(),
                                                  FormBuilderValidators
                                                      .minLength(8),
                                                ]),
                                              ),
                                              const SizedBox(
                                                height: 28,
                                              ),
                                              SizedBox(
                                                width: double.maxFinite,
                                                height: 48,
                                                child: CustomElevatedButton(
                                                    buttonText: 'LOGIN',
                                                    isLoading: state
                                                        is LoginScreenLoading,
                                                    onPressed: () async {
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                      if (formState
                                                          .saveAndValidate()) {
                                                        logger
                                                            .i('Form is valid');
                                                        cubit.login(
                                                          username:
                                                              formState.value[
                                                                  'username'],
                                                          password:
                                                              formState.value[
                                                                  'password'],
                                                        );
                                                      }
                                                    }),
                                              ),
                                              const SizedBox(
                                                height: 28,
                                              ),
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     context.push(Routes
                                              //         .forgotPassword.route);
                                              //   },
                                              //   child: const Text(
                                              //     "I forgot my password",
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ))))),
                      );
                    }),
              ),
            )));
  }
}
