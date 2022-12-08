import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
var userToken="".obs,userType="".obs;
getToken()async{
  final prefs = await SharedPreferences.getInstance();
  userToken.value=await prefs.getString('token')??"";
  userType.value=await prefs.getString('type')??"";
  return userToken;
}
saveToken()async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token',userToken.value);
  await prefs.setString('type',userType.value);
}
removeToken()async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token',userToken.value);
}