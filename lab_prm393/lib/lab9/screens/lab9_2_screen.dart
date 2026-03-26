import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/note_provider.dart';
import '../widgets/note_card.dart';
import '../widgets/note_form_dialog.dart';
import '../widgets/loading_widget.dart';

class Lab9_2Screen extends ConsumerStatefulWidget {
  const Lab9_2Screen({super.key});

  @override
  ConsumerState<Lab9_2Screen> createState() => _Lab9_2ScreenState();
}

class _Lab9_2ScreenState extends ConsumerState<Lab9_2Screen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notesProvider.notifier).loadNotes();
    });
  }

  Future<void> _showAddDialog() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => const NoteFormDialog(
        title: 'Add New Note',
        confirmText: 'Add',
      ),
    );

    if (result != null && mounted) {
      await ref.read(notesProvider.notifier).addNote(
        result['title']!,
        result['content']!,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note added successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final notesState = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 9.2 - Save & Load JSON'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(notesProvider.notifier).loadNotes();
            },
          ),
        ],
      ),
      body: _buildBody(notesState),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(NotesState state) {
    if (state.isLoading) {
      return const LoadingWidget(message: 'Loading notes...');
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
                ref.read(notesProvider.notifier).loadNotes();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.notes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_add, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No notes yet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Tap the + button to add a note'),
          ],
        ),
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