import 'dart:convert';
import 'conn.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class HomeController extends GetxController{
  var shops=[].obs,
      doctors=[].obs,
      loading=false.obs,
      online=false.obs
  ;
  void onInit() async{
    loading.value=true;
    online.value = await connection();
    // if(shops.isEmpty || doctors.isEmpty)
      await getData();
    // if(doctors.isEmpty)
    //   doctors.value=await getData(2);
    // myAds.value=await getMyAds();
    // TODO: implement onInit
    super.onInit();
    loading.value=false;
  }

  getData()async{
    Map items={};
    print("loading .......");

    // String url=id==1?"https://glass.teraninjadev.com/api/getShopAds":
    // "https://glass.teraninjadev.com/api/getDoctorHospitalAds";
    String url="https://glass.teraninjadev.com/api/Home";
    var response=await http.get(Uri.parse(url),
        headers:{"Accept": "application/json","Accept-Language": "en"});
    var data=jsonDecode(response.body);
    print("=================");
    // print(data);
    var done=(data['status']==1 &&data['code']==200);
    if(done){
     items=data['data'];
     shops.value=items["shop_ads"];
     doctors.value=items["doctorHospital_ads"];
    }
    // print(items);
    // return items;
  }
}