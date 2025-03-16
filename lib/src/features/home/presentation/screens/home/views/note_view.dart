import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:imaginotas/src/features/home/domain/entities/note.dart';
import 'package:imaginotas/src/features/home/presentation/bloc/note/note_form_bloc.dart';
import 'package:imaginotas/src/features/home/presentation/bloc/notes/notes_bloc.dart';
import 'package:imaginotas/src/features/home/presentation/validators/home_validators.dart';
import 'package:imaginotas/src/features/shared/shared.dart';

class NoteView extends StatefulWidget {
  final NoteEntity? note;

  const NoteView({super.key, this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isEditing = widget.note != null;

    return BlocProvider(
      create:
          (context) =>
              NoteFormBloc(noteUseCases: DI.sl.get(), initialNote: widget.note),
      child: BlocConsumer<NoteFormBloc, NoteFormState>(
        listener: (context, state) {
          if (state.isSuccess) {
            AlertService.showToast(
              context: context,
              description:
                  isEditing
                      ? AppLocalizations.of(context).noteUpdatedSuccessfully
                      : AppLocalizations.of(context).noteCreatedSuccessfully,
              success: true,
            );
            context.pop();
          }

          if (state.error != null) {
            ActionHandler.onException(
              context: context,
              exception: state.error!,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title:
                  isEditing
                      ? AppLocalizations.of(context).editNote
                      : AppLocalizations.of(context).createNote,

              actions: [
                if (isEditing)
                  IconButton(
                    icon: ImageManager.icons.delete.toSvg(color: colors.error),

                    color: Theme.of(context).colorScheme.error,
                    onPressed: () => _showDeleteConfirmationDialog(context),
                  ),
              ],
            ),
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: const EdgeInsets.all(Gaps.paddingMedium),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextFormField(
                                  initialValue: state.note.title,
                                  hintText: AppLocalizations.of(context).title,
                                  validator: HomeValidators.validateTitle,
                                  onChanged:
                                      context
                                          .read<NoteFormBloc>()
                                          .onTitleChanged,
                                ),

                                const GapY.medium(),

                                CustomTextFormField(
                                  initialValue: state.note.category,
                                  hintText:
                                      AppLocalizations.of(
                                        context,
                                      ).categoryOptional,
                                  validator: HomeValidators.validateCategory,
                                  onChanged:
                                      context
                                          .read<NoteFormBloc>()
                                          .onCategoryChanged,
                                ),

                                const GapY.medium(),

                                CustomTextFormField(
                                  initialValue: state.note.content,
                                  hintText:
                                      AppLocalizations.of(context).noteContent,
                                  maxLines: 10,
                                  keyboardType: TextInputType.multiline,
                                  validator: HomeValidators.validateContent,
                                  onChanged:
                                      context
                                          .read<NoteFormBloc>()
                                          .onContentChanged,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const GapY.medium(),

                        CustomGradientButton(
                          isExpanded: true,
                          text:
                              isEditing
                                  ? AppLocalizations.of(context).updateNote
                                  : AppLocalizations.of(context).saveNote,
                          loadingText:
                              isEditing
                                  ? AppLocalizations.of(context).updating
                                  : AppLocalizations.of(context).saving,
                          isLoading: state.isLoading,
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              final userId =
                                  (context.read<AuthBloc>().state
                                          as AuthAuthenticated)
                                      .user
                                      .id;
                              context.read<NoteFormBloc>().onFormSubmitted(
                                userId,
                              );
                            }
                          },
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

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).deleteNote),
          content: Text(
            AppLocalizations.of(context).areYouSureYouWantToDeleteThisNoteThis,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context).cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<NotesBloc>().deleteNote(widget.note!.id);
                context.pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: Text(AppLocalizations.of(context).delete),
            ),
          ],
        );
      },
    );
  }
}
