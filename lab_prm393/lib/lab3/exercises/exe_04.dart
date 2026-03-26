import 'dart:async';

/// Exercise 4 – Stream Transformation
/// Goal: Use functional stream operators (map, where, etc.)
void exercise4_StreamTransformation() {
  print('\n' + '=' * 80);
  print('EXERCISE 4 – Stream Transformation');
  print('=' * 80);

  print('\n📊 Original Stream: Numbers 1-5');
  print('🔄 Applying map (square) and where (even) transformations\n');

  // Create a stream of numbers 1-5
  Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  // Apply transformations: square then filter even numbers
  Stream<int> transformedStream = numberStream
      .map((number) {
    print('  📐 Mapping: $number → ${number * number}');
    return number * number; // Square each number
  })
      .where((squaredNumber) {
    final isEven = squaredNumber % 2 == 0;
    print('  🔍 Filtering: $squaredNumber is ${isEven ? '✓ EVEN' : '✗ ODD'}');
    return isEven; // Keep only even numbers
  });

  // Alternative approach: Chain multiple transformations
  print('\n🎨 Alternative: Chain multiple transformations');
  Stream<int> alternativeStream = Stream.fromIterable([1, 2, 3, 4, 5])
      .map((n) => n * n) // Square
      .where((n) => n % 2 == 0) // Filter even
      .map((n) => n * 2); // Double for demonstration

  print('\n📡 Listening to transformed stream...\n');

  // Listen to the stream and print results
  transformedStream.listen(
        (value) {
      print('🎉 RESULT: $value (even square)');
    },
    onDone: () {
      print('\n✨ Stream completed!');
      print('\n📝 Alternative transformation results:');

      // Listen to alternative stream
      alternativeStream.listen(
            (value) {
          print('  • $value (square → filter even → double)');
        },
        onDone: () {
          print('\n✅ Exercise 4 completed!\n');
        },
      );
    },
    onError: (error) {
      print('❌ Error: $error');
    },
  );
}