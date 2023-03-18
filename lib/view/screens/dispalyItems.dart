import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DisplayItems extends StatefulWidget {
  const DisplayItems({Key? key, required this.title, required this.list})
      : super(key: key);
  final String title;
  final List<Map<String, dynamic>> list;

  @override
  State<DisplayItems> createState() => _DisplayItemsState();
}

class _DisplayItemsState extends State<DisplayItems> {
  double total_Price = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < widget.list.length; i++) {
      total_Price += widget.list[i]['price'];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 17, 61, 81),
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.list.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        '${widget.list[index]['name']}(الكمية : ${widget.list[index]['item_count']})',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "${widget.list[index]['price'].toStringAsFixed(2)} دينار",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(widget.list[index]['time'],
                          style: const TextStyle(color: Colors.green)),
                      leading: Text(widget.list[index]['order_id'].toString()),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text('المجموع: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          )),
                      Text(total_Price.toStringAsFixed(2),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          )),
                    ],
                  ),
                  GestureDetector(
                    // onTap: () {
                    //   controller.saveToDataBase();
                    // },
                    child: Container(
                      width: 15.w,
                      height: 10.h,
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
