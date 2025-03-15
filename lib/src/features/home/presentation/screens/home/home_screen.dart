import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:imaginotas/src/features/home/presentation/bloc/notes/notes_bloc.dart';
import 'package:imaginotas/src/features/home/presentation/screens/home/widgets/widgets.dart';

import 'package:imaginotas/src/features/shared/shared.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesBloc>(
      create:
          (context) => NotesBloc(
            noteUseCases: DI.sl.get(),
            currentUser:
                (context.read<AuthBloc>().state as AuthAuthenticated).user,
          ),

      child: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NotesError) {
            ActionHandler.onException(context: context, exception: state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('My Notes'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => context.read<AuthBloc>().logout(),
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Gaps.paddingMedium),
                  child: CustomSearchBar(
                    controller: _searchController,
                    onSearch: (query) {
                      final userId =
                          context.read<AuthBloc>().state is AuthAuthenticated
                              ? (context.read<AuthBloc>().state
                                      as AuthAuthenticated)
                                  .user
                                  .id
                              : '';
                      if (userId.isNotEmpty) {
                        context.read<NotesBloc>().searchNotes(userId, query);
                      }
                    },
                    hintText: 'Search notes...',
                  ),
                ),

                if (state is NotesSuccess && state.categories.isNotEmpty)
                  CategoryList(
                    categories: state.categories,
                    selectedCategory: state.selectedCategory,
                    onCategorySelected: (category) {
                      final userId =
                          (context.read<AuthBloc>().state as AuthAuthenticated)
                              .user
                              .id;

                      if (category == state.selectedCategory) {
                        context.read<NotesBloc>().clearFilter();
                      } else {
                        context.read<NotesBloc>().filterByCategory(
                          userId,
                          category,
                        );
                      }
                    },
                  ),

                Expanded(child: _buildNotesList(state)),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.pushNamed(AppRoute.note.name),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotesList(NotesState state) {
    if (state is NotesLoading) {
      return const CustomLoading();
    }

    if (state is NotesSuccess) {
      if (state.notes.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.note_alt_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const GapY.medium(),
              Text(
                'No notes yet',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const GapY.small(),
              Text(
                'Create your first note by tapping the button below.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(Gaps.paddingMedium),
        itemCount: state.notes.length,
        itemBuilder: (context, index) {
          final note = state.notes[index];
          return NoteCard(
            note: note,
            onTap: () => context.pushNamed(AppRoute.note.name, extra: note),
            onDelete: () => context.read<NotesBloc>().deleteNote(note.id),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }
}
