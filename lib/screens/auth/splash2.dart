import 'package:class_ninja/screens/auth/share_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_ninja/widgets/shared.dart';
class Splash2 extends StatelessWidget {
  const Splash2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(elevation: 0,backgroundColor: Colors.white,
      //     title: underlineTxt( "تخطي الان ", Colors.black, 16, FontWeight.bold)),
      body: SafeArea(
        child: Container(width: width,height: height,
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 5),
              Container(padding: EdgeInsets.all(7),
                alignment: Alignment.centerLeft,
                child: SkipBtn()
              ),
              SizedBox(height: height*0.12,),
              SizedBox(width: 200,height: 200,child: Image.asset("imgs/logo.png")),
              SizedBox(height: height*0.14),
              Btn(Txt("تسجيل الدخول", Colors.black, 18, FontWeight.w600),
                  mainColor, Colors.white, mainColor, width*0.95, (){
                print(userController.phone.value);
                Get.toNamed("/login");
              }),
              SizedBox(height: 18),
              Btn(btnTxt("انشاء حساب"),  Colors.white,mainColor, mainColor, width*0.95, ()=>Get.toNamed("/signup")),
            ],
          ),
        ),
      ),

    );
  }
}
