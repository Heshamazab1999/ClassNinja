import 'package:class_ninja/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../controllers/location.dart';
import '../../widgets/shared.dart';
// import '../auth/share_contrl.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final userController=Get.put(UserController());
  late File imgPath=File("");
  var msg="".obs,
      changeImg=false.obs,
      name="".obs,
      phone="".obs,
      email="".obs,
      wats="".obs,
      address="".obs,
      pass="".obs;
  String img="";
  double w=width*0.9;
  @override
  Widget build(BuildContext context) {
    userController.updateContrls();
    img=userController.img.value;
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:  AppBar(elevation: 0,backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black,),
          title: Txt("تعديل الحساب", mainColor, 24, FontWeight.bold),
        ),
        body: Container(width: width,height: height,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  //img
                  Stack(
                    children: [
                     ImgBox(),
                      Positioned(bottom: 0,left: 0,
                          child: CircleAvatar(radius: 20,backgroundColor: mainColor,
                            child: IconButton(icon: Icon(Icons.camera_alt),onPressed: ()=>uploadImg()),
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  Box("اسم المستخدم",userController.name, w, userController.nameContrl,false,(){
                    String newVal=userController.nameContrl.text.trim();
                    if(newVal!=userController.name.value.trim()){
                      if (userController.nameContrl.text.trim().length < 4)
                        msg.value='يجب الا يقل الاسم عن 4 احرف';
                      else {
                        name.value=newVal;
                        msg.value='';
                        Get.back();
                      }
                    } else {
                      userController.nameContrl.text=userController.name.value;
                      Get.back();
                    }
                  }),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Box("رقم الجوال",userController.phone, w*0.44, userController.phoneContrl,false,(){
                        String newVal=userController.phoneContrl.text.trim();
                        if(newVal!=userController.phone.value.trim()){
                          if (!RegExp(validPhone).hasMatch(newVal))
                            msg.value='برجاء ادخال رقم صحيح';
                          else {
                            phone.value=newVal;
                            msg.value='';
                            Get.back();
                          }
                        } else {
                          userController.phoneContrl.text=userController.phone.value;
                          Get.back();
                        }
                      }),
                      Box("رقم الواتساب",userController.wats, w*0.44, userController.watsContrl,false,(){
                        String newVal=userController.watsContrl.text.trim();
                        if(newVal!=userController.wats.value.trim()){
                          if (!RegExp(validPhone).hasMatch(newVal)) msg.value='برجاء ادخال رقم صحيح';
                          else {
                            wats.value=newVal;
                            msg.value='';
                            Get.back();
                          }
                        } else {
                          userController.watsContrl.text=userController.wats.value;
                          Get.back();
                        }
                      }),
                    ],
                  ),
                  Box("الايميل",userController.email, w, userController.emailContrl,false,(){
                    String newVal=userController.emailContrl.text.trim();
                    if(newVal!=userController.email.value.trim()){
                      if (!RegExp(validEmail).hasMatch(newVal))
                        msg.value='برجاء ادخال ايميل صحيح';
                      else {
                        email.value= newVal;
                        msg.value='';
                        Get.back();
                      }
                    } else {
                      userController.emailContrl.text=userController.email.value;
                      Get.back();
                    }
                  }),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt("العنوان", mainColor, 16, FontWeight.w500),
                      Container(decoration: Dec(),
                        child: Obx(() => InputFile(userController.address.value, Colors.white, w,40,null, ()async{
                          LoCation loc=LoCation();
                          await loc.getLocation();
                          await loc.goToMaps(loc.latitude.value,loc.longitude.value);
                          List data=await loc.getAdress(loc.latitude.value,loc.longitude.value);
                          print(data);
                          if(loc.latitude.value>0) {
                                userController.address.value = data[0];
                                address.value = data[0];
                              } else {
                            // userController.address.value=
                            Popup("عفوا لا يمكن الوصول للموقع حاليا");
                              }
                            })),
                      ),
                    ],
                  ),
                  // Box("العنوان",userController.address, w, userController.addressContrl,false,(){
                  //   String newVal=userController.addressContrl.text.trim();
                  //   if(newVal!=userController.address.value.trim()){
                  //     if (newVal.length < 4) msg.value='برجاء ادخال عنوان صحيح';
                  //     else {
                  //       address.value=newVal;
                  //       msg.value='';
                  //       Get.back();
                  //     }
                  //   } else {
                  //     userController.addressContrl.text=userController.address.value;
                  //     Get.back();
                  //   }
                  // }),
                  Box("كلمة المرور","********".obs, w, userController.pass1Contrl,true,(){
                    msg.value = '';
                    String oldPass=userController.pass.value.trim(),
                    pass1=userController.pass1Contrl.text.trim(),
                        pass2=userController.pass2Contrl.text.trim();
                    print(oldPass);
                    print(pass1);
                    print(pass2);
                    if(pass1!=pass2) {
                      if (pass1 != oldPass)
                        msg.value = 'كلمة المرور القديمة غير صحيحة';
                      else if (pass2.length < 8)
                        msg.value = 'يجب الا تقل كلمة المرور عن 8 احرف';
                      else {
                        msg.value = '';
                        pass.value = pass2;
                        Get.back();
                      }
                    }else  msg.value = 'ادخل كلمة مرور جديدة';
                  }),
                  // Spacer(),
                  SizedBox(height: height*0.08),
                  Btn(Obx(() => userController.loading.isTrue?CircularProgressIndicator(color: Colors.white,):btnTxt("تغيير")),
                      Colors.white, mainColor, mainColor,width, ()async{
                    bool change=name.isNotEmpty||phone.isNotEmpty||wats.isNotEmpty||email.isNotEmpty||
                        address.isNotEmpty||pass.isNotEmpty||changeImg.isTrue;
                    print(userController.token.value);
                    print(userController.pass.value);
                    print(userController.pass.value);
                    if(change){
                      await userController.updateData(name.value,phone.value,wats.value,email.value,address.value,pass.value);
                      print(userController.pass.value);
                    }
                  }),
                  SizedBox(height:5),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Dec(){
    return BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,blurRadius: 3,
            offset: Offset(0, 3))]);
  }
  Widget Box(String title,Rx<String> txt,double w,TextEditingController contrl,bool pass,save){
    var showMsg=false.obs;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(title, mainColor, 16, FontWeight.w500),
          GestureDetector(
            child: Container(width: w,height:40,
              padding: EdgeInsets.all(8),alignment: Alignment.centerRight,
              decoration: Dec(),
              child:SingleChildScrollView(
                  child:Obx(() => Txt(txt.value, Colors.black, 17, FontWeight.w600))),
            ),
            onTap: (){
              msg.value="";
              Get.defaultDialog(
                  title: " تغير $title",
                  titleStyle: TextStyle(color: mainColor,fontFamily: "Kufam",fontWeight: FontWeight.w600),
                  content: Directionality(textDirection: TextDirection.rtl,
                      child: Column(
                          children: [
                            Input(TextInputType.text,pass?"كلمة المرور القديمة":"", contrl, width*0.8, 50, null, (val){}, (val){}),
                            SizedBox(height: 10),
                            pass?Input(TextInputType.text,"كلمة المرور الجديدة",userController.pass2Contrl, width*0.8, 50, null, (val){}, (val){}):
                            SizedBox(height:2),
                            Obx(() => msg.isNotEmpty?Txt(msg.value, Colors.red, 16, FontWeight.w500)
                                :SizedBox(height: 0)),
                            SizedBox(height: 10),
                            Btn(btnTxt("حفظ"), Colors.white, mainColor, mainColor,width*0.8, save)
                          ])) );
            },
          ),
        ],
      ),
    );
  }
  Widget ImgBox(){
    print(userController.img.value);
    var img;
   setState(() {
     if(imgPath.path.isEmpty){
       if(userController.img.value.isEmpty)
         img=AssetImage("imgs/man.png");
       else img=NetworkImage(userController.img.value);
     }else img=FileImage(imgPath);
   });
    return CircleAvatar(radius: 60,backgroundColor: inputColor,
        backgroundImage:img);
  }
  uploadImg()async{
    final ImagePicker picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.gallery,);
    if (pickedImage != null) {
      setState(() =>imgPath =File(pickedImage.path));
      setState(() =>img=imgPath.path);
      userController.imgFile.value=imgPath;
      changeImg.value = true;
    } else {
      print('please pick an image');
    }
  }

}
