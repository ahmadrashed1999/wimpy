import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:wimpy/controller/displaypagecontroller.dart';
import 'package:wimpy/data/global.dart';

import '../../constant/method.dart';
import 'homepage.dart';

class DisplayPage extends StatelessWidget {
  DisplayPage({Key? key, required this.title, required this.list})
      : super(key: key);
  final String title;
  final List<Map<String, Object>> list;
  DisplayPageControllerImp controller = Get.put(DisplayPageControllerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 17, 61, 81),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Get.offAll(() => MyHomePage());
            },
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 139, 189, 210),
      body: GetBuilder<DisplayPageControllerImp>(
        builder: ((controller) => Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: ((context, index) {
                                    return Card(
                                        child: ListTile(
                                      title: Text(
                                        list[index]['name'].toString(),
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            list[index]['price'].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 7.sp),
                                          ),
                                          list[index]['desc']?.toString() !=
                                                  null
                                              ? Text(
                                                  list[index]['desc']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 7.sp))
                                              : Container()
                                        ],
                                      ),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          final newItem = {
                                            ...list[index],
                                            'quantity': 1
                                          };
                                          controller.addItem(newItem);
                                        },
                                        child: Container(
                                            width: 15.w,
                                            height: 5.h,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'أضف',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 7.sp),
                                              ),
                                            )),
                                      ),
                                    ));
                                  }),
                                  separatorBuilder: ((context, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  }),
                                  itemCount: list.length),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        width: 50.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 238, 231, 231)
                              .withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ItemList(controller),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
