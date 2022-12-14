import 'dart:convert';
import 'dart:developer';

import 'package:abctechapp/order/model/order.dart';
import 'package:abctechapp/order/model/order_created.dart';
import 'package:abctechapp/order/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OrderServiceInterface {
  Future<OrderCreated> createOrder(Order order);
}

class OrderService extends GetxService implements OrderServiceInterface {
  final OrderProviderInterface _orderProviderInterface;
  OrderService(this._orderProviderInterface);

  @override
  Future<OrderCreated> createOrder(Order order) async {
    try {
      Response response = await _orderProviderInterface.postOrder(order);

      if (response.hasError) {
        final description = response.body['description'];

        return Future.error(ErrorDescription(description));
      }

      return Future.sync(() => OrderCreated(true, ""));

    } catch (error) {
        error.printError();
        return Future.error(ErrorDescription("Erro não esperado"));
    }
  }
}
