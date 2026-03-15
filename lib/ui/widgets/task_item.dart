import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/app.dart';
import 'package:task_manager_with_getx/data/models/task_list_by_status_model.dart';
import 'package:task_manager_with_getx/ui/controller/update_status_controller.dart';
import 'package:task_manager_with_getx/ui/utils/task_status/task_status.dart';
import 'package:task_manager_with_getx/ui/widgets/snack_bar_message.dart';

class TaskItemWidget extends StatelessWidget {
   TaskItemWidget({
    super.key, required this.model,
  });
  final TaskModel model;
  UpdateStatusController updateStatusController = Get.find<UpdateStatusController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: Colors.white,

      child: ListTile(
        title: Text(
          model.title??' ',
          style: textTheme.titleLarge!.copyWith(fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.description??''),
            SizedBox(height: 8),
            Text(model.createdDate??'Date: 12/2/2022'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      model.status??'ErrorNew',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {
                      showdeleteAlertdialog();

                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: () async{
                      await onTapEdit();
                    }, icon: Icon( Icons.edit)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onTapEdit() async{
    final textTheme = Theme.of(MyApp.navigateKey.currentContext!).textTheme;
    showDialog(context: MyApp.navigateKey.currentContext!, builder: (context){
      return AlertDialog(

        title: Text('Update Status',),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(TaskStatus.newTask,),
              onTap: ()async{
                await updateStatus(TaskStatus.newTask);
                Get.back();

              },
            ),
            ListTile(
              title: Text(TaskStatus.completeTask),
              onTap: ()async{
                await updateStatus(TaskStatus.completeTask);
                Get.back();

              },
            ),
            ListTile(
              title: Text(TaskStatus.canceledTask,),
              onTap: ()async{
                await updateStatus(TaskStatus.canceledTask);
                Get.back();

              },
            ),
            ListTile(
              title: Text(TaskStatus.progressTask,),
              onTap: ()async{
                await updateStatus(TaskStatus.progressTask);
                Get.back();

              },
            )



          ],
        ),
      );

    });
  }

  Future<void> updateStatus(String updatedTaskStatus) async {
    if(updatedTaskStatus != model.status){
      bool isSuccess = await updateStatusController.changeStatus(sid: model.sId!, status: updatedTaskStatus);
      if(isSuccess) {
        snackBarMessage(MyApp.navigateKey.currentContext!, message: 'success');

      }
      else{
        snackBarMessage(MyApp.navigateKey.currentContext!, message: updateStatusController.errorMsg!);
      }
    }

  }

  Future<void> onTapDelete() async{
    bool isSuccess = await updateStatusController.deleteTask(sid: model.sId!);
    if(isSuccess){
      snackBarMessage(MyApp.navigateKey.currentContext!, message: 'Scuccess');
    }else{
      snackBarMessage(MyApp.navigateKey.currentContext!, message: updateStatusController.errorMsg!);
    }

  }

  void showdeleteAlertdialog() {
    showDialog(context: MyApp.navigateKey.currentContext!, builder: (context){
      return AlertDialog.adaptive(
        title: Text('Delete Alert!'),
        content: Text('Do you want to delete task?'),
        actions: [
          TextButton(onPressed: (){
            onTapDelete();

          }, child: Text('Yes')),
          TextButton(onPressed: (){
            Get.back();
          }, child: Text('No')),
        ],
      );
    });
  }
}
