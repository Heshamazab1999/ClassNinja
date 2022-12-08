import 'dart:async';
import 'package:class_ninja/controllers/get_token.dart';
import 'package:class_ninja/widgets/main_box.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/fav_controller.dart';
class AllGlasses extends StatelessWidget {
  AllGlasses({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FavController favController=Get.put(FavController());
    List data=Get.arguments;
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(elevation: 0,backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black,),
          title: Txt("محلات النظارات", mainColor, 24, FontWeight.bold),
        ),
        body:GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent:  220,
                  mainAxisSpacing: 0,crossAxisSpacing: 5,crossAxisCount: 2),
              itemCount: data.length,
              itemBuilder: (context,i){
                return  GestureDetector(onTap: ()async{
                  print(data[i]['provider']['id']);
                 Get.toNamed("/details",arguments: data[i]['provider']['id']);
                },child: MainBox(width*0.42,data[i]['image'], false,"${data[i]['price']}",
                    data[i]['title'], "", data[i]['address']??"",(){
                  if(userType.value=="client") {
                      confirmBox(
                          "اضافة الاعلان", "هل تريد اضافة الاعلان الي المفضلة",
                          () async {
                        Get.back();
                        await favController.addFav("${data[i]['id']}");
                      });
                    }
                  }));}

        ),

      ),
    );
  }
  // Widget Box(String img){
  //   return  GestureDetector(onTap: ()=>Get.toNamed("/details"),
  //       child: MainBox(width*0.42,img, true, "","ا.د/يوسف علي", "", "الرياض السعودية"));
  // }
}
