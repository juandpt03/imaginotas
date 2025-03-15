import 'package:flutter/material.dart';
import 'package:imaginotas/src/core/core.dart';

class CategoryList extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryList({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: Gaps.paddingMedium),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: Gaps.paddingSmall),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) => onCategorySelected(category),
              backgroundColor: colors.surface,
              selectedColor: colors.primary,
              labelStyle: TextStyle(
                color: isSelected ? colors.onPrimary : colors.onSurface,
              ),
            ),
          );
        },
      ),
    );
  }
}
