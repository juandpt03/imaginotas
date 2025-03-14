import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imaginotas/src/core/utils/gaps.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSaved;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool? enabled;
  final bool? autofocus;
  final bool? autocorrect;
  final bool? autovalidate;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final void Function()? onEditingComplete;
  final String? errorText;
  final bool? filled;
  final Color? fillColor;
  final int? maxLines;
  final int? minLines;
  final BorderSide? borderSide;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;
  final TextAlignVertical? textAlignVertical;
  final InputBorder? border;
  final bool? isDense;

  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.obscureText,
    this.controller,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.onTap,
    this.onFieldSubmitted,
    this.textInputAction,
    this.focusNode,
    this.readOnly,
    this.enabled,
    this.autofocus,
    this.autocorrect,
    this.autovalidate,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.onEditingComplete,
    this.errorText,
    this.filled,
    this.fillColor,
    this.maxLines,
    this.borderSide,
    this.style,
    this.hintStyle,
    this.contentPadding,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.decoration,
    this.minLines,
    this.textAlignVertical,
    this.border,
    this.isDense,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return TextFormField(
      textAlignVertical: textAlignVertical,
      inputFormatters: inputFormatters,
      textAlign: textAlign,
      maxLength: maxLength,
      style: style ?? textStyles.bodyLarge,
      autocorrect: autocorrect ?? true,
      autofocus: autofocus ?? false,
      controller: controller,
      decoration:
          decoration ??
          InputDecoration(
            isDense: isDense,
            filled: filled ?? false,
            labelText: labelText,
            hintText: hintText,
            hintStyle: hintStyle ?? textStyles.labelLarge,
            prefixIcon: prefixIcon,
            suffixIconColor: colors.primary,
            suffixIcon: suffixIcon,
            errorText: errorText,
            contentPadding:
                contentPadding ?? const EdgeInsets.all(Gaps.paddingMedium),
            border:
                border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Gaps.radiusLarge),
                  borderSide:
                      borderSide ??
                      BorderSide(
                        color: colors.onSurface.withValues(alpha: 0.5),
                      ),
                ),
            enabledBorder:
                border ??
                OutlineInputBorder(
                  borderSide:
                      borderSide ??
                      BorderSide(
                        color: colors.onSurface.withValues(alpha: 0.5),
                      ),
                  borderRadius: BorderRadius.circular(Gaps.radiusLarge),
                ),
            focusedBorder:
                border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Gaps.radiusLarge),
                  borderSide:
                      borderSide ??
                      BorderSide(
                        color: colors.primary.withValues(alpha: 0.5),
                        width: 2,
                      ),
                ),
            errorBorder:
                border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Gaps.radiusLarge),
                  borderSide:
                      borderSide ?? BorderSide(color: colors.error, width: 2),
                ),
          ),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      initialValue: initialValue,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      readOnly: readOnly ?? false,
      textInputAction: textInputAction,
      validator: validator,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled,
    );
  }
}
