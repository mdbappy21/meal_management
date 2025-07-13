import 'package:flutter/material.dart';
import 'package:meal_management/Data/models/meals_model.dart';
import 'package:meal_management/Data/models/view_meal_model.dart';

class ViewMealDetails extends StatefulWidget {
  const ViewMealDetails({super.key, required this.viewMealModel});
  final List <ViewMealModel> viewMealModel;

  @override
  State<ViewMealDetails> createState() => _ViewMealDetailsState();
}

class _ViewMealDetailsState extends State<ViewMealDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Meal Details'),
      ),
      body: ListView.builder(
        itemCount: widget.viewMealModel.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${widget.viewMealModel[index].email}', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Meals:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.viewMealModel[index].meals?.length??0,
                      itemBuilder: (context, mealIndex) {
                        return Container(
                          width: 120,
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date: ${widget.viewMealModel[index].meals?[mealIndex].date??0}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              // Text('', style: TextStyle(fontSize: 12)),
                              SizedBox(height: 4),
                              Text('Meals: ${widget.viewMealModel[index].meals?[mealIndex].count}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              // Text('2', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Total Meal: ${totalMealCalculation(widget.viewMealModel[index].meals!)}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  double totalMealCalculation(List<Meals>meals){
    double totalMeal=0;
    for(var meal in meals){
      totalMeal+=meal.count??0;
    }
    return totalMeal;
  }
}
