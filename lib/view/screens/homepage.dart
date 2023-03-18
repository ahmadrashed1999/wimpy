import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:wimpy/controller/displaypagecontroller.dart';
import 'package:wimpy/data/database/database.dart';
import 'package:wimpy/view/screens/adminpage.dart';
import 'package:wimpy/view/screens/choosetype.dart';
import 'package:wimpy/view/widgets/homepage/homepagecard.dart';

import '../../constant/method.dart';
import '../../data/data.dart';
import '../../data/global.dart';
import 'displaypage.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  DisplayPageControllerImp controller = Get.put(DisplayPageControllerImp());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wimpy'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 17, 61, 81),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              Get.to(() => AdminPage());
              // Sql sql = Sql();
              // var a = sql.read('product_prices');
              // sql.printAllProducts('product_prices');
              // List aa = await sql.read('ordersTable');

              // aa.forEach((element) {
              //   print(element);
              // });
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 139, 189, 210),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          ChooseType(
                                            name: 'الشاورما',
                                            list1: shawarma['meals']!,
                                            list2: shawarma['sandwitch']!,
                                          ),
                                        );
                                      },
                                      child:
                                          const HomePageCard(text: 'الشاورما')),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          ChooseType(
                                              name: 'السناكات',
                                              list1: snacks['meals']!,
                                              list2: snacks['sandwitch']!),
                                        );
                                      },
                                      child:
                                          const HomePageCard(text: 'السناكات')),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => DisplayPage(
                                              title: 'وجبات الإيطالي',
                                              list: italy,
                                            ));
                                      },
                                      child:
                                          const HomePageCard(text: 'ايطالي')),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => DisplayPage(
                                                title: 'مشروبات',
                                                list: drinks,
                                              ));
                                        },
                                        child: const HomePageCard(
                                            text: 'مشروبات'))),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => DisplayPage(
                                                title: 'إضافات',
                                                list: additions,
                                              ));
                                        },
                                        child: const HomePageCard(
                                            text: 'إضافات'))),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => DisplayPage(
                                                title: 'وجبات عائلية',
                                                list: familymeals,
                                              ));
                                        },
                                        child: const HomePageCard(
                                            text: 'وجبات عائلية'))),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            ChooseType(
                                              name: 'الموظفين',
                                              list1: staff['meals']!,
                                              list2: staff['sandwitch']!,
                                            ),
                                          );
                                        },
                                        child: const HomePageCard(
                                            text: 'طلبات الموظفين'))),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GetBuilder<DisplayPageControllerImp>(builder: ((controller) {
                  return Container(
                    width: 50.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color:
                          Color.fromARGB(255, 238, 231, 231).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ItemList(controller),
                  );
                }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
