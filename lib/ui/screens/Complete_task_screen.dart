import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/task_list_by_status_model.dart';
import 'package:task_manager_with_getx/ui/controller/new_task_controller.dart';
import 'package:task_manager_with_getx/ui/utils/task_status/task_status.dart';
import 'package:task_manager_with_getx/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/screeen_background.dart';
import 'package:task_manager_with_getx/ui/widgets/snack_bar_message.dart';

import '../widgets/task_item.dart';
import '../widgets/tm_app_bar.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  TaskController completeTaskController = Get.find<TaskController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskListByStatus();
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
                return Visibility(
                  visible: controller.taskListByStatusProgress==false,
                    replacement: CenteredProgressIndicator(),
                    child: _newTaskList());
              }
            ),
          ),
        ),
      ),
    );
  }
  Future<void>taskListByStatus()async{
    bool isSuccess =await completeTaskController.getTaskListByStatus(status: TaskStatus.completeTask);
    if(isSuccess){
      snackBarMessage(context, message: 'Succeess');
    }else{
      snackBarMessage(context, message: completeTaskController.errorMsg!);
    }
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
            return TaskItemWidget(model: model,);
          },
        );
      }
    );
  }
}

