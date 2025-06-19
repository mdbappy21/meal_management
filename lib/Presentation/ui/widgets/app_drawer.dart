import 'package:flutter/material.dart';
import 'package:meal_management/Presentation/ui/screen/add_balance.dart';
import 'package:meal_management/Presentation/ui/screen/add_cost.dart';
import 'package:meal_management/Presentation/ui/screen/add_meal.dart';
import 'package:meal_management/Presentation/ui/screen/add_member.dart';
import 'package:meal_management/Presentation/ui/screen/change_manager.dart';
import 'package:meal_management/Presentation/ui/screen/profile.dart';
import 'package:meal_management/Presentation/ui/screen/remove_member.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader(),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Profile"),
                    leading: const Icon(Icons.person),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Text("Shaf's Bill :"),
                        Expanded(child: TextFormField())
                      ],
                    ),
                    leading: const Icon(Icons.cookie),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Text("Fridge Bill :"),
                        Expanded(child: TextFormField())
                      ],
                    ),
                    leading: const Icon(Icons.shop),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text("Add Members"),
                    leading: const Icon(Icons.people),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMember()));
                    },
                  ),
                  ListTile(
                    title: const Text("Remove Members"),
                    leading: const Icon(Icons.people),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RemoveMember()));
                    },
                  ),
                  ListTile(
                    title: const Text("Add Balance"),
                    leading: const Icon(Icons.money),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBalance()));
                    },
                  ),
                  ListTile(
                    title: const Text("Add Meal"),
                    leading: const Icon(Icons.add_circle_outline),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMeal()));
                    },
                  ),
                  ListTile(
                    title: const Text("Add Cost"),
                    leading: const Icon(Icons.add_circle_outline),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCost()));
                    },
                  ),  ListTile(
                    title: const Text("Day left"),
                    leading: const Icon(Icons.date_range),
                    trailing: Text('16'),
                    onTap: () {},
                  ),  ListTile(
                    title: const Text("Change Manager"),
                    leading: const Icon(Icons.person),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeManager()));
                    },
                  ),  ListTile(
                    title: const Text("Cost History"),
                    leading: const Icon(Icons.download),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text("My Meal"),
                    leading: const Icon(Icons.download),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text("Start New Month"),
                    leading: const Icon(Icons.skip_next),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text("Previous Month"),
                    leading: const Icon(Icons.skip_previous),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text("Dark Mode"),
                    leading: const Icon(Icons.dark_mode),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text("Logout"),
                    leading: const Icon(Icons.logout),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          _buildDeveloperInfo(),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: Colors.teal),
      child: Row(
        children: [
          Image.asset('assets/images/logo.png', width: 100, height: 100),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Mess-1'), Text('Month: June')],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [
          const Text(
            "Developer : Md Bappy",
            style: TextStyle(color: Colors.grey),
          ),
          const Text(
            "Contact: mdbappy21.cse@gmail.com",
            style: TextStyle(color: Colors.grey),
          ),
          const Text(
            "Version 1.0.0",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}