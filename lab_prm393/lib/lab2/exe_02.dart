void exercise2() {
  print('\n=== Exercise 2: Collections & Operators ===');
  List<int> numbers = [10, 20, 30, 40, 50];
  print('Original list: $numbers');
  numbers.add(60);
  numbers.remove(10);
  print('After add/remove: $numbers');
  print('First element: ${numbers[0]}');
  print('List length: ${numbers.length}');
  Set<String> fruits = {'apple', 'banana', 'orange'};
  fruits.add('apple'); // Duplicate, won't be added
  fruits.add('grape');
  print('Fruits set: $fruits');
  Map<String, int> scores = {'Alice': 95, 'Bob': 87, 'Charlie': 92};
  scores['Diana'] = 88;
  print('Scores map: $scores');
  print('Bob\'s score: ${scores['Bob']}');
  int a = 15, b = 7;
  print('$a + $b = ${a + b}');
  print('$a > $b? ${a > b}');
  print('Logical AND (a>10 && b>5): ${a > 10 && b > 5}');
  String result = (a > b) ? 'a is greater' : 'b is greater';
  print('Ternary result: $result');
}
