import 'package:flutter/material.dart';

class PasswordIcon extends StatelessWidget {
  final bool isVisible;
  final void Function(bool) onToggle;

  const PasswordIcon({
    super.key,
    required this.isVisible,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(!isVisible),
      child:
          isVisible
              ? const Icon(Icons.lock_outline)
              : const Icon(Icons.lock_open),
    );
  }
}
