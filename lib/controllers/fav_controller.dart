import 'dart:convert';
import 'package:class_ninja/widgets/shared.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'conn.dart';
import 'get_token.dart';
class FavController extends GetxController{
  var loading=false.obs,
      online=false.obs,
      data=[].obs;
  @override
  void onInit() async{
    online.value = await connection();
    await getMyFav();
    // myAds.value=await getMyAds();
    // TODO: implement onInit
    super.onInit();
  }
  getAFav()async{

  }
  addFav(id)async{
    online.value = await connection();
    print("loading....");
    // loading.value=true;
    if(online.isTrue ){
      String url="https://glass.teraninjadev.com/api/client/favorites";
      var response=await http.post(Uri.parse(url),
          body: {"ad_id":id},
          headers:{"Accept": "application/json","Accept-Language": "en",
            'Authorization':'Bearer ${userToken.value}'
      });
      var data=jsonDecode(response.body);
      print(data);
      bool done=(data['status']==1 &&data['code']==200);
      if(done){
        Popup("تم اضافة الاعلان الي المفضلة");
        await getMyFav();
        Get.toNamed("/fav");
      }
      else{Popup("عفوا لم يتم حذف الاعلان");}
    }else{Popup("لايوجد اتصال بالانترنت");}
  }
  delFav(id)async{
    loading.value=true;
    online.value = await connection();
    if(online.isTrue){
      String url="https://glass.teraninjadev.com/api/client/favorites/$id";
      var response=await http.delete(Uri.parse(url),
          headers:{"Accept": "application/json","Accept-Language": "en",
            'Authorization':'Bearer ${userToken.value}'});
      var data=jsonDecode(response.body);
      print(data);
      bool done=(data['status']==1 &&data['code']==200);
      if(done){
        await getMyFav();
        Popup("تم حذف الاعلان من المفضلة");
      }else{Popup("عفوا لم يتم حذف الاعلان");}
    }else{Popup("لايوجد اتصال بالانترنت");}
    loading.value=false;
  }
  getMyFav()async{
    print("loading .......");
    if(userToken.isNotEmpty) {
      loading.value=true;
      online.value = await connection();
      if (online.isTrue) {
        String url = "https://glass.teraninjadev.com/api/client/favorites";
        var response = await http.get(Uri.parse(url), headers: {
          "Accept": "application/json",
          "Accept-Language": "en",
          'Authorization': 'Bearer ${userToken.value}'
        });
        var result = jsonDecode(response.body);
        var done = (result['status'] == 1 && result['code'] == 200);
        if (done) {
          // print(result['data']);
          loading.value = false;
          data.value = result['data'];
        }
      }
      loading.value = false;
    }
  }
}
