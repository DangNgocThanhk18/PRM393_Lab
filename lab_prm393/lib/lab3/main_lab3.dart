import 'exercises/exe_01.dart';
import 'exercises/exe_02.dart';
import 'exercises/exe_03.dart';
import 'exercises/exe_04.dart';
import 'exercises/exe_05.dart';

/// Main function to run all exercises
/// This demonstrates 5 advanced Dart concepts:
/// 1. Product Model & Repository (Futures + Streams)
/// 2. User Repository with JSON (Serialization)
/// 3. Async + Microtask Debugging (Event Loop)
/// 4. Stream Transformation (map, where)
/// 5. Factory Constructors & Cache (Singleton)
void main() async {
  print('\n' + '╔' + '═' * 78 + '╗');
  print('║' + ' ' * 20 + 'ADVANCED DART PRACTICE EXERCISES' + ' ' * 28 + '║');
  print('╚' + '═' * 78 + '╝');
  print('\n📘 This program demonstrates 5 advanced Dart concepts:');
  print('   1. Product Model & Repository (Futures + Streams)');
  print('   2. User Repository with JSON (Serialization)');
  print('   3. Async + Microtask Debugging (Event Loop)');
  print('   4. Stream Transformation (map, where)');
  print('   5. Factory Constructors & Cache (Singleton)');
  print('\n' + '─' * 80);

  // Run Exercise 1
  exercise1_ProductRepository();
  await Future.delayed(const Duration(milliseconds: 100));

  // Run Exercise 2
  exercise2_UserRepository();
  await Future.delayed(const Duration(milliseconds: 100));

  // Run Exercise 3 (synchronous)
  exercise3_AsyncMicrotaskDebugging();
  await Future.delayed(const Duration(milliseconds: 100));

  // Run Exercise 4
  exercise4_StreamTransformation();
  await Future.delayed(const Duration(seconds: 1));

  // Run Exercise 5
  exercise5_FactoryConstructors();

  print('╔' + '═' * 78 + '╗');
  print('║' + ' ' * 25 + 'ALL EXERCISES COMPLETED! 🎉' + ' ' * 28 + '║');
  print('╚' + '═' * 78 + '╝');
  print('\n📌 Summary of Concepts Learned:');
  print('  ✓ Futures for async operations');
  print('  ✓ Streams for real-time data');
  print('  ✓ JSON serialization/deserialization');
  print('  ✓ Event loop and microtasks');
  print('  ✓ Stream transformations (map, where)');
  print('  ✓ Factory constructors and singleton pattern');
  print('  ✓ Caching mechanism with factory constructors\n');
}