// import 'package:class_ninja/controllers/ad_controller.dart';
// import 'package:class_ninja/widgets/shared.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// class Ads extends StatefulWidget {
//   const Ads({Key? key}) : super(key: key);
//
//   @override
//   State<Ads> createState() => _AdsState();
// }
//
// class _AdsState extends State<Ads> {
//   AdController adController=Get.put(AdController());
//   double w=width*.9;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(width: width,height: height,
//         child: SingleChildScrollView(
//           child: Column(children: [
//             SizedBox(height: 15),
//             Center(child: Txt("اضافة اعلان", mainColor, 28, FontWeight.bold)),
//             SizedBox(height: 30),
//             Center(child: Obx(() => InputFile(adController.img.value, w, 50, (){
//               adController.uploadImg();
//             }))),
//             // Center(child: Input("رفع الصورة",null, w,50,IconButton(onPressed: (){},
//             //     icon: ), (val){}, (val){})),
//             SizedBox(height: 15),
//             Center(child: Input(TextInputType.text,"اسم المنتج", adController.adName, w,50,null, (val){
//             }, (val){})),
//             SizedBox(height: 15),
//             Center(child: Input(TextInputType.number,"السعر", adController.adPrice, w,50,null, (val){
//             }, (val){})),
//             SizedBox(height: 15),
//             Center(child: Btn("ارسال",Colors.white, mainColor, mainColor, width*0.95, ()=>adController.createAd())),
//           ],),
//         ),
//
//       ),
//     );
//   }
// }
