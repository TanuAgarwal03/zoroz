import 'package:flutter/material.dart';

class SortItem {
  String title;

  SortItem({required this.title});
}

class ShortBy extends StatefulWidget {
  final Function(String) onSortSelected;
  final String initialSelectedValue; // 👈 Add this line

  const ShortBy({
    super.key,
    required this.onSortSelected,
    required this.initialSelectedValue, // 👈 Include this
  });

  @override
  _ShortByState createState() => _ShortByState();
}
class _ShortByState extends State<ShortBy> {
  late String _selectedValue;
    List<SortItem> sortOptions = [
    SortItem(title: "Price - Low to High"),
    SortItem(title: "Price - High to Low"),
  ];

@override
void initState() {
  super.initState();
  _selectedValue = widget.initialSelectedValue; // 👈 Use parent value here!
}

@override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Sort By", style: Theme.of(context).textTheme.titleLarge),
          ),
          ...sortOptions.map((option) {
            return RadioListTile<String>(
              title: Text(option.title),
              value: option.title,
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value!;
                  print(_selectedValue);
                });
                widget.onSortSelected(_selectedValue); // 👈 Call the callback
                Navigator.pop(context); // 👈 Close modal after selection
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}