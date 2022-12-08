
import 'package:class_ninja/controllers/location.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_bar.dart';
import 'share_contrl.dart';
import '../../widgets/shared.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  IconData passIcon=Icons.visibility_off;
  double w=width*0.95,nameH=50,emailH=50,phoneH=50,addressH=50,passH=50;
  int radioVal=0,groupVal=0;
  var formKey=GlobalKey<FormState>();
  Color btnColor=mainColor.withOpacity(0.6);
  String address="العنوان";
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
      appBar: MainBar("انشاء الحساب",27, false,true),
      body: Container(width: width,height: height,
            child: SingleChildScrollView(
              child: Form(key: formKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 5),
                    // Row(mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Txt( "انشاء الحساب", mainColor, 25, FontWeight.bold),
                    //     SizedBox(width: width*0.07),
                    //     SkipBtn()
                    //   ],),
                    SizedBox(height: height*0.05),
                    Center(child: UserDropDown()),
                    SizedBox(height: 12),
                    Center(child: Input(TextInputType.text,"اسم المستخدم", authController.username, w, nameH,null,(val){
                      if (val.toString().length < 4) {
                        setState(() =>nameH=80);
                        return 'يجب الا يقل الاسم عن 4 احرف';
                      }setState(() =>nameH=50);
                    }, (val){})),
                    SizedBox(height: 12),
                    Center(child: Input(TextInputType.emailAddress,"الايميل", authController.email, w,emailH,null, (val){
                      if (!RegExp(authController.validEmail).hasMatch(val)) {
                        setState(() =>emailH=80);
                        return 'برجاء ادحال ايميل صحيح';
                      }setState(() =>emailH=50);
                    }, (val){})),
                    SizedBox(height: 12),
                    Center(child: Input(TextInputType.phone,"رقم الجوال", authController.phone, w,phoneH,null, (val){
                      if (!RegExp(authController.validPhone).hasMatch(val)) {
                        setState(() =>phoneH=80);
                        return 'برجاء ادحال رقم صحيح';
                      }setState(() =>phoneH=50);
                    }, (val){})),
                    SizedBox(height: 12),
                    Center(child: Input(TextInputType.phone,"رقم الواتساب", authController.whatsapp, w,50,null, (val){}, (val){})),
                    SizedBox(height: 10),
                    //address
                    Center(child: Obx(() => InputFile(authController.address.value, inputColor, w,50,null, ()async{
                      await authController.getLoc();
                    }))),
                    // Center(child: Input(TextInputType.text,"العنوان", authController.address, w,addressH,null, (val){
                    //   if (val.toString().length <= 2) {
                    //     setState(() =>addressH=80);
                    //     return 'برجاء ادحال عنوان صحيح';
                    //   }setState(() =>addressH=50);
                    // }, (val){})),
                    SizedBox(height: 12),
                    //activity type
                    Obx(() => authController.selectedUser.value=="provider"?Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Center(child: activityDropDown()),
                    ):SizedBox(height: 0)),
                    SizedBox(height: 12),
                    Center(child: Obx(() => InputFile(authController.img.value,inputColor, w, 50,Icons.file_upload_outlined,
                            ()async=> await authController.uploadImg() ))),
                    SizedBox(height: 12),
                    Center(child: Input(TextInputType.text,"كلمة المرور", authController.pass, w,passH,
                        IconButton(onPressed: (){
                          setState(() =>showPass=!showPass);
                        }, icon: Icon(showPass?Icons.visibility_off:Icons.visibility,color: mainColor))
                        , (val){
                          if (val.toString().length < 8) {
                            setState(() =>passH=80);
                            return 'بجب الا تقل كلمة المرور عن 8 احرف';
                          }setState(() =>passH=50);
                        }, (val){})),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: groupVal, onChanged: (val){
                            setState(() {
                              groupVal=val!;
                            });
                          },activeColor: mainColor,),
                          Txt("اوافق علي شروط الاستخدام", mainColor,17, FontWeight.w500)
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(child:  Btn(btnTxt("التالي"),Colors.white,
                        groupVal==1?mainColor:btnColor, groupVal==1?mainColor:btnColor, width*0.95, ()async{
                      if(groupVal==1) {
                        print(authController.imgPath);
                        bool? valid = formKey.currentState?.validate();
                        if(valid==true)
                          Get.toNamed("/social");
                      }

                    })),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
      ),
    );}
}
