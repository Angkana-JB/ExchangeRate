import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyMoneyBox extends StatelessWidget {
  // const MyMoneyBox({Key? key}) : super(key: key);

  //constartor
  final String title; //ชื่อหมวดหมู่
  final double amount; //จำนวนเงิน
  final Color color; //สีของกล่อง
  final double size; //ขนาดของกล่อง
  MyMoneyBox(this.title, this.amount, this.color, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      height: size,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              '${NumberFormat("#,###.##").format(amount)}',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
