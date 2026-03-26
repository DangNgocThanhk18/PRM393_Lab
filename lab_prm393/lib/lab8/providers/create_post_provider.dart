import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post.dart';

// State for create post form
class CreatePostState {
  final String title;
  final String body;
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const CreatePostState({
    this.title = '',
    this.body = '',
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  CreatePostState copyWith({
    String? title,
    String? body,
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return CreatePostState(
      title: title ?? this.title,
      body: body ?? this.body,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

// Notifier for create post form
class CreatePostNotifier extends StateNotifier<CreatePostState> {
  CreatePostNotifier() : super(const CreatePostState());

  void updateTitle(String title) {
    state = state.copyWith(title: title, error: null);
  }

  void updateBody(String body) {
    state = state.copyWith(body: body, error: null);
  }

  bool validate() {
    if (state.title.trim().isEmpty) {
      state = state.copyWith(error: 'Title is required');
      return false;
    }
    if (state.body.trim().isEmpty) {
      state = state.copyWith(error: 'Body is required');
      return false;
    }
    return true;
  }

  void reset() {
    state = const CreatePostState();
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String error) {
    state = state.copyWith(error: error, isLoading: false);
  }

  void setSuccess(bool success) {
    state = state.copyWith(isSuccess: success, isLoading: false);
  }
}

// Provider for create post form
final createPostProvider = StateNotifierProvider<CreatePostNotifier, CreatePostState>((ref) {
  return CreatePostNotifier();
});