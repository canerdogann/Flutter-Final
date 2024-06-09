import 'package:dio/dio.dart';
import '../models/product.dart';

import '../models/user.dart';

class API {
  final Dio dio = Dio();  // Bu satırda Dio sınıfını doğru bir şekilde kullanıyorsunuz.


  Future<List<Product>> getProducts() async {
    Response response = await dio.get('https://fakestoreapi.com/products');

    List<Product> products = [];

    (response.data as List).forEach((element) {
      products.add(Product.fromJson(element));
    });

    return products;
  }

  Future<List<String>> getCategories() async {
    Response response = await dio.get('https://fakestoreapi.com/products/categories');

    List<String> categories = [];

    (response.data as List).forEach((element) {
      categories.add(element.toString());
    });

    return categories;
  }

  Future<List<User>> kullanicilar() async {
    Response response = await dio
        .get('https://fakerapi.it/api/v1/users?_quantity=100&_gender=male');

    List<User> kullanicilar = [];

    (response.data["data"] as List).forEach((element) {
      kullanicilar.add(User.fromJson(element));
    });

    return kullanicilar;
  }
}
