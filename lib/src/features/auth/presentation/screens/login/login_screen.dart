import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/auth/presentation/bloc/blocs.dart';
import 'package:imaginotas/src/features/auth/presentation/screens/login/widgets/widgets.dart';
import 'package:imaginotas/src/features/auth/presentation/validators/auth_validators.dart';
import 'package:imaginotas/src/features/shared/shared.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      create: (context) => LoginBloc(login: context.read<AuthBloc>().login),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
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
                          AppLocalizations.of(context).loginHere,
                          style: textStyle.displaySmall?.copyWith(
                            color: colors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const GapY.large(),
                        Text(
                          AppLocalizations.of(
                            context,
                          ).welcomeBackYouHaveBeenMissed,
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
                                    context.read<LoginBloc>().onEmailChanged,
                                hintText: AppLocalizations.of(context).email,
                                keyboardType: TextInputType.number,
                                suffixIcon: const Icon(Icons.badge),
                                validator: AuthValidators.validateEmail,
                              ),
                              CustomTextFormField(
                                onChanged:
                                    context.read<LoginBloc>().onPasswordChanged,
                                hintText: AppLocalizations.of(context).password,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !state.isPasswordVisible,
                                suffixIcon: PasswordIcon(
                                  isVisible: state.isPasswordVisible,
                                  onToggle:
                                      context
                                          .read<LoginBloc>()
                                          .onTogglePasswordVisibility,
                                ),
                                validator: AuthValidators.validatePassword,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: CustomTextButton(
                                  text:
                                      AppLocalizations.of(
                                        context,
                                      ).forgotPassword,
                                  onPressed: () {},
                                  style: textStyle.bodyMedium?.copyWith(
                                    color: colors.outline,
                                  ),
                                ),
                              ),

                              CustomGradientButton(
                                isExpanded: true,
                                loadingText:
                                    AppLocalizations.of(context).loggingIn,
                                isLoading: state.isLoading,
                                onPressed: () {
                                  final validate =
                                      _formKey.currentState?.validate() ??
                                      false;
                                  if (validate) {
                                    context.read<LoginBloc>().onSubmitForm();
                                  }
                                },
                                text: AppLocalizations.of(context).login,
                              ),

                              CustomTextButton(
                                text:
                                    AppLocalizations.of(
                                      context,
                                    ).createANewAccount,
                                style: textStyle.bodyMedium?.copyWith(
                                  color: colors.outline,
                                ),

                                onPressed: () {},
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
