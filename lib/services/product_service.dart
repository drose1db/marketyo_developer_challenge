import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:marketyo_developer_challenge/constants/api_url.dart';
import 'package:marketyo_developer_challenge/models/product_model.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:marketyo_developer_challenge/services/iproduct_service.dart';

class ProductService with IProductService {
  final String _url = ApiUrl.baseUrl;

  @override
  Future getProducts() async {
    final Response response = await http.get(_url + 'products');
    if (response.statusCode == 200) {
      final decodedBody = json.decode(response.body) as List;
      final products = decodedBody
          .map<ProductModel>((productMap) => ProductModel.fromJson(productMap))
          .toList();
      return products;
    }
    return ProductModel();
  }
}
