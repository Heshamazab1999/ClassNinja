import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/fav_controller.dart';
FavController favController=Get.put(FavController());
Widget MainBox(double w,String img,bool fav,String price,String title,String sub,String address,action){
  return Container(
      width: w,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: inputColor.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [inputColor,inputColor.withOpacity(0.4)],
          )
      ),
      // child:  new LayoutBuilder(
      // builder: (BuildContext context, BoxConstraints constraints) {
      //   double w=constraints.maxWidth >350?width*0.4:width*0.34;
      child:Column(mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(height: 110,
              width: w,
              // padding: EdgeInsets.all(5),
              // alignment: Alignment.topRight,
              decoration: BoxDecoration(color: Colors.white,
                  image: img.isNotEmpty? DecorationImage(image:NetworkImage(img),fit: BoxFit.fill):null,
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  // img.isNotEmpty?Center(child: Image(image:NetworkImage(img),width: w,height: 90,))
                  //     :SizedBox(height: 0,),
                  Positioned(top: 6,right: 6,
                      child: CircleAvatar(radius: 14,
                          backgroundColor: inputColor.withOpacity(0.8),
                          child: Center(
                            child: IconButton(icon: Icon(Icons.favorite,size: 14,
                              color: fav?Colors.red:Colors.grey,),onPressed: action),
                          )))
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          price.isNotEmpty?SingleChildScrollView(scrollDirection: Axis.horizontal,
            child:Row(
              children: [
                Txt(" $price ", mainColor, 16, FontWeight.w700),
                Txt(sub, Colors.grey, 13, FontWeight.normal),
              ],
            ),
          ):SizedBox(height: 0),
          // SizedBox(height: 6),
          // SizedBox(width:double.maxFinite,height: 20,child:
          SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: Txt(title, Colors.black, 16, FontWeight.w700)),
          address.isNotEmpty?SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: Txt(address, Color(0xffaaaaaa), 13, FontWeight.w600)):SizedBox(height: 0),
        ],
      )
  );

}
