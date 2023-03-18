import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:wimpy/data/data.dart';

import '../../constant/method.dart';
import '../../controller/displaypagecontroller.dart';
import '../../data/global.dart';
import '../widgets/homepage/homepagecard.dart';
import 'displaypage.dart';

class ChooseType extends StatelessWidget {
  ChooseType(
      {Key? key, required this.name, required this.list1, required this.list2})
      : super(key: key);
  final String name;
  final List<Map<String, Object>> list1;
  final List<Map<String, Object>> list2;
  DisplayPageControllerImp controller = Get.put(DisplayPageControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 17, 61, 81),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 139, 189, 210),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Get.to(() => DisplayPage(
                                    title: 'وجبات $name',
                                    list: list1,
                                  ));
                            },
                            child: const HomePageCard(text: 'الوجبات'))),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Get.to(() => DisplayPage(
                                    title: 'ساندويش $name',
                                    list: list2,
                                  ));
                            },
                            child: const HomePageCard(text: 'الساندويش'))),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
              ),
              GetBuilder<DisplayPageControllerImp>(builder: ((controller) {
                return Container(
                  width: 50.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 238, 231, 231).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ItemList(controller), );
              }))
            ],
          ),
        ),
      ),
    );
  }
}
