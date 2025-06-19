import 'package:flutter/material.dart';
import 'package:meal_management/Presentation/ui/screen/add_cost.dart';
import 'package:meal_management/Presentation/ui/screen/add_meal.dart';
import 'package:meal_management/Presentation/ui/screen/send_message.dart';
import 'package:meal_management/Presentation/ui/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _addFabKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: Text('Mess-1'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SendMessage()));
          }, icon: Icon(Icons.notifications_active)),
          IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
          SizedBox(width: 8),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.green,
                child: SizedBox(
                  height: 80,
                  width: size.width / 3.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Meal",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Text('160'),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.green,
                child: SizedBox(
                  height: 80,
                  width: size.width / 3.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Cost",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Text('160'),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.green,
                child: SizedBox(
                  height: 80,
                  width: size.width / 3.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Meal Rate",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Text('160'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 20,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.teal,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: size.width * .95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Member $index'),
                          Text('Meal: 20'),
                          Text('Balance : 100'),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: 'SendMessage',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SendMessage()));
              },
              mini: true,
              backgroundColor: Colors.cyan,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.send),
            ),
            FloatingActionButton(
              heroTag: 'addCostMeal',
              key: _addFabKey,
              onPressed: () {
                final context = _addFabKey.currentContext;
                if (context == null) return;

                final RenderBox renderBox = context.findRenderObject() as RenderBox;
                final Offset offset = renderBox.localToGlobal(Offset.zero);
                final Size size = renderBox.size;

                showMenu(
                  color: Colors.cyan,
                  context: context,
                  position: RelativeRect.fromLTRB(
                    offset.dx,
                    offset.dy + size.height + 4,
                    offset.dx + size.width,
                    0,
                  ),
                  items: const [
                    PopupMenuItem(
                      value: 'cost',
                      child: Text('Cost'),
                    ),
                    PopupMenuItem(
                      value: 'meal',
                      child: Text('Meal'),
                    ),
                  ],
                ).then((value) {
                  if (value == 'cost') {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCost()));
                  }else if(value=='meal'){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMeal()));
                  }
                });

              },
              mini: true,
              backgroundColor: Colors.cyan,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}


