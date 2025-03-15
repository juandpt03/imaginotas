import 'package:flutter/material.dart';
import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/home/domain/domain.dart';
import 'package:imaginotas/src/features/shared/shared.dart';
import 'package:timeago/timeago.dart' as timeago;

class NoteCard extends StatelessWidget {
  final NoteEntity note;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: Gaps.paddingMedium),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(Gaps.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      note.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: colors.error),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Text(
                                AppLocalizations.of(context).deleteNote,
                              ),
                              content: Text(
                                AppLocalizations.of(
                                  context,
                                ).areYouSureYouWantToDeleteThisNote,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    AppLocalizations.of(context).cancel,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    onDelete();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context).delete,
                                    style: TextStyle(color: colors.error),
                                  ),
                                ),
                              ],
                            ),
                      );
                    },
                    splashRadius: 24,
                  ),
                ],
              ),
              if (note.content.isNotEmpty) ...[
                const GapY.small(),
                Text(
                  note.content,
                  style: textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const GapY.medium(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (note.category.isNotEmpty)
                    Chip(
                      label: Text(
                        note.category,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.onPrimary,
                        ),
                      ),
                      backgroundColor: colors.primary,
                      padding: EdgeInsets.zero,
                    )
                  else
                    const SizedBox.shrink(),
                  Text(
                    timeago.format(note.updatedAt),
                    style: textTheme.bodySmall?.copyWith(color: colors.outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
