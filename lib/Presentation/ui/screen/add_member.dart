import 'package:flutter/material.dart';

class AddMember extends StatelessWidget {
  const AddMember({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Add Member'),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Member Email or Phone number',
                labelText: 'Enter Email/Phone'
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: (){}, child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
