import 'package:flutter/material.dart';

class AddCost extends StatefulWidget {
  const AddCost({super.key});

  @override
  State<AddCost> createState() => _AddCostState();
}

class _AddCostState extends State<AddCost> {
  DateTime? selectedDate;
  final List<String> _memberNameList = ['a', 'b', 'c'];

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Cost'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(onPressed: _selectDate, child: Text(selectedDate != null
                    ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                    : 'select a date',),
                ),
                DropdownMenu<String>(
                  dropdownMenuEntries: _memberNameList
                      .map((member) => DropdownMenuEntry(value: member, label: member))
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Cost',
                labelText: 'Amount',
              ),
            ),
            Row(
              children: const [
                // Add text fields if needed
              ],
            ),
            const SizedBox(height: 16),

            const SizedBox(height: 16),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                fixedSize:Size(size.width*.6,50)
              ),
              child: Text('Confirm'),
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
      firstDate: DateTime(2025,7,1),
      lastDate: DateTime(2025,7,30),
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }
}