import 'dart:convert';
import 'package:class_ninja/widgets/shared.dart';
import 'auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'conn.dart';

class PassController extends GetxController{
  AuthController authController=Get.put(AuthController());
  var email=TextEditingController(),
      code="".obs,
      pass1=TextEditingController(),
      pass2=TextEditingController(),
      loading=false.obs;

  resetPass()async{
    Map body={"email":email.text,"code":code.value,
      "password":pass1.text,"password_confirmation":pass2.text};
    bool done=await post("reset/password",body);
    if(done) Get.offAllNamed("/login");
    else Popup("عفوا لم يتم الطلب يرجي المحاولة لاحقا");

  }
  sendMail()async{
      bool done = await post("forget/password", {"email": email.text});
      if (done)
        Get.toNamed("/code", arguments: ["pass"]);
      else
        Popup(" عفوا لم يتم الطلب برجاء ادخال ايميل مسجل");
    }

  resendCode(String email)async{
    bool done=await post("resend/code",{"email":email});
    return done;
  }
 verifyCode()async{
    bool done=await post("verify/password/code",{"code":code.value,"email":email.text});
    if(done) Get.toNamed("/pass");
    else Popup(" عفوا الكود الذي ادخلته غير صحيح");
  }

  post(String link,Map body)async{
    String type=authController.selectedUser.value;
    String url=type=="client"?"https://glass.teraninjadev.com/api/client/":"https://glass.teraninjadev.com/api/provider/";
    print(authController.selectedUser.value);
    print(url+link);
    bool online=await connection();
    if (online)  {
    loading.value=true;
    var response=await http.post(Uri.parse(url+link),body: body,
        headers: {"Accept": "application/json","Accept-Language": "en"}
    );
    var data=jsonDecode(response.body);
    loading.value=false;
    print(data);
    return (data['status']==1 &&data['code']==200);
  } else{
      Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");
    }
}
}