void exercise3() {
  print('\n=== Exercise 3: Control Flow & Functions ===');
  int score = 85;
  print('Score: $score');
  if (score >= 90) {
    print('Grade: A');
  } else if (score >= 80) {
    print('Grade: B');
  } else if (score >= 70) {
    print('Grade: C');
  } else {
    print('Grade: F');
  }
  String day = 'Wednesday';
  print('Day: $day');
  switch (day) {
    case 'Monday':
      print('Start of work week');
      break;
    case 'Wednesday':
      print('Midweek!');
      break;
    case 'Friday':
      print('Weekend is near!');
      break;
    default:
      print('Regular day');
  }
  List<String> colors = ['red', 'green', 'blue', 'yellow'];

  print('For loop:');
  for (int i = 0; i < colors.length; i++) {
    print('Color $i: ${colors[i]}');
  }

  print('For-in loop:');
  for (String color in colors) {
    print('Color: $color');
  }

  print('forEach:');
  colors.forEach((color) => print('Color: $color'));

  // 4. Functions
  print('Function results:');
  print('Sum of 5 and 3: ${addNumbers(5, 3)}');
  print('Product of 4 and 7: ${multiply(4, 7)}');
}

int addNumbers(int a, int b) {
  return a + b;
}

int multiply(int a, int b) => a * b;
