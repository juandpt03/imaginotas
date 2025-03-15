import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/auth/domain/domain.dart';
import 'package:imaginotas/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:imaginotas/src/features/home/presentation/bloc/notes/notes_bloc.dart';
import 'package:imaginotas/src/features/home/presentation/screens/home/widgets/widgets.dart';
import 'package:imaginotas/src/features/shared/presentation/widgets/app_bar/custom_app_bar.dart';

import 'package:imaginotas/src/features/shared/shared.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final UserEntity? _currentUser;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    _currentUser = context.read<AuthBloc>().state.user;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return BlocProvider<NotesBloc>(
      create:
          (context) =>
              NotesBloc(noteUseCases: DI.sl.get(), currentUser: _currentUser),

      child: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NotesError) {
            ActionHandler.onException(context: context, exception: state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              showLeading: false,
              title: AppLocalizations.of(context).myNotes,
              actions: [
                IconButton(
                  icon: ImageManager.icons.logout.toSvg(
                    color: colors.onSurface,
                  ),
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
                    onSearch:
                        (query) => context.read<NotesBloc>().searchNotes(
                          _currentUser?.id,
                          query,
                        ),
                    hintText: AppLocalizations.of(context).searchNotes,
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
              shape: CircleBorder(),
              foregroundColor: colors.onPrimary,
              backgroundColor: colors.primary,

              onPressed: () => context.pushNamed(AppRoute.note.name),
              child: Icon(Icons.add, color: colors.onPrimary),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotesList(NotesState state) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    if (state is NotesLoading) {
      return const CustomLoading();
    }

    if (state is NotesSuccess) {
      if (state.notes.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.note_alt_outlined, size: 64, color: colors.primary),
              const GapY.medium(),
              Text(
                AppLocalizations.of(context).noNotesYet,
                style: textStyle.titleLarge,
              ),
              const GapY.small(),
              Text(
                AppLocalizations.of(
                  context,
                ).createYourFirstNoteByTappingTheButtonBelow,
                style: textStyle.bodyMedium,
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
