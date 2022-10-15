import 'dart:developer';

import 'package:abctechapp/assist/model/assist.dart';
import 'package:abctechapp/order/model/order.dart';
import 'package:abctechapp/order/model/order_created.dart';
import 'package:abctechapp/order/model/order_location.dart';
import 'package:abctechapp/services/geolocation_service.dart';
import 'package:abctechapp/order/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

enum OrderState { creating, started, finished }

class OrderController extends GetxController with StateMixin<OrderCreated> {
  final GeolocationServiceInterface _geolocationService;
  final OrderService _orderService;
  final formKey = GlobalKey<FormState>();
  final operatorIdController = TextEditingController();
  final selectedAssists = <Assist>[].obs;
  final screenState = OrderState.creating.obs;
  late Order _order;

  OrderController(this._geolocationService, this._orderService);

  @override
  void onInit() {
    super.onInit();
    _geolocationService.start();
    change(null, status: RxStatus.success());
  }

  OrderLocation orderLocationFromPosition(Position position) {
    return OrderLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        dateTime: DateTime.now());
  }

  List<int> servicesIdArrayFromServices() {
    return selectedAssists.map((element) => element.id).toList();
  }

  finishStartOrder(formContext) {
    if (!(formKey.currentState!.validate())) {
      return;
    }

    switch (screenState.value) {
      case OrderState.creating:
        // validar aqui????
        _geolocationService.getPosition().then((value) {
          var start = orderLocationFromPosition(value);

          _order = Order(
              operatorId: int.parse(operatorIdController.text),
              assists: servicesIdArrayFromServices(),
              start: start,
              end: null);
        });
        screenState.value = OrderState.started;
        break;
      case OrderState.started:
        change(null, status: RxStatus.loading());
        _geolocationService.getPosition().then((value) {
          var end = orderLocationFromPosition(value);

          _order.end = end;
          _createOrder();
        });

        break;
      default:
    }
  }

  void _createOrder() {
    screenState.value = OrderState.finished;
    _orderService.createOrder(_order).then((value) {
      if (value.success) {
        Get.snackbar("Sucesso", "Ordem de serviço criada com sucesso");
        clearForm();
      }
    }).catchError((error) {
      Get.snackbar("Erro", error.toString());
      clearForm();
    });
  }

  void clearForm() {
    screenState.value = OrderState.creating;
    selectedAssists.clear();
    operatorIdController.text = "";
    change(null, status: RxStatus.success());
  }

  editAssists(BuildContext context) {
    if (screenState.value != OrderState.creating) {
      return null;
    }
    Get.toNamed("/assists", arguments: selectedAssists);
  }
}
