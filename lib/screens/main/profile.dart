import 'package:class_ninja/controllers/get_token.dart';
import 'package:class_ninja/widgets/bottom_bar.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/user_controller.dart';

// import '../../controllers/auth_controller.dart';
// import '../../controllers/user_controller.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  double w = width * 0.95;

  // bool condition=userController.token.value.isEmpty&&token.isEmpty;
  // String token=getToken();
  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final authController = Get.put(AuthController());
    // userController.update();
    print(userController.phone.value);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: MainBar("الملف الشخصي", 25, false, false),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: width,
                    height: height,
                    child: userToken.isEmpty
                        ? NoProfile()
                        : Column(
                            children: [
                              SizedBox(height: 15),
                              Container(
                                width: w,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Obx(() => userController
                                            .img.value.isNotEmpty
                                        ? CircleAvatar(
                                            radius: 26,
                                            backgroundColor: mainColor,
                                            backgroundImage: NetworkImage(
                                                userController.img.value))
                                        : CircleAvatar(
                                            radius: 25,
                                            backgroundColor: inputColor,
                                            backgroundImage:
                                                AssetImage("imgs/man.png"))),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Obx(() => Txt(userController.name.value,
                                            Colors.black, 20, FontWeight.w600)),
                                        Obx(() => Txt(
                                            userController.phone.value,
                                            Colors.black,
                                            19,
                                            FontWeight.w600)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Box("تعديل الحساب", () => Get.toNamed("/edit")),
                              Box("حذف الحساب", () {
                                print(userController.img.value);
                                confirmBox(
                                    "حذف الحساب", "هل انت متاكد من حذف الحساب؟",
                                    () async {
                                  print("remove account");
                                  Get.back();
                                  await authController.leave(false);
                                });
                              }),
                              Box("تسجيل الخروج", () async {
                                confirmBox("تسجيل الخروج",
                                    " هل انت متاكد من تسجيل الخروج؟", () async {
                                  print("logout");
                                  Get.back();
                                  await authController.leave(true);
                                });
                              }),
                            ],
                          )),
                BottomBar(width, [false, false, false, true])
              ],
            ),
          ),
        ));
  }

  Widget Box(String title, action) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: w,
        height: 60,
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: inputColor, borderRadius: BorderRadius.circular(12)),
        child: Txt(title, Colors.black, 18, FontWeight.w600),
      ),
    );
  }

  Widget NoProfile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: height * 0.3),
        CircleAvatar(
            radius: 65,
            backgroundColor: inputColor,
            backgroundImage: AssetImage("imgs/map.png")),
        SizedBox(height: 6),
        Txt("هل انت مستخدم جديد؟", Colors.black, 15, FontWeight.w600),
        TxtBtn(
            "قم بانشاء حساب الان", mainColor, 17, () => Get.offNamed("/signup"))
      ],
    );
  }
}
