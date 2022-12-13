import 'dart:convert';
import 'dart:async';
import 'dart:io';
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

Future<Map<String, dynamic>> createCategory(
    Map<String, dynamic> categoryData) async {
  const path = "$basePath/category";
  final response = await http.post(
    Uri.parse(path),
    body: jsonEncode(categoryData),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: ''
    },
  );
  return jsonDecode(response.body);
}

Future<Map<String, dynamic>> deleteCategory(int categoryId) async {
  var path = "$basePath/category/$categoryId";
  final response = await http.delete(
    Uri.parse(path),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: ''
    },
  );
  return jsonDecode(response.body);
}

Future<List<Map<String, dynamic>>> getAllCategories() async {
  const basePath = "http://10.0.2.2:3000";
  const path = "$basePath/categories";
  var res = await http.get(
    Uri.parse(path),
  );
  var bodyResponse = jsonDecode(res.body);
  var data = {
    "categories": bodyResponse['categories'],
    "expenses": bodyResponse['expenses']
  };
  List<Map<String, dynamic>> categories =
      List<Map<String, dynamic>>.from(data['categories']);
  return categories;
}
