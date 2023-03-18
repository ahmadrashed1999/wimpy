import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wimpy/data/global.dart';
import 'package:wimpy/main.dart';

import '../data/database/database.dart';

abstract class AdminPageController extends GetxController {}

class AdminPageControllerImp extends AdminPageController {
  Future<List<Map<String, dynamic>>> getDailyReport() async {
    Sql sql = Sql();
    final now = DateTime.now();

    DateTime today = DateTime(now.year, now.month, now.day, 10);
    DateTime yesterday = today.add(Duration(days: 1));
    List<Map<String, dynamic>> dailyData = await sql.read(
      'product_prices',
      Where: 'time >= ? And time < ?',
      wherear: [today.toString(), yesterday.toString()],
    );
    return dailyData;
  }

  // Get the weekly report for a specific week
  Future<List<Map<String, dynamic>>> getWeeklyReport() async {
    Sql sql = Sql();
    DateTime now = DateTime.now();
    DateTime sevenDaysAgo = now.subtract(Duration(days: 7));

    List<Map<String, dynamic>> dailyData = await sql.read(
      'product_prices',
      Where: 'time >= ? And time < ?',
      wherear: [sevenDaysAgo.toString(), now.toString()],
    );
    return dailyData;
  }

// Get the monthly report for a specific month
  Future<List<Map<String, dynamic>>> getMonthlyReport() async {
    Sql sql = Sql();
    DateTime now = DateTime.now();
    DateTime DaysAgo = now.subtract(Duration(days: 30));

    List<Map<String, dynamic>> dailyData = await sql.read(
      'product_prices',
      Where: 'time >= ? And time < ?',
      wherear: [DaysAgo.toString(), now.toString()],
    );
    return dailyData;
  }

  Future getallData() {
    Sql sql = Sql();
    var data = sql.readData('SELECT * FROM product_prices ORDER BY time ASC;');
    return data;
  }

  void closeTheApp() {
    Get.dialog(
      AlertDialog(
        title: const Text('هل أنت متأكد من آنهاء الدوام؟'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('لا'),
          ),
          TextButton(
            onPressed: () {
              prefs.clear();
              listOf.clear();
              total_Price = 0;
              SystemNavigator.pop();
            },
            child: const Text('نعم'),
          ),
        ],
      ),
    );
  }
}
