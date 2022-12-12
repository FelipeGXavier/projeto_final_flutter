import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:projeto_final/model/expenseEntity.dart';

const basePath =
    "https://eodhistoricaldata.com/api/news?api_token=63979814baae28.91376410";

getNews() async {
  const path = "$basePath&s=AAPL.US&offset=0&limit=10";
  final response = await http.get(
    Uri.parse(path),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: ''
    },
  );
  print(jsonDecode(response.body));
}
