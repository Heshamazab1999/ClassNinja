
import 'package:class_ninja/widgets/bottom_bar.dart';

import 'share_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_ninja/widgets/shared.dart';
class SignSocial extends StatefulWidget {
  const SignSocial({Key? key}) : super(key: key);

  @override
  State<SignSocial> createState() => _SignSocialState();
}

class _SignSocialState extends State<SignSocial> {
  double w=width*0.95;
  @override
  Widget build(BuildContext context) {
    return  Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(appBar: MainBar("التواصل الاجتماعي",22,  false, true),
      body:SafeArea(
          child: Container(width: width,height: height,
            child: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: height*0.05),
                  Center(child: Input(TextInputType.text,"الموقع الالكتروني", authController.site, w,50,null, (val){}, (val){})),
                  SizedBox(height: 10),
                  Center(child: Input(TextInputType.text,"سناب شات", authController.snap, w,50,null, (val){}, (val){})),
                  SizedBox(height: 7),
                  Center(child: Input(TextInputType.text,"تيوتر", authController.twitter, w,50,null, (val){}, (val){})),
                  SizedBox(height: 10),
                  Center(child: Input(TextInputType.text,"انستجراب", authController.instgram, w,50,null, (val){}, (val){})),
                  SizedBox(height: 10),
                  Center(child: Input(TextInputType.text,"فيسبوك", authController.face, w,50,null, (val){}, (val){})),
                  SizedBox(height: 10),
                  Center(child:  Btn(Obx(() => authController.loading.isTrue?
                  CircularProgressIndicator(color: Colors.white):
                  btnTxt("التالي"))
                      ,Colors.white, mainColor, mainColor, width*0.95, ()async{
                    await authController.signUp();

                    // var sent=await authController.sendCode();
                    // if(sent)
                    //     Get.offNamed("/code", arguments: ["sign"]);
                    // else errMsg("عفوا حدث خطا  ");
                            // authController.loading.value=false;
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
