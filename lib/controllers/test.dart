// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:async/async.dart';
// import 'package:dio/dio.dart';
// import 'package:http_parser/http_parser.dart';
//
// Signup(File imgPath)async{
//   String postUri ="http://success.teraninjadev.com/api/auth/register",
//       mediaUrl="http://success.teraninjadev.com/uploadedimages/";
//   // BaseOptions _dioOption() {
//   //   BaseOptions options = new BaseOptions(baseUrl: postUri, headers: {
//   //     Headers.acceptHeader: Headers.jsonContentType,
//   //     Headers.contentTypeHeader: Headers.jsonContentType,
//   //     // "Authorization": "Bearer $token"
//   //   });
//   //   return options;
//   // }
//   String fileName =imgPath.path.split('/').last;
//   // FormData data = FormData.fromMap({
//   //   "name": "boshra3",
//   //   "phone": "76786788855",
//   //   "email": "boshra@gmail.com",
//   //   "type": "student",
//   //   "countryId": "1",
//   //   "password": "12345678",
//   //   "password_confirmation": "12345678",
//   //   "image":
//   //   await MultipartFile.fromFile(
//   //       contentType: MediaType("png", "jpg"),
//   //       imgPath.path, filename:fileName),
//   // });
//
//   // Dio dio=Dio();
//   // var data=await dio.MultipartFile.fromFile(
//   //   imagePath.value ,
//   //   filename: 'user-img',
//   // );
//   // Dio dio1 = new Dio()..options.baseUrl =postUri;
//   // var response = await dio1.post(mediaUrl, data: data);
//   // if (response.statusCode == 200) {
//   //   print(response.data);
//   // }
//   // }
//
//   http.MultipartRequest request =http.MultipartRequest("POST", Uri.parse(postUri));
//
//   // http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
//   //     'image',imgPath.path,contentType: new MediaType('image', 'jpg'),);
//   // request.files.add(multipartFile);
//
//   request.fields['name']="kamlasaad";
//   request.fields["phone"]="0101020300";
//   request.fields["email"]="randa@gmail.com";
//   request.fields["type"]="student";
//   request.fields["countryId"]="1";
//   request.fields["password"]="12345678";
//   request.fields["password_confirmation"]="12345678";
//   // request.files.add(new http.MultipartFile.fromBytes('image', await imgPath.readAsBytes(),
//   //     contentType: new MediaType('image', 'jpg')));
//   // request.files.add(http.MultipartFile.fromString("image", imgPath.path, contentType: new MediaType('image', 'jpg')));
//   // var stream =
//   // new http.ByteStream(DelegatingStream.typed(imgPath.openRead()));
//   // var length = await imgPath.length(); //
//   // var multipartFileSign = new http.MultipartFile('image', stream, length,
//   //     filename: fileName);
//   var multipartFileSign = new http.MultipartFile('image', imgPath.readAsBytes().asStream(), imgPath.lengthSync(),
//       filename: fileName);
//   request.files.add(multipartFileSign);
//   request.send().then((response) async{
//     if (response.statusCode == 200) {
//       print(jsonDecode(await response.stream.bytesToString()));
//     }
//   }).catchError((e)=>print(e));
//   // print(response.stream.last);
// }