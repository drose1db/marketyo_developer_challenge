import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:marketyo_developer_challenge/models/product_model.dart';
import 'package:marketyo_developer_challenge/services/iproduct_service.dart';
import 'package:marketyo_developer_challenge/services/product_service.dart';

class ProductViewModel with ChangeNotifier {
  ProductService _productService = GetIt.I<IProductService>();
  List<ProductModel> _products;
  List<ProductModel> get products => _products;

  Future<bool> getProducts() async {
    _products = await _productService.getProducts();
    notifyListeners();
    return true;
  }
}
