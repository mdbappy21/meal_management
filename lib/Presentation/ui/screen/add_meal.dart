import 'package:flutter/material.dart';

class AddMeal extends StatefulWidget {
  const AddMeal({super.key});

  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Meal')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: _selectDate,
              child: Text(
                selectedDate != null
                    ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                    : 'select a date',
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.teal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Member ${index + 1}'),
                            CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: Text('2'),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.remove),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2025, 7, 25),
      firstDate: DateTime(2025, 7, 1),
      lastDate: DateTime(2025, 7, 30),
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }
}
