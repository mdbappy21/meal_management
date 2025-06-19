import 'package:flutter/material.dart';

class ChangeManager extends StatelessWidget {
  const ChangeManager({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Current Manager: '),
                  Text('A'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                primary: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Member $index'),
                          IconButton(onPressed: (){}, icon: Icon(Icons.star_border))
                        ],
                      ),
                    ),
                  );
                },),
            )
          ],
        ),
      ),
    );
  }
}
