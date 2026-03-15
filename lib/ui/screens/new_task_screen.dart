import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/task_count_by_status.dart';
import 'package:task_manager_with_getx/data/models/task_list_by_status_model.dart';
import 'package:task_manager_with_getx/ui/controller/new_task_controller.dart';
import 'package:task_manager_with_getx/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/screeen_background.dart';
import 'package:task_manager_with_getx/ui/widgets/snack_bar_message.dart';

import '../widgets/task_item.dart';
import '../widgets/task_status_summary_counter.dart';
import '../widgets/tm_app_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TaskController newTaskController = Get.find<TaskController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newTaskController.loadNewTaskScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(),
      body: ScreenBackgroundWidgets(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<TaskController>(
              builder: (controller) {
                if(controller.taskStatusCountInProgress){
                  return CenteredProgressIndicator();
                }
                return Column(
                  children: [
                    _buildTaskStatusCount(),
                    SizedBox(height: 8),
                    _newTaskList(),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );

  }


  Widget _newTaskList() {
    return GetBuilder<TaskController>(
      builder: (controller) {
        return ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: controller.taskListByStatusModel?.taskListbyStatus?.length??0,
          itemBuilder: (context, index) {
            TaskModel model =controller.taskListByStatusModel!.taskListbyStatus![index];
            return TaskItemWidget(model:model,);
          },
        );
      }
    );
  }

  Widget _buildTaskStatusCount() {
    return SizedBox(
      height: 88,
      child: GetBuilder<TaskController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.taskCountByStatusModel?.statusCountList?.length??0,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              StatusCountModel model = controller.taskCountByStatusModel!.statusCountList![index];
              return TaskStatusSummaryCounter(model: model,);
            },
          );
        }
      ),
    );
  }
}

