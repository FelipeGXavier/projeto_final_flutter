import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:projeto_final/model/expenseEntity.dart';

const basePath = "http://10.0.2.2:3000";

Future<void> createExpense(FinancialMovement movement) async {
  const path = "$basePath/expense";
  final response = await http.post(
    Uri.parse(path),
    body: jsonEncode(movement),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: ''
    },
  );
  print(jsonDecode(response.body));
}

getAllCategories() async {
  const path = "$basePath/categories";
  return http.get(
    Uri.parse(path),
  );
}
