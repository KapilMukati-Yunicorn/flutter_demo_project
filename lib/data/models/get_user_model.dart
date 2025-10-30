class UserModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? image;

  UserModel({this.id,this.name,this.email, this.phone, this.address, this.image});

  factory UserModel.fromJson(Map<String, dynamic> json) {
   return UserModel(
       id : json['id'],
       name : json['name'],
       email : json['email'],
       phone : json['phone'],
       address : json['address'],
   image : json['image']
   );
  }

  UserModel copyWith({String? id,String? name,String? email,String? phone,String? address,String? image}) {
    return UserModel(
        id: id??this.id,
        name: name??this.name,
        email: name??this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        image: image ?? this.image,

    );
  }

}
