import 'package:get/get.dart';

class NavController extends GetxController{
  int _index=0;
  int get index=>_index;
  void changeIndex(int index){
    _index=index;
    update();
  }

}
