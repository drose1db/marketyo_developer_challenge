import 'package:get_it/get_it.dart';
import 'package:marketyo_developer_challenge/services/i_login_service.dart';
import 'package:marketyo_developer_challenge/services/iproduct_service.dart';
import 'package:marketyo_developer_challenge/services/login_service.dart';
import 'package:marketyo_developer_challenge/services/product_service.dart';

final sl = GetIt.instance;
void init() {
  sl.registerLazySingleton<IProductService>(() => ProductService());
  sl.registerLazySingleton<ILoginService>(() => LoginService());
}
