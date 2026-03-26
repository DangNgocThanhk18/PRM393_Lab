/// Settings class demonstrating singleton pattern with factory constructor
class Settings {
  // Static instance variable (singleton instance)
  static Settings? _instance;

  // Private constructor (can't be called from outside)
  Settings._internal() {
    print('  🔧 Settings._internal() called - Creating singleton instance');
  }

  /// Factory constructor that returns cached instance
  factory Settings() {
    print('  🏭 Factory constructor called');
    _instance ??= Settings._internal();
    return _instance!;
  }

  // Instance variables
  String theme = 'light';
  bool notifications = true;
  int fontSize = 14;

  void printSettings() {
    print('    Theme: $theme');
    print('    Notifications: $notifications');
    print('    Font Size: $fontSize');
  }
}

/// Another example: Cached Repository with factory constructor
class CachedRepository {
  static final Map<String, CachedRepository> _cache = {};
  final String id;

  // Private constructor
  CachedRepository._internal(this.id);

  /// Factory constructor that returns cached instances by ID
  factory CachedRepository(String id) {
    print('  🏭 Factory constructor for repository: $id');
    return _cache.putIfAbsent(id, () => CachedRepository._internal(id));
  }

  void performAction() {
    print('  Repository $id is performing an action');
  }
}