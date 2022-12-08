import 'package:class_ninja/screens/auth/share_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool showPass=false;
String validEmail =r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    validName = r'^[a-z A-Z]+$',
    validPhone = r'(^(?:[+0]9)?[0-9]{10,12}$)',
    imageBaseUrl = "http://success.teraninjadev.com/uploadedimages/";

double height=Get.height,
    width=Get.width;
Color mainColor=Color(0xff308E7F),
    inputColor=Color(0xffD7EEEA);

Widget Txt(String txt,Color color,double size , FontWeight weight) {
  return Text(
      txt, style: TextStyle(color: color,fontFamily: "Kufam", fontSize: size, fontWeight: weight));
}
Widget underlineTxt(String txt,Color color,double size , FontWeight weight) {
  return Text(
      txt, style: TextStyle(color: color,decoration: TextDecoration.underline,
      fontFamily: "Kufam", fontSize: size, fontWeight: weight));
}
Widget SkipBtn(){
  return GestureDetector(onTap: ()=>Get.offAllNamed("/home"),
    child: underlineTxt( "تخطي الان ", Colors.black, 16, FontWeight.bold),
  );
}
// Widget Btn(String txt,Color color,Color bgColor,Color borderColor,double width,press){
//   return ElevatedButton(
//       style: ButtonStyle(backgroundColor:MaterialStateProperty.all(bgColor),fixedSize: MaterialStateProperty.all(Size(width, 50)),
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(10),
//           side: BorderSide(color: bgColor),
//           ),
//       )),
//       onPressed:press,
//       child: Txt(txt, color, 18, FontWeight.w700));
// }
// Widget BorderBtn(String txt,Color color,Color bgColor,Color borderColor,double width,press){
//   return OutlinedButton(
//       style: OutlinedButton.styleFrom(fixedSize:Size(width, 50),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(color: bgColor,width: 5),
//       ),
//       ),
//       onPressed:press,
//       child: Txt(txt, color, 18, FontWeight.w700));
// }
Widget Btn(var child,Color color,Color bgColor,Color borderColor,double width,press){
  // bool childTxt=child is String;
  return GestureDetector(onTap: press,
      child: Container(width: width,height: 50,
          decoration: BoxDecoration(border:Border.all(color: borderColor,width: 2) ,color: bgColor,
            borderRadius: BorderRadius.circular(10),
          ), child:  Center(child: child))

  );
}
var FieldBorder=OutlineInputBorder(borderSide: BorderSide(color: inputColor,width: 1),
    borderRadius: BorderRadius.circular(10));

