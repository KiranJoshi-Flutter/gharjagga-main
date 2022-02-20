class MyWishL {
  late int id;
  late String propertyId;
  late String propertyName;
  late String propertyImage;
  late String propertyPrice;
  late String offerType;
  late String bathroom;
  late String bedroom;
  late String propertySIze;
  // String qty;

  MyWishL({
    required this.id,
    required this.propertyId,
    required this.propertyPrice,
    required this.propertyName,
    required this.propertyImage,
    required this.offerType,
    required this.bathroom,
    required this.bedroom,
    required this.propertySIze,
    // this.qty,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'propertyId': propertyId,
      'propertyPrice': propertyPrice,
      'propertyName': propertyName,
      'propertyImage': propertyImage,
      'offerType': offerType,
      'bathroom': bathroom,
      'bedroom': bedroom,
      'propertySIze': propertySIze,
    };
    return map;
  }

  MyWishL.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    propertyId = map['propertyId'];
    propertyPrice = map['propertyPrice'];
    propertyName = map['propertyName'];
    propertyImage = map['propertyImage'];
    offerType = map['offerType'];
    bathroom = map['bathroom'];
    bathroom = map['bathroom'];
    propertySIze = map['propertySIze'];
  }
}
