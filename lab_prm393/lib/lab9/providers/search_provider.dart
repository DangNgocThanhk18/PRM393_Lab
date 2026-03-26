import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/note.dart';
import 'note_provider.dart';

// Search provider for filtering notes
final searchQueryProvider = StateProvider<String>((ref) => '');

// Filtered notes provider
final filteredNotesProvider = Provider<List<Note>>((ref) {
  final notesState = ref.watch(notesProvider);
  final searchQuery = ref.watch(searchQueryProvider);

  if (searchQuery.isEmpty) {
    return notesState.notes;
  }

  return notesState.notes.where((note) {
    return note.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
        note.content.toLowerCase().contains(searchQuery.toLowerCase());
  }).toList();
});