Widget Input(TextInputType type,String hint,var contrl,double w,double h, suffix,valid,change){
  var style=TextStyle(fontWeight: FontWeight.w600,fontFamily:"Kufam",fontSize:16,color: Colors.black);
  return SizedBox(width:w ,height: h,
    child: TextFormField(controller: contrl,keyboardType: type,obscureText: suffix==null?false:!showPass,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      style: style,
      decoration: InputDecoration(
          hintText: hint,errorBorder: FieldBorder,errorMaxLines: 1,
          hintStyle: style,
          fillColor: inputColor,filled: true,
          focusedBorder:FieldBorder,
          border:FieldBorder,enabledBorder: FieldBorder,
          // suffix: suffix,
          suffixIcon: suffix
      ),
      onChanged: change,validator: valid,
    ),
  );
}
Widget InputFile(String hint,Color color,double w,double h,var icon,tap){
  return GestureDetector(
    child: Container(width: w,height: h,
      padding: EdgeInsets.symmetric(horizontal: 10),
      // alignment: Alignment.centerRight,
      decoration: BoxDecoration(color: color,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: icon!=null?w*0.7:w*0.9,height: h,
            child:  SingleChildScrollView(scrollDirection: Axis.horizontal,
                child: Center(child: Txt(hint, Colors.black, 16, FontWeight.w600),)),
          ),
          icon!=null?Icon(icon,color: mainColor):SizedBox(width: 0)
        ],
      ),
    ),
    onTap: tap,
  );
}
Widget TxtBtn(String txt,Color color,double size,press){
  return TextButton(
      onPressed: press, child: Txt(txt, color, size, FontWeight.w600));
}
Widget btnTxt(String txt){
  return Txt(txt, Colors.white, 18, FontWeight.bold);
}
activityDropDown(){
  var change=false.obs;
  String? selectedVal="doctorHospital";
  return SizedBox(width:width*0.95 ,
      height: 55,
      child:
      Stack(
          children: [
            DropdownButtonFormField<String>(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                fillColor:inputColor,
                filled: true,
                focusedBorder:FieldBorder,
                enabledBorder:FieldBorder,
              ),
              icon: Icon(Icons.keyboard_arrow_down,size: 30,color: mainColor),
              validator: (value) { },
              elevation: 1,
              value: selectedVal??"",
              onChanged: (String? val) {
                selectedVal=val;
                change.value=true;
                authController.activity.value=val!;
              },
              items: [
                DropItem("دكاترة ومستشفيات", "doctorHospital"),
                DropItem("محلات النظارات", "shop"),
                 ],
            ),
            Obx(() =>  change.isFalse?Positioned(right: 10,bottom: 15,left: 40,
                child: Container(color: inputColor,
                  child: Txt("نوع النشاط", Colors.black, 16, FontWeight.w600),
                )):SizedBox(height: 0))
          ])
  );
}
UserDropDown(){
  var change=false.obs;
  String? selectedVal="client";
  return SizedBox(width:width*0.95 ,
      height: 55,
      child:Stack(
          children: [
            DropdownButtonFormField<String>(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                fillColor:inputColor,
                filled: true,
                focusedBorder:FieldBorder,
                enabledBorder:FieldBorder,
              ),
              icon: Icon(Icons.keyboard_arrow_down,size: 30,color: mainColor),
              validator: (value) { },
              elevation: 1,
              value: selectedVal??"",
              onChanged: (String? val) {
                selectedVal=val;
                authController.selectedUser.value=val??"user";
                change.value=true;
              },
              items: [
                DropItem("فرد","client"),
                DropItem("مزود خدمة","provider"),
              ],
            ),
            Obx(() =>  change.isFalse?Positioned(right: 10,bottom: 15,left: 40,
                child: Container(color: inputColor,
                  child: Txt("نوع المستخدم", Colors.black, 16, FontWeight.w600),
                )):SizedBox(height: 0))
          ])
  );
}
DropItem(String txt,String val){
  return DropdownMenuItem<String>(child: Container(
    alignment: Alignment.topRight,
    child: Txt(txt, Colors.black, 16, FontWeight.w600),),value: val,);

}
Widget errMsg(String error){
  return error.isNotEmpty?Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Txt(error, Colors.red, 16, FontWeight.w500),
  ): SizedBox(height: 0);
}
void Popup(String msg){
  Get.defaultDialog(backgroundColor: inputColor,
      title: ".",titleStyle: TextStyle(fontSize: 0,height: 0),
      content:  Directionality(textDirection: TextDirection.rtl,
          child: Center(child: Txt(msg, mainColor, 20, FontWeight.bold)))
  );
}
void confirmBox(String title,String msg,action){
  Get.defaultDialog(
    backgroundColor: inputColor,
    title: title,titleStyle: TextStyle(color:mainColor,fontWeight: FontWeight.w700),
      content:  Directionality(textDirection: TextDirection.rtl,
          child:Column(
            children: [
              Txt(msg, Colors.black, 18, FontWeight.w600),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 38,
                    child: Btn(btnTxt("تاكيد"),Colors.white, mainColor, mainColor, width*0.35, action),
                  ),
                  SizedBox(
                    height: 38,
                    child:Btn(Txt("الغاء",  mainColor, 18, FontWeight.w600),
                      mainColor, inputColor,mainColor, width*0.35, ()=>Get.back())),
                  // TxtBtn("تاكيد", mainColor, 18, action),
                  // TxtBtn("الغاء", Colors.black, 18, ()=>Get.back()),
                ],
              )
            ],
          ))
  );
}
