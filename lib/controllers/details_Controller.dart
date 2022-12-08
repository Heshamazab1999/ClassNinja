import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../widgets/shared.dart';
import 'conn.dart';
import 'location.dart';
class DetailsController extends GetxController{
  LoCation loc=LoCation();
  var data={}.obs,
      loading=false.obs,
      online=false.obs,
      latitude=0.0.obs,
      longtude=0.0.obs,
      address1="".obs,
      address2="".obs
  ;
  @override
  void onInit() async{
    online.value = await connection();
    // await loc.getLocation();
    // await loc.goToMaps();
    // TODO: implement onInit
    // super.onInit();
  }

  getData(int id)async{
    print("loading .......");
    loading.value=true;
    String url="https://glass.teraninjadev.com/api/provider/data/$id";
    var response=await http.get(Uri.parse(url),
        headers:{"Accept": "application/json","Accept-Language": "en"});
    var result=jsonDecode(response.body);
    print(result);
    var done=(result['status']==1 &&result['code']==200);
    if(done){
      data.value=result['data'];
      // await loc.getLocation();
      latitude.value=data['lat'];
      longtude.value=data['long'];
      List address=await loc.getAdress(latitude.value,longtude.value);
      address1.value=address[0];
      address2.value=address[1];
      // for(int i=0;i<list.length;i++){
      //   String status=list[i]['status'];
      //   if(status=="pending")
      //     ads.add(list[i]);
      // }
    }
    loading.value=false;
  }
  goToMap()async{
    if(latitude.value>0){
      loc.goToMaps(latitude.value,longtude.value);
    }else Popup("لايمكن الوصول للموقع حاليا");
  }
  Future<void> siteLauncher(String url) async {
    var result=await canLaunchUrl(Uri.parse((url)));
    // print(result);
    if (result)
      await launchUrl(Uri.parse((url)));
    else  Popup('لايمكن الوصول للموقع حاليا');
  }
  whatsLauncher(String phone){
    String url="";
    if (Platform.isAndroid) {
      url="whatsapp://send?phone=+2" + phone + "&text=";
      // url="https://wa.me/$phone/?text=${Uri.parse('')}"; // new line
    } else {
      // url="https://api.whatsapp.com/send?phone=$phone=${Uri.parse('')}"; // new line
      url="https://wa.me/'+2$phone'?text="; // new line
    }
    siteLauncher(url);
  }
}