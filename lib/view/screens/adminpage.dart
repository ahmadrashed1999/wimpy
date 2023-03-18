import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:wimpy/view/screens/dispalyItems.dart';

import '../../controller/adminpagecontroller.dart';

class AdminPage extends StatelessWidget {
  AdminPage({Key? key}) : super(key: key);
  AdminPageControllerImp controller = Get.put(AdminPageControllerImp());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Admin Page'),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 17, 61, 81),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 5.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                var a = await controller.getDailyReport();
                                Get.to(DisplayItems(
                                    title: 'التقرير اليومي', list: a));
                              },
                              child: const AdminCard(
                                text: 'طباعة التقرير اليومي',
                                icon: Icons.print,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                var a = await controller.getWeeklyReport();
                                Get.to(DisplayItems(
                                    title: 'التقرير الاسبوعي', list: a));
                              },
                              child: const AdminCard(
                                text: 'طباعة التقرير الاسبوعي',
                                icon: Icons.print,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                var a = await controller.getMonthlyReport();
                                Get.to(DisplayItems(
                                    title: 'التقرير الشهري', list: a));
                              },
                              child: const AdminCard(
                                text: 'طباعة التقرير الشهري',
                                icon: Icons.print,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                var a = await controller.getallData();
                                Get.to(
                                    DisplayItems(title: 'التقارير', list: a));
                              },
                              child: const AdminCard(
                                text: 'طباعة جميع التقارير',
                                icon: Icons.print,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                controller.closeTheApp();
                              },
                              child: const AdminCard(
                                text: 'آنهاء الدوام',
                                icon: Icons.close,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class AdminCard extends StatelessWidget {
  const AdminCard({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(icon),
      ),
    );
  }
}
