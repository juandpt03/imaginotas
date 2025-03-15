import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:imaginotas/src/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:imaginotas/src/features/auth/presentation/screens/login/widgets/widgets.dart';
import 'package:imaginotas/src/features/auth/presentation/validators/auth_validators.dart';
import 'package:imaginotas/src/features/shared/shared.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().stream.listen((state) {
      if (!mounted) return;
      if (state is AuthError) {
        ActionHandler.onException(context: context, exception: state.error);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return BlocProvider(
      create:
          (context) =>
              RegisterBloc(register: context.read<AuthBloc>().register),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(title: AppLocalizations.of(context).register),
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(Gaps.paddingLarge),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context).createANewAccount,
                          style: textStyle.displaySmall?.copyWith(
                            color: colors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const GapY.large(),
                        Text(
                          AppLocalizations.of(
                            context,
                          ).fillInYourDetailsToCreateAnAccount,
                          style: textStyle.titleMedium?.copyWith(
                            color: colors.outline,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const GapY.large(),
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            spacing: const GapY.medium().size,
                            children: [
                              CustomTextFormField(
                                onChanged:
                                    context.read<RegisterBloc>().onEmailChanged,
                                hintText: AppLocalizations.of(context).email,
                                keyboardType: TextInputType.emailAddress,
                                suffixIcon: const Icon(Icons.email),
                                validator: AuthValidators.validateEmail,
                              ),
                              CustomTextFormField(
                                onChanged:
                                    context
                                        .read<RegisterBloc>()
                                        .onPasswordChanged,
                                hintText: AppLocalizations.of(context).password,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !state.isPasswordVisible,
                                suffixIcon: PasswordIcon(
                                  isVisible: state.isPasswordVisible,
                                  onToggle:
                                      context
                                          .read<RegisterBloc>()
                                          .onTogglePasswordVisibility,
                                ),
                                validator: AuthValidators.validatePassword,
                              ),
                              CustomTextFormField(
                                onChanged:
                                    context
                                        .read<RegisterBloc>()
                                        .onConfirmPasswordChanged,
                                hintText:
                                    AppLocalizations.of(
                                      context,
                                    ).confirmPassword,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !state.isConfirmPasswordVisible,
                                suffixIcon: PasswordIcon(
                                  isVisible: state.isConfirmPasswordVisible,
                                  onToggle:
                                      context
                                          .read<RegisterBloc>()
                                          .onToggleConfirmPasswordVisibility,
                                ),
                                validator:
                                    (value) =>
                                        AuthValidators.validateConfirmPassword(
                                          value,
                                          state.user.password,
                                        ),
                              ),
                              CustomGradientButton(
                                isExpanded: true,
                                loadingText:
                                    AppLocalizations.of(
                                      context,
                                    ).creatingAccount,
                                isLoading: state.isLoading,
                                onPressed: () {
                                  final validate =
                                      _formKey.currentState?.validate() ??
                                      false;
                                  if (validate) {
                                    context.read<RegisterBloc>().onSubmitForm();
                                  }
                                },
                                text: AppLocalizations.of(context).register,
                              ),
                              CustomTextButton(
                                text:
                                    AppLocalizations.of(
                                      context,
                                    ).alreadyHaveAnAccountLogin,
                                style: textStyle.bodyMedium?.copyWith(
                                  color: colors.outline,
                                ),
                                onPressed:
                                    () => context.goNamed(AppRoute.login.name),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
