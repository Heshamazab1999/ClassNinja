import 'dart:convert';
import 'package:class_ninja/controllers/get_token.dart';
import 'package:class_ninja/controllers/user_controller.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'conn.dart';
import 'dart:io';

import 'location.dart';
class AuthController extends GetxController{
  UserController userController=Get.put(UserController());
  LoCation loCation=LoCation();
  String validEmail =r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      validName = r'^[a-z A-Z]+$',
      validPhone = r'(^(?:[+0]9)?[0-9]{10,12}$)',
      imageBaseUrl = "http://success.teraninjadev.com/uploadedimages/";
  var username=TextEditingController(),
      phone=TextEditingController(),
      email=TextEditingController(),
      pass=TextEditingController(),
      pass2=TextEditingController(),
      address="العنوان".obs,
      email2="".obs,
      img="الشعار".obs,
      imgPath=File("").obs,
      logo="".obs,
      code="".obs,
      token="".obs,
      selectedUser="client".obs,
      activity="doctorHospital".obs,
      whatsapp=TextEditingController(),
      site=TextEditingController(),
      snap=TextEditingController(),
      twitter=TextEditingController(),
      face=TextEditingController(),
      instgram=TextEditingController();
  var loading=false.obs,registered=false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  resetVals(){
    username.clear();
    email.clear();
    phone.clear();
    whatsapp.clear();
    site.clear();
    snap.clear();
    twitter.clear();
    face.clear();
    instgram.clear();
    img.value="الشعار";
    address.value="العنوان";
    logo.value="";
    code.value="";
    pass.clear();
    token.value="";
  }
  uploadImg()async{
    final ImagePicker picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.gallery,);
    if (pickedImage != null) {
      imgPath.value =File(pickedImage.path);
      img.value=imgPath.value.path.split('/').last;
      print("file");
      print(imgPath.value);
    } else {
      print('please pick an image');
    }
  }
  getLoc()async{
    var result=await loCation.getLocation();
    await loCation.goToMaps(loCation.latitude.value,loCation.longitude.value);
    List data=await loCation.getAdress(loCation.latitude.value,loCation.longitude.value);
    print(data);
    if(loCation.latitude.value>0)
      address.value=data[0];
    else Popup("عفوا لا يمكن الوصول للموقع حاليا");
  }
  signUp()async{
    loading.value=true;
    print(selectedUser.value);
    bool online=await connection();
    if (online) {
      print(pass.text);
      String url ="https://glass.teraninjadev.com/api/${selectedUser.value}/register",
          fileName =imgPath.value.path.split('/').last;
      http.MultipartRequest request =http.MultipartRequest("POST", Uri.parse(url));
      request.fields['name']=username.text;
      request.fields["phone"]=phone.text;
      request.fields["email"]=email.text;
      request.fields["whatsapp"]=whatsapp.text;
      request.fields["address"]=address.value;
      request.fields["lat"] = "${loCation.latitude.value}";
      request.fields["long"] = "${loCation.longitude.value}";
      request.fields["password"]=pass.text;
      request.fields["password_confirmation"]=pass.text;
      request.fields["activity"]=activity.value;
      request.fields["activity_id"]="1";
      // request.fields["type"]=activity.value;
      request.fields["website"]=site.text.isEmpty?"site":site.text;
      request.fields["snap_chat"]=snap.text.isEmpty?"snap":snap.text;
      request.fields["instagram"]=instgram.text.isEmpty?"instgram":instgram.text;
      request.fields["twitter"]=twitter.text.isEmpty?"twitter":twitter.text;
      request.fields["facebook"]=face.text.isEmpty?"face":face.text;
      if(imgPath.value.path.isNotEmpty) {
        var length = await imgPath.value.length();
        // imgPath.value.lengthSync()
        var img = new http.MultipartFile('image', imgPath.value.readAsBytes().asStream(), length,filename: fileName);
        request.files.add(img);
      }
      // var response=await request.send();
      //   var data=jsonDecode(await response.stream.bytesToString());
      var response = await http.Response.fromStream(await request.send());
      var data=jsonDecode(response.body);
      loading.value=false;
        print(data);
        if (data['status']==1 &&data['code']==200) {
          email2.value=email.text;
          logo.value=data['data']['image']??"";
          Get.toNamed("/code", arguments: ["sign"]);
        }else{
          Popup("عفوا لم يتم التسجيل يرجي الناكد من عدم استخدام بيانات مسجلة من قبل ");
          // loading.value=false;
        }
    }else{Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");}
    loading.value=false;
  }
  login()async{
    print(selectedUser.value);
    loading.value=true;
    String url="https://glass.teraninjadev.com/api/${selectedUser.value}/login";
    print(url);
    bool online=await connection();
    if (online) {
      var response=await http.post(Uri.parse(url),
          body: {"phone":phone.text,"password":pass.text},
          headers: {
            "Accept": "application/json",
            "Accept-Language": "en",
          }
      );
      var data=jsonDecode(response.body);
      loading.value=false;
      print(data);
      if (data['status']==1 &&data['code']==200) {
        var userData=data['data']['user'];
        userToken.value=data['data']['token'];
        userType.value=selectedUser.value;
        await saveToken();
        await userController.saveVals(selectedUser.value,data['data']['token'],userData['name'], userData['email'], userData['phone'],
            userData['whatsapp'],address.value ,userData['lat'],userData['long'], pass.text,userData['image']??"");
        resetVals();
        Get.offAllNamed("/home");
      }
      else{
        Popup("عفوا لم يتم الدخول يرجي التاكد من البيانات والمحاولة لاحقا");
        // loading.value=false;
      }
    }else{ Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");}
    loading.value=false;
  }
  verifyEmail()async{
    print("=========================");
    print(email.text);
    print(code.value);
    bool online=await connection();
    if (online)  {
      loading.value=true;
      String url="https://glass.teraninjadev.com/api/${selectedUser.value}/verify/code";
      print(url);
      var response=await http.post(Uri.parse(url),
          body: {"email":email.text,"code":code.value},
          headers: {"Accept": "application/json","Accept-Language": "en"}
      );
      var data=jsonDecode(response.body);
      print(data);
      if (data['status']==1 &&data['code']==200) {
      await login();
      }else{
        loading.value=false;
        Popup("عفوا تعذر تفعيل الحساب يرجي المحاولة لاحقا");
      }
    }else{ Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");}
  }
  leave(bool logout)async{
    print(userController.token.value);
    print(userController.type.value);
    bool online=await connection();
    if (online)  {
    bool done=false;
    String url="https://glass.teraninjadev.com/api/${userController.type.value}/",
    link="logout";
    print(url+link);
    var head={"Accept": "application/json","Accept-Language": "en",
      'Authorization':'Bearer ${userController.token.value}'};
    var response;
    if(logout==true){
      response=await http.post(Uri.parse(url+link),headers: head);
    }else{
      //remove account
      link="delete/me";
      response=await http.delete(Uri.parse(url+link),headers: head);
    }
    var data=jsonDecode(response.body);
    print(data);
    done=(data['status']==1 &&data['code']==200);
    if (done) {
      Get.offAllNamed("/splash");
      userToken.value="";
      userController.resetVals();
    }else{ Popup("عفوا لم يتم الطلب يرجي المحاولة لاحقا");}
  }else{Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");}
 }
}