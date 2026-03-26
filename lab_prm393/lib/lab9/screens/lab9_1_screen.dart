import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/note_provider.dart';
import '../widgets/note_card.dart';
import '../widgets/loading_widget.dart';

class Lab9_1Screen extends ConsumerStatefulWidget {
  const Lab9_1Screen({super.key});

  @override
  ConsumerState<Lab9_1Screen> createState() => _Lab9_1ScreenState();
}

class _Lab9_1ScreenState extends ConsumerState<Lab9_1Screen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notesProvider.notifier).loadFromAssets();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notesState = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 9.1 - JSON From Assets'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(notesProvider.notifier).loadFromAssets();
            },
          ),
        ],
      ),
      body: _buildBody(notesState),
    );
  }

  Widget _buildBody(NotesState state) {
    if (state.isLoading) {
      return const LoadingWidget(message: 'Loading notes from assets...');
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              state.error!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(notesProvider.notifier).loadFromAssets();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.notes.isEmpty) {
      return const Center(
        child: Text('No notes found in assets'),
      );
    }

    return ListView.builder(
      itemCount: state.notes.length,
      itemBuilder: (context, index) {
        final note = state.notes[index];
        return NoteCard(
          note: note,
          onEdit: () {},
          onDelete: () {},
        );
      },
    );
  }
}