import 'dart:async';

import 'package:class_ninja/controllers/get_token.dart';
import 'package:class_ninja/widgets/main_box.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AllAds extends StatelessWidget {
  AllAds({Key? key}) : super(key: key);
  var name=TextEditingController(),
      phone=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(elevation: 0,backgroundColor: Colors.white,
              leading: BackButton(color: Colors.black,),
              title: Txt("الاعلانات المميزة", mainColor, 26, FontWeight.bold),
            ),
            body:GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent:  220,
                    mainAxisSpacing: 0,crossAxisSpacing: 5,
                    // childAspectRatio: (width*0.42)/187,
                    crossAxisCount: 2),
                itemCount: 5,
                itemBuilder: (context,i){
                  return  GestureDetector(onTap: (){
                    if(userToken.isNotEmpty)
                      Popup("ينكتك الان الاستفادة من العرض");
                    else Dialog();
                  }, child: MainBox(width*0.42,"", false, "1500.00","ا.د/يوسف علي", "(للكشف)", "الرياض السعودية",(){}));}

            ))
    );
  }
  void Dialog(){
    Get.defaultDialog(
        title: "للاستفادة من الاعلان ادخل البيانات التالية ",
        titleStyle: TextStyle(color: mainColor,fontFamily: "Kufam",fontWeight: FontWeight.w600),
        content: Directionality(textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Input(TextInputType.text,"اسم المستخدم", name, width*0.8, 50, null, (val){}, (val){}),
              SizedBox(height: 10),
              Input(TextInputType.phone,"رقم الجوال", phone, width*0.8, 50, null, (val){}, (val){}),
              SizedBox(height: 10),
              Btn(btnTxt("ارسال"), Colors.white, mainColor, mainColor,width*0.8, (){
                if(name.text.isNotEmpty &&phone.text.isNotEmpty){
                  Get.back();
                  Timer(Duration(seconds: 1), ()=>Popup("ينكتك الان الاستفادة من العرض"));
                }
              })
            ],
          ),
        )
    );
  }
}
