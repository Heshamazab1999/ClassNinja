
import 'package:internet_connection_checker/internet_connection_checker.dart';

connection()async{
  bool result = await InternetConnectionChecker().hasConnection;
  return result;
}