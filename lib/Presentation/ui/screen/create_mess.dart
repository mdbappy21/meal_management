import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Presentation/ui/screen/home_screen.dart';

class CreateMess extends StatefulWidget {
  const CreateMess({super.key});

  @override
  State<CreateMess> createState() => _CreateMessState();
}

class _CreateMessState extends State<CreateMess> {
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Image.asset('assets/images/logo.png',height: 120,),
            const SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Mess Name',
                labelText: 'Mess Name'
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: _selectDate,
              child: Text(
                selectedDate != null
                    ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                    : 'select a date',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: (){
              Get.to(()=>HomeScreen());
            }, child: Text('Confirm'))
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
