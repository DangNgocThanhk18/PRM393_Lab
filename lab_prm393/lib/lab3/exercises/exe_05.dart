import '../models/settings.dart';

/// Exercise 5 – Factory Constructors & Cache
/// Goal: Demonstrate singleton pattern and factory constructors
void exercise5_FactoryConstructors() {
  print('\n' + '=' * 80);
  print('EXERCISE 5 – Factory Constructors & Cache');
  print('=' * 80);

  print('\n🎯 Demonstrating Singleton Pattern with Factory Constructor\n');

  print('Creating first Settings instance:');
  final settings1 = Settings();
  settings1.theme = 'dark';
  print('  settings1.theme = "dark"');

  print('\nCreating second Settings instance:');
  final settings2 = Settings();
  print('  settings2.theme = ${settings2.theme} (should be "dark")');

  // Check if they are the same instance
  print('\n🔍 Identity Check:');
  print('  settings1 === settings2: ${identical(settings1, settings2)}');
  print('  ✅ Both variables reference the SAME instance (Singleton)');

  // Modify through second reference
  print('\nModifying settings through settings2:');
  settings2.notifications = false;
  print('  settings2.notifications = false');
  print('\nChecking settings1 values:');
  settings1.printSettings();

  print('\n' + '-' * 40);
  print('🎯 Demonstrating Factory Caching by ID\n');

  print('Creating repository "users":');
  final repo1 = CachedRepository('users');
  repo1.performAction();

  print('\nCreating repository "products":');
  final repo2 = CachedRepository('products');
  repo2.performAction();

  print('\nCreating repository "users" again:');
  final repo3 = CachedRepository('users');
  repo3.performAction();

  print('\n🔍 Identity Check:');
  print('  repo1 === repo3 (same ID): ${identical(repo1, repo3)}');
  print('  repo1 === repo2 (different IDs): ${identical(repo1, repo2)}');

  print('\n📚 EXPLANATION:');
  print('  • Factory constructors can return existing instances');
  print('  • Singleton pattern ensures only one instance exists');
  print('  • Caching by ID allows reuse of instances');
  print('  • Private constructors prevent external instantiation');

  print('\n✅ Exercise 5 completed!\n');
}