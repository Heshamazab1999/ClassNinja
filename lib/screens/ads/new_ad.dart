import 'package:class_ninja/controllers/ad_controller.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/bottom_bar.dart';
class NewAd extends StatefulWidget {
  const NewAd({Key? key}) : super(key: key);

  @override
  State<NewAd> createState() => _NewAdState();
}

class _NewAdState extends State<NewAd> {
  AdController adController=Get.put(AdController());
  double w=width*.9;
  var msg="".obs;
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar:  MainBar("اضافة اعلان", 24, true, false),
      body:Container(width: width,height: height,
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: 20),
            Center(child: Obx(() => InputFile(adController.img.value,inputColor, w, 50,Icons.file_upload_outlined, (){
              adController.uploadImg();
            }))),
            SizedBox(height: 15),
            Center(child: Input(TextInputType.text,"اسم المنتج", adController.adName, w,50,null, (val){
            }, (val){})),
            SizedBox(height: 15),
            Center(child: Input(TextInputType.number,"السعر", adController.adPrice, w,50,null, (val){
            }, (val){})),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Obx(() => Txt(msg.value, Colors.red, 17, FontWeight.w500)),
            ),
            SizedBox(height: 10),
            Center(child:
            Btn(Obx(() => adController.loading.isTrue?
            CircularProgressIndicator(color: Colors.white):btnTxt("ارسال")),
                Colors.white, mainColor, mainColor, width*0.95, ()async{
              if(adController.imgPath.path.isEmpty)
                msg.value="برجاء ارفاق صورة المنتج";
              else if(adController.adName.text.isEmpty)
                msg.value="برجاء ادخال اسم المنتج";
              else if(adController.adName.text.length<8)
                msg.value="يجب الا يقل اسم المنتج عن 8 احرف";
              else if(adController.adPrice.text.isEmpty)
                msg.value="برجاء ادخال سعر المنتج";
              else{
                msg.value="";
                await adController.createAd();
              }
                // await adController.getAds();
                })),
          ],),
        ),

      ),
    ));
  }
}
