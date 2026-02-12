import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Exercise2Page extends StatelessWidget {
  const Exercise2Page({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Exercise 2 – Input Widgets: Slider, Switch, RadioListTile, DatePicker",
        ),
      ),
      body: const InputControlsDemo(),
    );
  }
}

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});
  State<InputControlsDemo> createState() => ControlPage();
}

class ControlPage extends State<InputControlsDemo> {
  double _currentSliderValue = 50;
  bool currentSwitchValue = true;
  String? _genreType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingSlider(
          value: _currentSliderValue,
          onChanged: (value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
        ActiveSwitch(
          value: currentSwitchValue,
          onChanged: (value) {
            setState(() {
              currentSwitchValue = value;
            });
          },
        ),
        GenreRadioGroup(
          selectedValue: _genreType,
          onChanged: (value) {
            setState(() {
              _genreType = value;
            });
          },
        ),
        DatePicker(),
      ],
    );
  }
}

class GenreRadioGroup extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const GenreRadioGroup({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Genre (RadioListTile)",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          RadioListTile<String>(
            title: const Text("Action"),
            value: "Action",
            groupValue: selectedValue,
            onChanged: onChanged,
          ),
          RadioListTile<String>(
            title: const Text("Comedy"),
            value: "Comedy",
            groupValue: selectedValue,
            onChanged: onChanged,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              selectedValue != null
                  ? 'Selected genre: ${selectedValue}'
                  : 'Selected genre: None',
            ),
          ),
        ],
      ),
    );
  }
}

class ActiveSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const ActiveSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Active (Switch)",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: const Text("Is movie active?"),
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class RatingSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const RatingSlider({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Rating (Slider)",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Slider(value: value, max: 100, onChanged: onChanged),
          Text("Current value: ${value.toStringAsFixed(0)}"),
        ],
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2026, 1, 1),
      firstDate: DateTime(1990),
      lastDate: DateTime(2027),
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: <Widget>[
        OutlinedButton(
          onPressed: _selectDate,
          child: const Text('Select Date'),
        ),
        Text(
          selectedDate != null
              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
              : 'No date selected',
        ),
      ],
    );
  }
}
