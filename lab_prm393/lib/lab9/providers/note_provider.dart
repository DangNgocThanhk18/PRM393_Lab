import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/note.dart';
import '../services/storage_service.dart';

// Provider for StorageService
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

// State class for notes
class NotesState {
  final List<Note> notes;
  final bool isLoading;
  final String? error;

  const NotesState({
    this.notes = const [],
    this.isLoading = false,
    this.error,
  });

  NotesState copyWith({
    List<Note>? notes,
    bool? isLoading,
    String? error,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Notifier for managing notes
class NotesNotifier extends StateNotifier<NotesState> {
  final StorageService _storageService;

  NotesNotifier(this._storageService) : super(const NotesState());

  // Load notes from local storage
  Future<void> loadNotes() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final notes = await _storageService.loadFromLocal();
      state = state.copyWith(notes: notes, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Load notes from assets (Lab 9.1)
  Future<void> loadFromAssets() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final notes = await _storageService.loadFromAssets();
      state = state.copyWith(notes: notes, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Add a new note
  Future<void> addNote(String title, String content) async {
    final newId = state.notes.isEmpty
        ? 1
        : state.notes.map((n) => n.id).reduce((a, b) => a > b ? a : b) + 1;

    final now = DateTime.now();
    final newNote = Note(
      id: newId,
      title: title,
      content: content,
      createdAt: now,
      updatedAt: now,
    );

    final updatedNotes = [...state.notes, newNote];
    state = state.copyWith(notes: updatedNotes);

    await _saveToLocal(updatedNotes);
  }

  // Update an existing note
  Future<void> updateNote(int id, String title, String content) async {
    final updatedNotes = state.notes.map((note) {
      if (note.id == id) {
        return note.copyWith(
          title: title,
          content: content,
          updatedAt: DateTime.now(),
        );
      }
      return note;
    }).toList();

    state = state.copyWith(notes: updatedNotes);
    await _saveToLocal(updatedNotes);
  }

  // Delete a note
  Future<void> deleteNote(int id) async {
    final updatedNotes = state.notes.where((note) => note.id != id).toList();
    state = state.copyWith(notes: updatedNotes);
    await _saveToLocal(updatedNotes);
  }

  // Save notes to local storage
  Future<void> _saveToLocal(List<Note> notes) async {
    try {
      await _storageService.saveToLocal(notes);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  // Reset to default notes
  Future<void> resetToDefault() async {
    await loadFromAssets();
    await _storageService.saveToLocal(state.notes);
  }

  // Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider for notes
final notesProvider = StateNotifierProvider<NotesNotifier, NotesState>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return NotesNotifier(storageService);
});