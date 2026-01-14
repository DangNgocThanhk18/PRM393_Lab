void exercise5() {
  print('\n=== Exercise 5: Async, Future, Null Safety & Streams ===');
  String? nullableString;
  String nonNullableString = 'Hello';
  print('Length of nullable: ${nullableString?.length ?? 0}');
  print('Length of non-nullable: ${nonNullableString.length}');
  nullableString = 'Now I have value';
  print('Force unwrap: ${nullableString!}');
  fetchData();
  countStream();
}

Future<void> fetchData() async {
  print('Fetching data...');
  await Future.delayed(Duration(seconds: 2), () {
    print('Data loaded successfully!');
  });
  String result = await processData();
  print('Processed: $result');
}

Future<String> processData() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Data processed';
}

void countStream() async {
  print('Starting stream...');

  Stream<int> numberStream = Stream<int>.periodic(
    Duration(seconds: 1),
    (count) => count,
  ).take(5);

  await for (int number in numberStream) {
    print('Stream value: $number');
  }
  print('Stream finished!');
}
