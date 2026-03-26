import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';
import '../providers/search_provider.dart';
import '../widgets/note_card.dart';
import '../widgets/note_form_dialog.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/loading_widget.dart';

class Lab9_3Screen extends ConsumerStatefulWidget {
  const Lab9_3Screen({super.key});

  @override
  ConsumerState<Lab9_3Screen> createState() => _Lab9_3ScreenState();
}

class _Lab9_3ScreenState extends ConsumerState<Lab9_3Screen> {
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

  Future<void> _showEditDialog(int id, String title, String content) async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => NoteFormDialog(
        initialTitle: title,
        initialContent: content,
        title: 'Edit Note',
        confirmText: 'Save',
      ),
    );

    if (result != null && mounted) {
      await ref.read(notesProvider.notifier).updateNote(
        id,
        result['title']!,
        result['content']!,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note updated successfully'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    }
  }

  Future<void> _confirmDelete(int id, String title) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: Text('Are you sure you want to delete "$title"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await ref.read(notesProvider.notifier).deleteNote(id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note deleted successfully'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _resetToDefault() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset to Default'),
        content: const Text('This will replace all notes with default data. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await ref.read(notesProvider.notifier).resetToDefault();
      ref.read(searchQueryProvider.notifier).state = '';
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reset to default notes'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final notesState = ref.watch(notesProvider);
    final filteredNotes = ref.watch(filteredNotesProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 9.3 - JSON CRUD + Search'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            onPressed: _resetToDefault,
            tooltip: 'Reset to default',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(notesProvider.notifier).loadNotes();
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          const CustomSearchBar(),
          Expanded(
            child: _buildBody(notesState, filteredNotes, searchQuery),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(NotesState state, List<Note> filteredNotes, String searchQuery) {
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

    if (filteredNotes.isEmpty && searchQuery.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No notes match "$searchQuery"',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                ref.read(searchQueryProvider.notifier).state = '';
              },
              child: const Text('Clear search'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredNotes.length,
      itemBuilder: (context, index) {
        final note = filteredNotes[index];
        return NoteCard(
          note: note,
          onEdit: () => _showEditDialog(note.id, note.title, note.content),
          onDelete: () => _confirmDelete(note.id, note.title),
        );
      },
    );
  }
}