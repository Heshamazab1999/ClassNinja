import 'dart:async';
import 'package:class_ninja/controllers/get_token.dart';
import 'package:class_ninja/widgets/main_box.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/fav_controller.dart';
class HomeAds extends StatelessWidget {
  HomeAds({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final favController=Get.put(FavController());
    bool shop=Get.arguments[0];
    List data=Get.arguments[1];
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(elevation: 0,backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black,),
          title: Txt(shop?"محلات النظارات":" دكاترة ومستشفيات ", mainColor, 24, FontWeight.bold),
        ),
        body:data.length>0?GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent:  220,
                mainAxisSpacing: 0,crossAxisSpacing: 5,crossAxisCount: 2),
            itemCount: data.length,
            itemBuilder: (context,i){
              print(data[i]['title']);
              print(data[i]['favourite']);
              bool fav=data[i]['favourite']==true;
              String adrs=data[i]['provider']['address'],
              address=adrs.trim()=="العنوان"?"":adrs;

              return  GestureDetector(onTap: ()async{
                print(data[i]['provider']['id']);
                Get.toNamed("/details",arguments: data[i]['provider']['id']);
              },child: MainBox(width*0.42,data[i]['image'], fav,"${data[i]['price']}",
                  data[i]['title'], shop?"":"(للكشف)", address,(){
                    if(userType.value=="client") {
                      confirmBox(
                          "اضافة الاعلان", "هل تريد اضافة الاعلان الي المفضلة",
                              () async {
                            Get.back();
                            print(data[i]['id']);
                            await favController.addFav("${data[i]['id']}");
                          });
                    }
                  }));}

        ):Center(child: Txt("لايوجد اعلانات بعد", Colors.black, 17, FontWeight.w600),)

      ),
    );
  }

}
