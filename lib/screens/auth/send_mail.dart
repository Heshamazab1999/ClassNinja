import 'package:class_ninja/controllers/resetPass_controller.dart';
import 'package:flutter/material.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  double w=width*0.95;
  String error="";
  AuthController authController=Get.put(AuthController());
  PassController passController=Get.put(PassController());
  @override
  Widget build(BuildContext context) {
    return  Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(elevation: 0,backgroundColor: Colors.white,
            leading: BackButton(color: Colors.black),
            centerTitle: true,
            title: Txt( "استرداد كلمة المرور", mainColor, 22, FontWeight.bold)),
        body:SafeArea(
          child: Container(width: width,height: height,
            child: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Padding(padding: EdgeInsets.only(right: width*0.05),child:
                  Txt("برجاء ادخال الايميل المسجل", mainColor, 18, FontWeight.w600)),
                  SizedBox(height: 15),
                  Center(child: Input(TextInputType.emailAddress,"الايميل", passController.email, w,50,null, (val){}, (val){})),
                  errMsg(error),
                  SizedBox(height: 15),
                  Center(child: Btn(
                      Obx(() => passController.loading.isTrue?CircularProgressIndicator(color: Colors.white):btnTxt("ارسال")),
                      Colors.white, mainColor, mainColor, width*0.95, ()async{
                    if(!RegExp(validEmail).hasMatch(passController.email.text)){
                      setState(() =>error='برجاء ادحال ايميل صحيح');
                    }else {
                      setState(() =>error='');
                      await passController.sendMail();
                    }
                  })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
