import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wimpy/data/database/database.dart';
import 'package:wimpy/data/global.dart';
import 'package:wimpy/main.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'dart:async';

import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';
import '../view/screens/homepage.dart';

abstract class DisplayPageController extends GetxController {}

// Path: lib\view\screens\displaypage.dart
// Compare this snippet from lib\view\screens\displaypage.dart:
// import 'package:flutter/material.dart';
class DisplayPageControllerImp extends DisplayPageController {
  void addItem(Item) {
    print(Item);
    total_Price += Item['price'];
    bool itemFound = false;
    for (var element in listOf) {
      if (element['name'] == Item['name']) {
        element['quantity'] += 1;
        element['price'] += Item['price'];
        Item = element;
        itemFound = true;
        break;
      }
    }
    if (!itemFound) {
      listOf.add(Item);
    }
    update();
  }

  void removeItem(index, price) {
    if (listOf[index]['quantity'] > 1) {
      listOf[index]['quantity'] -= 1;
      listOf[index]['price'] -= price;
      total_Price -= price;

      update();
    } else {
      listOf.removeAt(index);
      total_Price -= price;
      update();
    }
  }

  // void totalPrice() {
  //   listofItems.forEach((element) {
  //     total += element['price'];
  //   });
  //   print(total);
  //   update();
  // }

  void printOrder() {
    print(listOf);
    print(total_Price);
  }

  void deleteAllOrders() {
    listOf.clear();
    total_Price = 0;
    update();
  }

  void saveToDataBase() async {
    Sql sql = Sql();

    print(prefs.getInt('order_id'));

    if (listOf.isNotEmpty) {
      for (var element in listOf) {
        sql.insertData(
            'INSERT INTO product_prices (name, price, order_id,item_count) VALUES ("${element['name']}","${element['price']}","${prefs.getInt('order_id')}","${element['quantity']}")');
      }
    }
    sunmi_print();
    sunmi_print();
    order_num++;
  }

  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  // ignore: non_constant_identifier_names
  Future sunmi_print() async {
    print('sunmi_print');
    await SunmiPrinter.initPrinter();

    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.line();
    await SunmiPrinter.printText('Payment receipt');
    await SunmiPrinter.printText('Wimpy resturant!');
    await SunmiPrinter.printText('Order Num: ${order_num}');
    await SunmiPrinter.line();
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'Name', width: 12, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: 'Qty', width: 6, align: SunmiPrintAlign.CENTER),
      ColumnMaker(text: 'TOT', width: 6, align: SunmiPrintAlign.RIGHT),
    ]);
    print(listOf.length);
    if (listOf.isNotEmpty) {
      for (var element in listOf) {
        await SunmiPrinter.printRow(cols: [
          ColumnMaker(
              text: element['name'].toString(),
              width: 12,
              align: SunmiPrintAlign.LEFT),
          ColumnMaker(
              text: element['quantity'].toString(),
              width: 6,
              align: SunmiPrintAlign.CENTER),
          ColumnMaker(
              text: element['price'].toString(),
              width: 6,
              align: SunmiPrintAlign.RIGHT),
        ]);
        print(element['name']);
        print('kkkkkkkkkkkkkk');
      }
    }

    await SunmiPrinter.line();
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'TOTAL', width: 25, align: SunmiPrintAlign.LEFT),
      ColumnMaker(
          text: total_Price.toString(), width: 5, align: SunmiPrintAlign.RIGHT),
    ]);

    await SunmiPrinter.line();
    await SunmiPrinter.printText('Thank you for your purchase!');
    print('ssss');
  }

  void reset() {
    listOf.clear();
    total_Price = 0;
    Get.offAll(
      () => MyHomePage(),
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _bindingPrinter().then((bool? isBind) async {
      SunmiPrinter.paperSize().then((int size) {
        paperSize = size;
      });

      SunmiPrinter.printerVersion().then((String version) {
        update();
      });

      SunmiPrinter.serialNumber().then((String serial) {
        serialNumber = serial;
        update();
      });

      printBinded = isBind!;
      update();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
