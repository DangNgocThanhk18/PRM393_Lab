import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../models/note.dart';

class StorageService {
  static const String fileName = 'notes.json';

  // Load notes from assets (Lab 9.1)
  Future<List<Note>> loadFromAssets() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/sample_notes.json');
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Note.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load notes from assets: $e');
    }
  }

  // Get path to documents directory
  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName');
  }

  // Load notes from local storage (Lab 9.2 & 9.3)
  Future<List<Note>> loadFromLocal() async {
    try {
      final file = await _getLocalFile();

      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((json) => Note.fromJson(json)).toList();
      } else {
        // If no file exists, load from assets first
        final notes = await loadFromAssets();
        await saveToLocal(notes);
        return notes;
      }
    } catch (e) {
      throw Exception('Failed to load notes from local: $e');
    }
  }

  // Save notes to local storage
  Future<void> saveToLocal(List<Note> notes) async {
    try {
      final file = await _getLocalFile();
      final jsonString = jsonEncode(notes.map((note) => note.toJson()).toList());
      await file.writeAsString(jsonString);
    } catch (e) {
      throw Exception('Failed to save notes: $e');
    }
  }

  // Check if local file exists
  Future<bool> localFileExists() async {
    final file = await _getLocalFile();
    return await file.exists();
  }

  // Delete local file
  Future<void> deleteLocalFile() async {
    final file = await _getLocalFile();
    if (await file.exists()) {
      await file.delete();
    }
  }
}