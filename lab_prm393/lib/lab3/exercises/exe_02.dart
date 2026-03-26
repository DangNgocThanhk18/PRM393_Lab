import '../repositories/user_repository.dart';
import '../models/user.dart';

/// Exercise 2 – User Repository with JSON
/// Goal: Practice JSON serialization/deserialization
void exercise2_UserRepository() async {
  print('\n' + '=' * 80);
  print('EXERCISE 2 – User Repository with JSON');
  print('=' * 80);

  final repository = UserRepository();

  print('\n👥 Fetching users...');
  final users = await repository.getUsers();

  print('\n✅ Users successfully parsed:');
  for (var i = 0; i < users.length; i++) {
    print('  ${i + 1}. ${users[i]}');
  }

  // Demonstrate manual JSON parsing
  print('\n📝 Demonstrating manual JSON to User conversion:');
  final sampleJson = {
    'name': 'Test User',
    'email': 'test@example.com',
  };
  final testUser = User.fromJson(sampleJson);
  print('  JSON: $sampleJson');
  print('  Parsed: $testUser');

  print('\n✅ Exercise 2 completed!\n');
}