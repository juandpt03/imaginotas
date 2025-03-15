import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:imaginotas/src/features/home/domain/entities/note.dart';
import 'package:imaginotas/src/features/home/presentation/bloc/note/note_form_bloc.dart';
import 'package:imaginotas/src/features/home/presentation/bloc/notes/notes_bloc.dart';
import 'package:imaginotas/src/features/home/presentation/validators/note_validators.dart';
import 'package:imaginotas/src/features/shared/shared.dart';

class NoteView extends StatefulWidget {
  final NoteEntity? note;

  const NoteView({super.key, this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _categoryController = TextEditingController();
  late final NoteFormBloc _formBloc;

  @override
  void initState() {
    super.initState();
    _formBloc = NoteFormBloc(
      noteUseCases: DI.sl.get(),
      initialNote: widget.note,
    );

    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _categoryController.text = widget.note!.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _categoryController.dispose();
    _formBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;

    return BlocProvider.value(
      value: _formBloc,
      child: BlocConsumer<NoteFormBloc, NoteFormState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isEditing
                      ? 'Note updated successfully!'
                      : 'Note created successfully!',
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
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
            appBar: AppBar(
              title: Text(isEditing ? 'Edit Note' : 'Create Note'),
              actions: [
                if (isEditing)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                    onPressed: () => _showDeleteConfirmationDialog(context),
                  ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(Gaps.paddingMedium),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextFormField(
                                controller: _titleController,
                                hintText: 'Title',
                                validator: NoteValidators.validateTitle,
                                onChanged: (value) {
                                  _formBloc.onTitleChanged(value);
                                },
                              ),

                              const GapY.medium(),

                              CustomTextFormField(
                                controller: _categoryController,
                                hintText: 'Category (optional)',
                                validator: NoteValidators.validateCategory,
                                onChanged: (value) {
                                  _formBloc.onCategoryChanged(value);
                                },
                              ),

                              const GapY.medium(),

                              CustomTextFormField(
                                controller: _contentController,
                                hintText: 'Note content',
                                maxLines: 10,
                                keyboardType: TextInputType.multiline,
                                validator: NoteValidators.validateContent,
                                onChanged: (value) {
                                  _formBloc.onContentChanged(value);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const GapY.medium(),

                      CustomGradientButton(
                        isExpanded: true,
                        text: isEditing ? 'Update Note' : 'Save Note',
                        loadingText: isEditing ? 'Updating...' : 'Saving...',
                        isLoading: state.isLoading,
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final userId =
                                (context.read<AuthBloc>().state
                                        as AuthAuthenticated)
                                    .user
                                    .id;
                            _formBloc.onFormSubmitted(userId);
                          }
                        },
                      ),
                    ],
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
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Note'),
            content: const Text(
              'Are you sure you want to delete this note? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
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
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }
}
