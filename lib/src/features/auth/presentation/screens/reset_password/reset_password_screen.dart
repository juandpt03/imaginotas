import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:imaginotas/src/features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:imaginotas/src/features/auth/presentation/validators/auth_validators.dart';
import 'package:imaginotas/src/features/shared/shared.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return BlocProvider(
      create:
          (context) => ResetPasswordBloc(
            resetPassword:
                (email) => context.read<AuthBloc>().resetPassword(email),
          ),
      child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state.isSubmitted) {
            AlertService.showToast(
              context: context,
              description:
                  '${AppLocalizations.of(context).resetPasswordLinkSentTo}${state.email}',
              success: true,
            );
            context.pop();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: AppLocalizations.of(context).resetPassword,
              showLeading: false,
            ),
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
                          AppLocalizations.of(context).forgotPassword,
                          style: textStyle.displaySmall?.copyWith(
                            color: colors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const GapY.large(),
                        Text(
                          AppLocalizations.of(
                            context,
                          ).enterYourEmailToResetYourPassword,
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
                                    context
                                        .read<ResetPasswordBloc>()
                                        .onEmailChanged,
                                hintText: AppLocalizations.of(context).email,
                                keyboardType: TextInputType.emailAddress,
                                suffixIcon: const Icon(Icons.email),
                                validator: AuthValidators.validateEmail,
                              ),
                              const GapY.medium(),
                              CustomGradientButton(
                                isExpanded: true,
                                loadingText:
                                    AppLocalizations.of(
                                      context,
                                    ).sendingResetLink,
                                isLoading: state.isLoading,
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    context
                                        .read<ResetPasswordBloc>()
                                        .onSubmitForm();
                                  }
                                },
                                text:
                                    AppLocalizations.of(context).sendResetLink,
                              ),
                              const GapY.medium(),
                              CustomTextButton(
                                text: AppLocalizations.of(context).backToLogin,
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
