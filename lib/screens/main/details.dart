import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/details_Controller.dart';
import '../../controllers/location.dart';
import '../../widgets/shared.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final contrl=Get.put(DetailsController());
  double w=width*0.9;
  int providerId=Get.arguments;
  @override
  void initState(){
    contrl.getData(providerId);
    super.initState();
    // await loc.goToMaps();
    // address=loc.getAdress(loc.latitude.value,loc.longitude.value);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(elevation: 0,
          leading: BackButton(color: Colors.black),
          title: null,backgroundColor: Colors.white,
        ),
        body: Center(
          child: Obx(() =>
          contrl.loading.isTrue?CircularProgressIndicator(color: mainColor):
          contrl.data.isNotEmpty?SingleChildScrollView(child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 150,width: w,
                  decoration: BoxDecoration(color: inputColor,
                      image: DecorationImage(image: NetworkImage(contrl.data['image']??""),fit:BoxFit.fill),
                      borderRadius: BorderRadius.circular(10))),
              SizedBox(height: 20),
              Container(width: w,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: inputColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Txt(contrl.data.value['name'], Colors.black, 18, FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Container(height: 1,width: w,color: mainColor),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          contact(contrl.data.value['phone'],  Colors.blue, true),
                          Container(height: 60,width: 1,color: mainColor),
                          contact(contrl.data.value['whatsapp'],  Colors.green, false)
                        ],
                      ),
                      Container(height: 1,width: w,color: mainColor),
                      ListTile(
                        leading: Image.asset("imgs/map.png",width: 40,height: 45,),
                        title: Column(
                          children: [
                            // Txt(contrl.data.value['address'], Colors.black, 17, FontWeight.w700),
                            Address(contrl.address1),
                            SizedBox(height: 3,),
                            Directionality(textDirection: TextDirection.ltr,
                              child: Address(contrl.address2)
                            ),
                          ],
                        ),
                        onTap: ()async{
                          await contrl.goToMap();
                        },
                      )
                    ]),
              ),
              SizedBox(height: 20),
              Container(height: 200,width: w,
                  decoration: BoxDecoration(color: Colors.white,
                      image: DecorationImage(image: AssetImage("imgs/sale.png"),fit:BoxFit.fill),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft:Radius.circular(10) ))),
              SizedBox(height: 20),
              Container(height: 150,width: w,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: inputColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Txt("يمكنك متابعتنا علي مواقع التواصل الاجتماعي", Colors.black, 17, FontWeight.bold),
                  SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Social("www",contrl.data.value['website']),
                      Social("twitter",contrl.data.value['twitter']),
                      Social("snapchat",contrl.data.value['snap_chat']),
                      Social("insta",contrl.data.value['instagram']),
                      Social("face",contrl.data.value['facebook']),

                    ],
                  )
                ]),
              ),
            ],),):Txt("عفوا حدث خطا ما", Colors.black, 17, FontWeight.w600),

          )),
      ),
    );
  }
  Widget contact(String phone,Color color,bool tel){
    return SizedBox(width: w*0.45,height: 60,
      child: SingleChildScrollView(scrollDirection: Axis.horizontal,
          child:GestureDetector(
            child: Row(
              children: [
                CircleAvatar(radius: 16,backgroundColor: color,child: Icon(Icons.call,color: Colors.white)),
                SizedBox(width: 5),
                Txt(phone, Colors.black, 18, FontWeight.w600),
              ],
            ),
            onTap: (){
              if(tel) launch("tel://$phone");
              else contrl.whatsLauncher(phone);
            },
          )),
    );
  }
  Widget Social(String img,String url){
    return GestureDetector(onTap:()=>contrl.siteLauncher(url),
        child: CircleAvatar(radius: 22,backgroundImage: AssetImage("imgs/$img.png"),));
  }
  Widget Address(Rx<String> txt){
    return SingleChildScrollView(scrollDirection: Axis.horizontal,
        child:Obx(() => Txt(txt.value, Colors.black, 17, FontWeight.w700)));
  }
}
