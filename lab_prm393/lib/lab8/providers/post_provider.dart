import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post.dart';
import '../services/api_service.dart';

// Provider for ApiService
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// State class for posts
class PostsState {
  final List<Post> posts;
  final bool isLoading;
  final String? error;
  final bool hasMore;

  const PostsState({
    this.posts = const [],
    this.isLoading = false,
    this.error,
    this.hasMore = true,
  });

  PostsState copyWith({
    List<Post>? posts,
    bool? isLoading,
    String? error,
    bool? hasMore,
  }) {
    return PostsState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

// Notifier for managing posts
class PostsNotifier extends StateNotifier<PostsState> {
  final ApiService _apiService;

  PostsNotifier(this._apiService) : super(const PostsState());

  // Fetch all posts
  Future<void> fetchPosts() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final posts = await _apiService.fetchPosts();
      state = state.copyWith(
        posts: posts,
        isLoading: false,
        hasMore: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Add a new post (optimistic update)
  Future<void> addPost(Post newPost) async {
    // Optimistic update
    final tempId = -DateTime.now().millisecondsSinceEpoch;
    final tempPost = newPost.copyWith(id: tempId);

    state = state.copyWith(
      posts: [tempPost, ...state.posts],
    );

    try {
      final createdPost = await _apiService.createPost(newPost);

      // Replace temp post with real one
      final updatedPosts = state.posts
          .map((post) => post.id == tempId ? createdPost : post)
          .toList();

      state = state.copyWith(posts: updatedPosts);
    } catch (e) {
      // Remove temp post on error
      final updatedPosts = state.posts
          .where((post) => post.id != tempId)
          .toList();

      state = state.copyWith(
        posts: updatedPosts,
        error: 'Failed to add post: $e',
      );
      rethrow;
    }
  }

  // Update a post
  Future<void> updatePost(Post updatedPost) async {
    final oldPosts = List<Post>.from(state.posts);
    final index = state.posts.indexWhere((post) => post.id == updatedPost.id);

    if (index != -1) {
      // Optimistic update
      final updatedPosts = List<Post>.from(state.posts);
      updatedPosts[index] = updatedPost;
      state = state.copyWith(posts: updatedPosts);

      try {
        await _apiService.updatePost(updatedPost);
      } catch (e) {
        // Revert on error
        state = state.copyWith(posts: oldPosts);
        state = state.copyWith(error: 'Failed to update post: $e');
        rethrow;
      }
    }
  }

  // Delete a post
  Future<void> deletePost(int id) async {
    final oldPosts = List<Post>.from(state.posts);

    // Optimistic delete
    state = state.copyWith(
      posts: state.posts.where((post) => post.id != id).toList(),
    );

    try {
      await _apiService.deletePost(id);
    } catch (e) {
      // Revert on error
      state = state.copyWith(posts: oldPosts);
      state = state.copyWith(error: 'Failed to delete post: $e');
      rethrow;
    }
  }

  // Refresh posts
  Future<void> refresh() async {
    await fetchPosts();
  }

  // Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider for posts
final postsProvider = StateNotifierProvider<PostsNotifier, PostsState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PostsNotifier(apiService);
});