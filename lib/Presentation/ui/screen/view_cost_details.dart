import 'package:flutter/material.dart';
import 'package:meal_management/Data/models/view_cost_model.dart';

class ViewCostDetails extends StatefulWidget {
  const ViewCostDetails({super.key, required this.viewCostModel});

  final List<ViewCostModel> viewCostModel;

  @override
  State<ViewCostDetails> createState() => _ViewCostDetailsState();
}

class _ViewCostDetailsState extends State<ViewCostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Cost Details')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.viewCostModel.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Date: ${widget.viewCostModel[index].date}'),
                          Text('Amount: ${widget.viewCostModel[index].amount}'),
                        ],
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
}
