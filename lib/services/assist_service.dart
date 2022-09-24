import 'package:abctechapp/model/assist.dart';
import 'package:abctechapp/provider/assist_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssistService extends GetxService {
  late AssistProviderInterface assistProvider;

  AssistService({required this.assistProvider});

  Future<List<Assist>> getAssists() async {
    Response response = await assistProvider.getAssists();

    if (response.hasError) {
      return Future.error(ErrorDescription('Erro na conexao'));
    }
    
    try {
      List<Assist> listResult = response.body.map<Assist>((item) => Assist.fromMap(item)).toList();

      return Future.sync(() => listResult);
    } catch(error) {
      error.printError();
      return Future.error(error.toString());
    }
  }
}