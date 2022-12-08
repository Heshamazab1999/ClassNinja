import 'package:class_ninja/controllers/home_controllers.dart';
import 'package:class_ninja/widgets/bottom_bar.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/main_box.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: MainBar("الرئيسية", 27, false, false),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Container(
                    height: 180,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: const DecorationImage(
                            image: AssetImage("imgs/sale.png"),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(10))),
                const SizedBox(height: 10),
                ListItem(
                    "محلات ", "النظارات", homeController.shops, true),
                ListItem("دكاترة ", "ومستشفيات", homeController.doctors,
                    false),
                const SizedBox(height: 20),
                //ads
                Titles(" الاعلانات ", "المميزة",
                    () => Get.toNamed("/allAds")),
                Row(
                  children: [
                    MainBox(
                        width * 0.42,
                        "",
                        false,
                        "1500.00",
                        "ا.د/يوسف علي",
                        "(للكشف)",
                        "الرياض السعودية",
                        () {}),
                    MainBox(
                        width * 0.42,
                        "",
                        false,
                        "1500.00",
                        "ا.د/يوسف علي",
                        "(للكشف)",
                        "الرياض السعودية",
                        () {}),
                  ],
                ),
                const SizedBox(height: 50),
                // BottomBar(width, [true, false, false, false])
              ],
            ),
          ),
        ));
  }

  Widget ListItem(String txt1, String txt2, RxList<dynamic> list, bool shop) {
    return Column(
      children: [
        Titles(
            txt1, txt2, () => Get.toNamed("/homeAds", arguments: [shop, list])),
        SizedBox(height: 10),
        SizedBox(
          height: 50,
          width: width * 0.95,
          child: Obx(() => ListView.builder(
              itemCount: list.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext contxt, i) {
                String img = list[i]['image'];
                return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    color: inputColor,
                    height: 40,
                    width: 150,
                    child: GestureDetector(
                        onTap: () async {
                          // print(homeController.shops.value);
                        },
                        child: img.isEmpty
                            ? null
                            : Image(
                                image: NetworkImage(img), fit: BoxFit.fill)));
              })),
        )
      ],
    );
  }

  Widget Titles(String t1, String t2, action) {
    return Container(
        width: width * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Txt(t1, Colors.black, 18, FontWeight.w500),
                Txt(t2, Colors.black, 19, FontWeight.bold),
              ],
            ),
            TxtBtn("مشاهدة الكل", mainColor, 15, action)
          ],
        ));
  }
}
