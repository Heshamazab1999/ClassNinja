import 'package:class_ninja/widgets/main_box.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/ad_controller.dart';
import '../../widgets/bottom_bar.dart';
class MyAds extends StatelessWidget {
  MyAds({Key? key}) : super(key: key);
  AdController adController=Get.put(AdController());
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: MainBar('اعلانتي',28, false, false),
          body: Stack(
            children: [
              Container(
                width: width,height: height,
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(child:
                Column(children: [
                  SizedBox(height: 15),
                  SizedBox(height: height*0.8,child: AdsBox())
                ],),)),
              Positioned(left: 0,bottom: 0,
                  child: BottomBar(width, [false,true,false,false])),
              Positioned(left: 6,bottom: height*0.1,
                  child: CircleAvatar(radius: 28,
                      backgroundColor: mainColor,child: IconButton(icon: Icon(Icons.add,size: 28,),
                      onPressed: ()=>Get.toNamed("/ads")))),
            ],
          ),
        ),
    );
  }
  AdsBox(){
    return  Obx(() => adController.online.isTrue?(adController.loading.isTrue?
      Center(child: CircularProgressIndicator(color: mainColor)):
      adController.myAds.length>0?
      GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent:  220,
              mainAxisSpacing: 0,crossAxisSpacing: 5,crossAxisCount: 2),
          itemCount: adController.myAds.length,
          itemBuilder: (context,i){
            var item=adController.myAds.value[i];
            String status=item['status'].toString().trim()!="accepted"?"لم يتم الموافقة بعد":"تمت الموافقة";
            // print(status);
            return  GestureDetector(onTap: (){
            }, child: MainBox(width*0.42,item['image'], false, "${item['price']}",item['title'], "", status,(){}));}
      ): Center(child: Txt("لايوجد اعلانات بعد", Colors.black, 15, FontWeight.w600))
      ): Center(child: Txt("لايوجد اتصال بالانترنت", Colors.black, 15, FontWeight.w600),));
  }
}
