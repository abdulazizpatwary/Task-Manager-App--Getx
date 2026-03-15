import 'package:flutter/material.dart';
import 'package:task_manager_with_getx/data/models/task_count_by_status.dart';

class TaskStatusSummaryCounter extends StatelessWidget {
   TaskStatusSummaryCounter({
    super.key, required this.model,
  });
   final StatusCountModel model;


  @override
  Widget build(BuildContext context) {
    final textTheme =Theme.of(context).textTheme;
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8,right: 48,top: 8,bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.sum.toString(), style: textTheme.titleLarge,),
            Text(model.sId??' ', style: textTheme.titleSmall,)
          ],
        ),
      ),
    );
  }
}
