class Address {
  final int id;
  final String type;
  final String address;
  final String houseNumber;
  final String city;
  final String pinCode;
  final String state;

  Address({required this.id, required this.type,required this.address, required this.houseNumber,
    required this.city,required this.pinCode,required this.state
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      address: json['address'],
      type: json['type'],
      houseNumber: json['houseNumber'],
      city: json['city'],
      pinCode: json['pinCode'],
      state: json['state'],
    );
  }

  Address copyWith({int? id,String? type, String? address,String? houseNumber,String? city,String? pinCode,String? state}) {
    return Address(
        id: id??this.id,
        type: address??this.type,
        address: address??this.address,
        houseNumber: houseNumber??this.houseNumber,
        city: city??this.city,
        pinCode: pinCode??this.pinCode,
        state: state??this.state

    );
  }
}
