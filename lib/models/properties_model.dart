import 'dart:convert';

List<PropertiesModel> propertiesModelFromJson(String str) =>
    List<PropertiesModel>.from(
        json.decode(str)!.map((x) => PropertiesModel.fromJson(x)));

String propertiesModelToJson(List<PropertiesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PropertiesModel {
  PropertiesModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.excerpt,
    required this.link,
    required this.hasPrice,
    required this.imageSrcset,
    required this.image,
    required this.attributes,
    required this.address,
    required this.daysAgo,
    required this.isFeatured,
    required this.offerType,
    required this.status,
    required this.paymentStatus,
    required this.attributeClasses,
    required this.gallery,
    required this.date,
    required this.price,
  });

  int id;
  String name;
  String slug;
  String excerpt;
  String link;
  bool hasPrice;
  String imageSrcset;
  String image;
  List<Attribute>? attributes;
  String address;
  String daysAgo;
  bool isFeatured;
  List<OfferType>? offerType;
  String status;
  String paymentStatus;
  String attributeClasses;
  List<Gallery>? gallery;
  String date;
  List<Price>? price;

  factory PropertiesModel.fromJson(Map<String, dynamic> json) =>
      PropertiesModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        excerpt: json["excerpt"] == null ? null : json["excerpt"],
        link: json["link"] == null ? null : json["link"],
        hasPrice: json["has_price"] == null ? null : json["has_price"],
        imageSrcset: json["image_srcset"] == null ? null : json["image_srcset"],
        image: json["image"] == null ? null : json["image"],
        attributes: json["attributes"] == null
            ? null
            : List<Attribute>.from(
                json["attributes"]!.map((x) => Attribute.fromJson(x))),
        address: json["address"] == null ? null : json["address"],
        daysAgo: json["days_ago"] == null ? null : json["days_ago"],
        isFeatured: json["is_featured"] == null ? null : json["is_featured"],
        offerType: json["offer_type"] == null
            ? null
            : List<OfferType>.from(
                json["offer_type"]!.map((x) => OfferType.fromJson(x))),
        status: json["status"] == null ? null : json["status"],
        paymentStatus:
            json["payment_status"] == null ? null : json["payment_status"],
        attributeClasses: json["attribute_classes"] == null
            ? null
            : json["attribute_classes"],
        gallery: json["gallery"] == null
            ? null
            : List<Gallery>.from(
                json["gallery"]!.map((x) => Gallery.fromJson(x))),
        date: json["date"] == null ? null : json["date"],
        price: json["price"] == null
            ? null
            : List<Price>.from(json["price"]!.map((x) => Price.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "excerpt": excerpt == null ? null : excerpt,
        "link": link == null ? null : link,
        "has_price": hasPrice == null ? null : hasPrice,
        "image_srcset": imageSrcset == null ? null : imageSrcset,
        "image": image == null ? null : image,
        "attributes": attributes == null
            ? null
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "address": address == null ? null : address,
        "days_ago": daysAgo == null ? null : daysAgo,
        "is_featured": isFeatured == null ? null : isFeatured,
        "offer_type": offerType == null
            ? null
            : List<dynamic>.from(offerType!.map((x) => x.toJson())),
        "status": status == null ? null : status,
        "payment_status": paymentStatus == null ? null : paymentStatus,
        "attribute_classes": attributeClasses == null ? null : attributeClasses,
        "gallery": gallery == null
            ? null
            : List<dynamic>.from(gallery!.map((x) => x.toJson())),
        "date": date == null ? null : date,
        "price": price == null
            ? null
            : List<dynamic>.from(price!.map((x) => x.toJson())),
      };
}

class Attribute {
  Attribute({
    required this.id,
    required this.name,
    required this.slug,
    required this.hasArchive,
    required this.values,
    required this.displayAfter,
    required this.show,
    required this.cardShow,
    required this.icon,
  });

  int id;
  String name;
  String slug;
  bool hasArchive;
  List<Value>? values;
  String displayAfter;
  bool show;
  bool cardShow;
  String icon;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        hasArchive: json["has_archive"] == null ? null : json["has_archive"],
        values: json["values"] == null
            ? null
            : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
        displayAfter:
            json["display_after"] == null ? null : json["display_after"],
        show: json["show"] == null ? null : json["show"],
        cardShow: json["card_show"] == null ? null : json["card_show"],
        icon: json["icon"] == null ? null : json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "has_archive": hasArchive == null ? null : hasArchive,
        "values": values == null
            ? null
            : List<dynamic>.from(values!.map((x) => x.toJson())),
        "display_after": displayAfter == null ? null : displayAfter,
        "show": show == null ? null : show,
        "card_show": cardShow == null ? null : cardShow,
        "icon": icon == null ? null : icon,
      };
}

class Value {
  Value({
    required this.name,
    required this.value,
    required this.link,
    required this.slug,
    required this.options,
  });

  String name;
  String value;
  String link;
  String slug;
  dynamic options;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        name: json["name"] == null ? null : json["name"],
        value: json["value"] == null ? null : json["value"],
        link: json["link"] == null ? null : json["link"],
        slug: json["slug"] == null ? null : json["slug"],
        options: json["options"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "value": value == null ? null : value,
        "link": link == null ? null : link,
        "slug": slug == null ? null : slug,
        "options": options,
      };
}

class OptionsClass {
  OptionsClass({
    required this.hasLabel,
    required this.bgColor,
    required this.color,
  });

  bool hasLabel;
  String bgColor;
  String color;

  factory OptionsClass.fromJson(Map<String, dynamic> json) => OptionsClass(
        hasLabel: json["has_label"] == null ? null : json["has_label"],
        bgColor: json["bg_color"] == null ? null : json["bg_color"],
        color: json["color"] == null ? null : json["color"],
      );

  Map<String, dynamic> toJson() => {
        "has_label": hasLabel == null ? null : hasLabel,
        "bg_color": bgColor == null ? null : bgColor,
        "color": color == null ? null : color,
      };
}

class Gallery {
  Gallery({
    required this.image,
    required this.alt,
  });

  String image;
  String alt;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        image: json["image"] == null ? null : json["image"],
        alt: json["alt"] == null ? null : json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image,
        "alt": alt == null ? null : alt,
      };
}

class OfferType {
  OfferType({
    required this.name,
    required this.value,
    required this.link,
    required this.slug,
    required this.options,
  });

  String name;
  String value;
  String link;
  String slug;
  OptionsClass options;

  factory OfferType.fromJson(Map<String, dynamic> json) => OfferType(
        name: json["name"] == null ? null : json["name"],
        value: json["value"] == null ? null : json["value"],
        link: json["link"] == null ? null : json["link"],
        slug: json["slug"] == null ? null : json["slug"],
        options: OptionsClass.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "value": value == null ? null : value,
        "link": link == null ? null : link,
        "slug": slug == null ? null : slug,
        "options": options == null ? null : options.toJson(),
      };
}

class Price {
  Price({
    required this.price,
    required this.isRange,
  });

  String price;
  bool isRange;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        price: json["price"] == null ? null : json["price"],
        isRange: json["is_range"] == null ? null : json["is_range"],
      );

  Map<String, dynamic> toJson() => {
        "price": price == null ? null : price,
        "is_range": isRange == null ? null : isRange,
      };
}
