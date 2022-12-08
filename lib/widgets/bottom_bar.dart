import 'package:class_ninja/controllers/get_token.dart';
import 'package:class_ninja/controllers/user_controller.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
UserController userController=UserController();
Widget BottomBar(double w,List active){
  bool client=userController.type.value=="client",
       provider=userType.value.trim()=="provider",
       hideAd=client==true || userToken.value.isEmpty;
  return Container(width: w,color: Colors.white,
      padding: EdgeInsets.only(top: 5),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Item(Icons.home_filled, 'الرئيسية', "/home", active[0]),
          !provider?SizedBox(width: 0):Item(Icons.add_box, 'اعلانتي', "/myAds", active[1]),
          provider?SizedBox(width: 0):Item(Icons.favorite, 'المفضلة', "/fav", active[2]),
          Item(Icons.person, 'الملف', "/profile",active[3]),
        ],
      ));
}
Widget Item(IconData icon,String txt,String route,bool active){
  return GestureDetector(
    child: Container(width: width*0.33,
      child: Column(
        children: [
          Icon(icon,color:active?mainColor:mainColor.withOpacity(0.5)),
          Txt(txt, active?mainColor:Colors.white, 16, FontWeight.w500)
        ],
      ),
    ),
    onTap: ()=>Get.offNamed("$route"),
  );
}
MainBar(String txt,double size,bool back,bool action){
  return AppBar(centerTitle: true, leading: back?BackButton(color: mainColor):null,
    backgroundColor: Colors.white,elevation: 0,
    title: Txt(txt, mainColor, size, FontWeight.bold),
    actions: action?[Padding(padding: EdgeInsets.only(top:16),child: SkipBtn())]:[]
  );
}