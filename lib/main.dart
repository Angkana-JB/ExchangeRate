import 'package:flutter/material.dart';
import 'moneybox.dart';
import 'package:http/http.dart' as http;
import 'exchangerate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Account",
      home: MyExchageRate(), //MyHomepage(),
      theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  //แสดงข้อมูล
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("บัญชีของฉัน",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                MyMoneyBox("ยอดคงเหลือ", 2500000.23, Colors.lightBlue, 120),
                SizedBox(
                  height: 5,
                ),
                MyMoneyBox("รายรับ", 35000, Colors.green, 100),
                SizedBox(
                  height: 5,
                ),
                MyMoneyBox("รายจ่าย", 15000, Colors.red, 100),
                SizedBox(
                  height: 5,
                ),
                MyMoneyBox("ค้างชำระ", 1200, Colors.orange, 100)
              ],
            ),
          ),
        ));
  }
}

class MyExchageRate extends StatefulWidget {
  MyExchageRate({Key? key}) : super(key: key);

  @override
  State<MyExchageRate> createState() => _MyExchageRateState();
}

class _MyExchageRateState extends State<MyExchageRate> {
  ExchangeRate? _dataFromAPI;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getExchange();
  }

  Future<ExchangeRate?> getExchange() async {
    var url = Uri.parse('https://api.exchangerate-api.com/v4/latest/THB');
    var response = await http.get(url);
    /* response.headers['Authorization'] =
        'Bearer RPn809LC7QAtF8ADgvBOY0jk0agZY2Rs';*/
    _dataFromAPI = exchangeRateFromJson(response.body);
    return _dataFromAPI;
    /*setState(() {
      _dataFromAPI = exchangeRateFromJson(response.body);
    });
    */
    //print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "อัตราการแลกเปลี่ยนสกุลเงิน",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: getExchange(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var result = snapshot.data;
            double amount = 100;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MyMoneyBox("สกุลเงิน (THB)", amount, Colors.lightBlue, 150),
                    SizedBox(
                      height: 5,
                    ),
                    MyMoneyBox(
                        "THB", amount * result.rates["THB"], Colors.green, 100),
                    SizedBox(
                      height: 5,
                    ),
                    MyMoneyBox(
                        "USD", amount * result.rates["USD"], Colors.red, 100),
                    SizedBox(
                      height: 5,
                    ),
                    MyMoneyBox("EUR", amount * result.rates["EUR"],
                        Colors.orange, 100),
                    SizedBox(
                      height: 5,
                    ),
                    MyMoneyBox("GBP", amount * result.rates["GBP"],
                        Colors.pinkAccent.shade400, 100),
                    SizedBox(
                      height: 5,
                    ),
                    MyMoneyBox("JPY", amount * result.rates["JPY"],
                        Colors.yellow.shade900, 100),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            );
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }
}
/*body: Column(
        //?.ถ้าหาไม่เจอจะข้ามไป
        children: [
          LinearProgressIndicator(),
          Text(_dataFromAPI?.query?.from ?? "loading...")
        ],
      ),
      */