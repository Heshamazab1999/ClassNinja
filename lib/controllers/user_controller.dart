import 'dart:convert';

import 'package:class_ninja/controllers/location.dart';
import 'package:class_ninja/screens/auth/share_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/shared.dart';
import 'conn.dart';
class UserController extends GetxController{
  LoCation loCation=LoCation();
  var token="".obs,
      type="".obs,
      name="".obs,
      phone="".obs,
      wats="".obs,
      email="".obs,
      address="".obs,
      pass="".obs,
      img="".obs,
      addressLat=0.0.obs,
      addressLong=0.0.obs,
      loading=false.obs,
      imgFile=File("").obs,
      nameContrl=TextEditingController(),
      phoneContrl=TextEditingController(),
      watsContrl=TextEditingController(),
      emailContrl=TextEditingController(),
      addressContrl=TextEditingController(),
      pass1Contrl=TextEditingController(),
      pass2Contrl=TextEditingController();

  // final box = GetStorage();
  @override
  void onInit() async{
    await getVals();
    updateContrls();
    // TODO: implement onInit
    super.onInit();
  }
  updateContrls(){
    nameContrl.text=name.value;
    phoneContrl.text=phone.value;
    watsContrl.text=wats.value;
    emailContrl.text=email.value;
    addressContrl.text=address.value;
    pass1Contrl.clear();
    pass2Contrl.clear();
  }
  late File imgPath;
  uploadImg()async{
    final ImagePicker picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.gallery,);
    if (pickedImage != null) {
      imgFile.value =File(pickedImage.path);
      print(imgFile.value);
      img.value=imgFile.value.path;
      print(img.value);
    } else {
      print('please pick an image');
    }
  }
  getVals()async{
    final prefs = await SharedPreferences.getInstance();
    type.value=prefs.getString("type")??"";
    name.value=prefs.getString("name")??"";
    token.value=prefs.getString("token")??"";
    email.value=prefs.getString("email")??"";
    phone.value=prefs.getString("phone")??"";
    wats.value=prefs.getString("wats")??"";
    address.value=prefs.getString("address")??"";
    addressLat.value=prefs.getDouble("addressLat")??0.0;
    addressLong.value=prefs.getDouble("addressLong")??0.0;
    pass.value=prefs.getString("pass")??"";
    img.value=prefs.getString("img")??"";
  }
  storeVals()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('type', type.value);
    await prefs.setString('name', name.value);
    await prefs.setString('email', email.value);
    await prefs.setString('phone', phone.value);
    await prefs.setString('wats', wats.value);
    await prefs.setString('address', address.value);
    await prefs.setDouble('addressLat', addressLat.value);
    await prefs.setDouble('addressLong', addressLat.value);
    await prefs.setString('pass', pass.value);
    await prefs.setString('img', img.value);
    await prefs.setString('token', token.value);
  }
  resetVals()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    name.value="";
    type.value="";
    email.value="";
    phone.value="";
    wats.value="";
    addressLat.value=0.0;
    addressLong.value=0.0;
    pass.value="";
    img.value="";

  }
  saveVals(tt,t,n,e,ph,w,a,aLat,aLong,p,i)async{
    type.value=tt;
    name.value=n;
    email.value=e;
    phone.value=ph;
    wats.value=w;
    address.value=a;
    addressLat.value=aLat??0.0;
    addressLong.value=aLong??0.0;
    pass.value=p;
    img.value=i??"";
    token.value=t;
    await storeVals();
  }
  updateData(String n,String ph,String w,String e,String a,String p)async{
    bool online=await connection();
    if (online) {
      loading.value=true;
      String url ="https://glass.teraninjadev.com/api/${type.value}/update/profile",
          fileName =imgFile.value.path.split('/').last;
      print(url);
      http.MultipartRequest request =http.MultipartRequest("POST", Uri.parse(url));
      request.fields['name']=n.isEmpty?name.value:n;
      if(ph.isNotEmpty) {
        request.fields["phone"] = ph;
      }
      if(e.isNotEmpty) {
        request.fields["email"] = e;
      }
      if(w.isNotEmpty) {
        request.fields["whatsapp"] = w;
      }
      request.fields["address"]=a.isEmpty?address.value:a;
      if(p.isNotEmpty) {
        request.fields["password"] = pass.value;
        request.fields["new_password"] = p;
      }
      if(a.isNotEmpty) {
        request.fields["latitude"] = "${loCation.latitude.value}";
        request.fields["longitude"] = "${loCation.longitude.value}";
      }
      request.fields["website"]="site";
      request.fields["snap_chat"]="snap";
      request.fields["instagram"]="instgram";
      request.fields["twitter"]="twitter";
      request.fields["facebook"]="face";
      request.headers.addAll({"Accept": "application/json","Accept-Language": "en",
      'Authorization':'Bearer ${token.value}'});
      if(imgFile.value.path.isNotEmpty) {
        var length = await imgFile.value.length();
        // imgPath.value.lengthSync()
        var img = new http.MultipartFile(
            'image', imgFile.value.readAsBytes().asStream(), length,
            filename: fileName);
        request.files.add(img);
      }
      pass1Contrl.clear();
      pass2Contrl.clear();
      updateContrls();
      var response = await http.Response.fromStream(await request.send());
      var data=jsonDecode(response.body);
      print(data);
      // print(data);
      if (data['status']==1 &&data['code']==200) {
        loading.value=false;
        Popup("تم التحديث بنجاح");
        var user=data['data'];
        saveVals(type.value,token.value, user['name'], user['email'],user['phone'],
            user['whatsapp'], user['address'],user['lat'],user['long'], p.isEmpty?pass.value:p, user['image']);
      }else{
        Popup("عفوا لم يتم تحديث البيانات يرجي المحاولة لاحفا ");
        loading.value=false;
      }
      loading.value=false;
    }else{Popup(" يرجي الاتصال بالانترنت واعادة المحاولة");}
  }
}