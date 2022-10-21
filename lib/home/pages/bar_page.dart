import 'package:abctechapp/order/pages/order_bind.dart';
import 'package:abctechapp/order/pages/order_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: const Color(0xff764abc)),
              accountName: Text(
                "Usuário xxx",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "email.teste@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Home'),
              onTap: () {
                Get.off(const HomePage());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.design_services,
              ),
              title: const Text('Serviços'),
              onTap: () {
                Get.off(const OrderPage(), binding: OrderBind());
              },
            ),
          ],
        ),
      );
  }
}