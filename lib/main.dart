import 'package:abctechapp/assist/pages/assist_bind.dart';
import 'package:abctechapp/assist/pages/assist_page.dart';
import 'package:abctechapp/order/pages/order_bind.dart';
import 'package:abctechapp/order/pages/order_page.dart';
import 'package:abctechapp/home/pages/home_page.dart';
import 'package:abctechapp/assist/provider/assist_provider.dart';
import 'package:abctechapp/assist/services/assist_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  initServices();
  runApp(const MyApp());
}

void initServices() {
  Get.lazyPut(() => AssistService(assistProvider: AssistProvider()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'APP De Serviços',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: const TextTheme(headline4: TextStyle(color: Color(0xff764abc)))
      ),
      getPages: [
        GetPage(name: "/", page: () => const HomePage()),
        GetPage(name: "/order", page: () => const OrderPage(), binding: OrderBind()),
        GetPage(
            name: "/assists", page: () => const AssistPage(), binding: AssistBind())
      ],
    );
  }
}
