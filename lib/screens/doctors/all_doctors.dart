import 'dart:async';
import 'package:class_ninja/widgets/main_box.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AllDoctors extends StatelessWidget {
  AllDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(elevation: 0,backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black,),
          title: Txt("دكاترة ومستشفيات", mainColor, 24, FontWeight.bold),
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Box(""),
                  Box(""),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Box(""),
                  Box(""),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Box(""),
                  Box(""),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Box(""),
                ],
              )
            ],
          ),
        ),

      ),
    );
  }
  Widget Box(String img){
    return  GestureDetector(onTap: ()=>Get.toNamed("/details",arguments: 1),
        child: MainBox(width*0.42,img, true, "","ا.د/يوسف علي", "", "الرياض السعودية",(){}));
  }
}
