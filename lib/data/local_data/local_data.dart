import 'package:bloc_project/core/constants/image_constants.dart';
import 'package:bloc_project/data/models/get_product_model.dart';

class LocalData{
  static List<Product> productList=[
    Product(id: 1, title: 'Road Bike', image: ImageConstants.imgCycle1, price: 1999.9,isFavorite: false, quantity: 1),
    Product(id: 2, title: 'Road Corn Bike', image: ImageConstants.imgCycle2, price: 2900.9,isFavorite: false, quantity: 1),
    Product(id: 3, title: 'Battery Bike', image: ImageConstants.imgCycle3, price: 3999.9,isFavorite: false, quantity: 1),
    Product(id: 4, title: 'Helmet', image: ImageConstants.imgHelmet, price: 1500.0,isFavorite: false, quantity: 1),
  ];
}