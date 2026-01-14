void exercise4() {
  print('\n=== Exercise 4: Intro to OOP ===');
  Car myCar = Car('Toyota', 2020);
  myCar.displayInfo();
  Car usedCar = Car.used('Honda', 2018, 45000);
  usedCar.displayInfo();
  ElectricCar tesla = ElectricCar('Tesla', 2023, 75);
  tesla.displayInfo();
  tesla.honk();
}

class Car {
  String brand;
  int year;
  Car(this.brand, this.year);
  Car.used(this.brand, this.year, int mileage) {
    print('$brand $year has $mileage miles on it.');
  }
  void displayInfo() {
    print('This is a $brand made in $year.');
  }

  void honk() {
    print('$brand says: Beep beep!');
  }
}

class ElectricCar extends Car {
  int batteryCapacity; // in kWh

  ElectricCar(String brand, int year, this.batteryCapacity)
    : super(brand, year);

  @override
  void displayInfo() {
    print('$brand $year (Electric) with $batteryCapacity kWh battery.');
  }
}
