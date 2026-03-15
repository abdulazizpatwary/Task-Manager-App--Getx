
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controller/add_new_task_controller.dart';
import 'package:task_manager_with_getx/ui/screens/main_bottom_navbar.dart';
import 'package:task_manager_with_getx/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/screeen_background.dart';
import 'package:task_manager_with_getx/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_with_getx/ui/widgets/tm_app_bar.dart';


class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  static const String name = 'add-new-task';

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddNewTaskController addNewTaskController = Get.find<AddNewTaskController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TmAppBar(),
      body: ScreenBackgroundWidgets(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, top: 24, right: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 120),
                  Text('Add New Task', style: textTheme.titleLarge),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _titleTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'title'),
                    validator: (String? values) {
                      if (values?.trim().isEmpty ?? true) {
                        return 'Enter title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    maxLines: 5,
                    controller: _descriptionTEController,
                    decoration: InputDecoration(hintText: 'Description'),
                    validator: (String? values) {
                      if (values?.trim().isEmpty ?? true) {
                        return 'Enter description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  GetBuilder<AddNewTaskController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.inProgress==false,
                        replacement: CenteredProgressIndicator(),

                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _onTapAddPost();
                            }
                          },
                          child: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      );
                    }
                  ),
                  SizedBox(height: 40),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void>_onTapAddPost()async{
    Map<String,dynamic>requestBody={
      "title":_titleTEController.text.trim(),
      "description":_descriptionTEController.text.trim(),
      "status":"New"
    };
    bool isSuccess = await addNewTaskController.onCreateTask(requestBody);
    if(isSuccess){
      clearData();
      snackBarMessage(context, message: 'Success');

      Get.offAllNamed(MainBottomNavbar.name);

    }else{
      snackBarMessage(context, message: addNewTaskController.errorMsg!);
    }


  }
  void clearData(){
    _titleTEController.clear();
    _descriptionTEController.clear();
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTEController.dispose();
    _descriptionTEController.dispose();
  }
}
