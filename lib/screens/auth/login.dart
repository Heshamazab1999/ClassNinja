import 'package:class_ninja/screens/auth/share_contrl.dart';
import 'package:class_ninja/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double w=width*0.95;
  String msg="";
  var txt="مزود خدمة".obs;
  var formKey=GlobalKey<FormState>();
  double phoneH=50,passH=50;
  @override
  Widget build(BuildContext context) {
    final authController=Get.put(AuthController());

    return Directionality(textDirection: TextDirection.rtl,
      child:Scaffold(
        appBar: MainBar( "تسجيل الدخول",26,  false, true),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child:Column(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: height*0.05),
                Center(child: Input(TextInputType.phone,"رقم الجوال", authController.phone, w,phoneH,null, (val){
                  if (!RegExp(authController.validPhone).hasMatch(val)) {
                    setState(() =>phoneH=80);
                    return 'برجاء ادحال رقم صحيح';
                  }setState(() =>phoneH=50);
                },(val){})),
                SizedBox(height: 10),
                Center(child: Input(TextInputType.text,"كلمة المرور", authController.pass, w,passH, IconButton(onPressed: (){
                  setState(() =>showPass=!showPass);
                }, icon: Icon(showPass?Icons.visibility_off:Icons.visibility,color: mainColor)), (val){
                  if (val.toString().length < 8) {
                    setState(() =>passH=80);
                    return 'بجب الا تقل كلمة المرور عن 8 احرف';
                  }setState(() =>passH=50);
                },(val){})),
                // Txt(msg, Colors.red, 18, FontWeight.w600),
                Container(
                  alignment: Alignment.topLeft,
                  child: TxtBtn("استرداد كلمة المرور", mainColor,16, ()=>Get.toNamed("/email")),
                ),
                SizedBox(height: 7),
                Center(child: Btn(Obx(() => authController.loading.isTrue?CircularProgressIndicator(color: Colors.white):btnTxt("تسجيل الدخول")),
                    Colors.white, mainColor, mainColor, width*0.95, ()async{
                  // print(userController.phone.isEmpty);
                  bool? valid = formKey.currentState?.validate();
                  print(formKey.currentState?.validate());
                  if(valid==true) {
                    // print(userController.pass.value);
                    await authController.login();
                  }
                })),
                Container(
                  alignment: Alignment.topRight,
                  child: Obx((){
                    return TxtBtn(" تسجيل الدخول $txt", mainColor,16, (){
                      txt.value=txt.value=="مزود خدمة"?"فرد":"مزود خدمة";
                      authController.selectedUser.value=txt.value=="مزود خدمة"?"client":"provider";
                      print(authController.selectedUser.value);
                    });
                  }),
                ),
              ],
            ),
          ),
        ),
        ),
    );
    // Obx(() => authController.loading.isTrue?CircularProgressIndicator(color: Colors.white):
  }
}
