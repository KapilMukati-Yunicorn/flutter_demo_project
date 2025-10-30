class Product {
  final int id;
  final String title;
  final String image;
  final double price;
  final bool isFavorite;
  final int quantity;

  Product({required this.id, required this.title, required this.image,
    required this.price,required this.isFavorite,required this.quantity
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: json['price'],
      isFavorite: json['isFavorite'],
      quantity: json['quantity'],
    );
  }

  Product copyWith({int? id,String? title,String? image,double? price,bool? isFavorite,int? quantity}) {
    return Product(
     id: id??this.id,
      title: title??this.title,
      image: image??this.image,
      price: price??this.price,
        isFavorite: isFavorite??this.isFavorite,
      quantity: quantity??this.quantity

    );
  }
}
