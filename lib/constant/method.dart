import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wimpy/data/data.dart';

import '../controller/displaypagecontroller.dart';
import '../data/global.dart';

Column ItemList(DisplayPageControllerImp controller) {
  return Column(children: [
    Expanded(
        child: listOf.isNotEmpty
            ? ListView.builder(
                itemBuilder: ((context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(
                      listOf[index]['name'].toString(),
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      listOf[index]['price'].toStringAsFixed(2),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          listOf[index]['quantity'].toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp),
                        ),
                        GestureDetector(
                          onTap: () {
                            print(listOf[index]['price'] /
                                listOf[index]['quantity']);
                            controller.removeItem(
                                index,
                                (listOf[index]['price'] /
                                    listOf[index]['quantity']));
                          },
                          child: Container(
                              width: 10.w,
                              height: 3.h,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'حذف',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 7.sp),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ));
                }),
                itemCount: listOf.length)
            : Center(
                child: Text(
                  'لا يوجد منتجات',
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
    Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      height: 5.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Text('المجموع: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 7.sp,
                  )),
              Text(total_Price.toStringAsFixed(2),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 7.sp,
                  )),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              controller.saveToDataBase();
              await controller.sunmi_print();
              await controller.sunmi_print();
              controller.reset();
            },
            child: Container(
              width: 11.w,
              height: 3.h,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'طباعة',
                  style: TextStyle(
                    fontSize: 6.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          GestureDetector(
            onTap: () {
              controller.deleteAllOrders();
            },
            child: Container(
              width: 11.w,
              height: 3.h,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'إفراغ المحتويات',
                  style: TextStyle(
                    fontSize: 5.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    )
  ]);
}

void addToData(ismulti, nameof, type, Map<String, Object> a) {
  if (ismulti) {
    if (type == 'وجبة') {
      switch (nameof) {
        case 'شاورما':
          shawarma['meals']!.add(a);

          break;
        case 'سناكات':
          snacks['meals']!.add(a);
          break;
        case 'طلبات الموظفين':
          staff['meals']!.add(a);
          break;

        default:
      }
    } else {
      switch (nameof) {
        case 'شاورما':
          shawarma['sandwitch']!.add(a);
          break;
        case 'سناكات':
          snacks['sandwitch']!.add(a);
          break;
        case 'طلبات الموظفين':
          staff['sandwitch']!.add(a);
          break;

        default:
      }
    }
  } else {
    switch (nameof) {
      case 'ايطالي':
        italy.add(a);
        break;
      case 'مشروبات':
        drinks.add(a);
        break;
      case 'إضافات':
        additions.add(a);
        break;
      case 'وجبات عائلية':
        familymeals.add(a);
        break;

      default:
    }
  }
}
