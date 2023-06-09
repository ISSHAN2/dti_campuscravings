import 'package:cloud_firestore/cloud_firestore.dart';

class Menus {
  String? menuID;
  String? sellerUID;
  String? menuInfo;
  String? menuTitle;
  Timestamp? publishedDate;
  String? status;
  String? thumbnailUrl;
  String? menuPrice;

  Menus({
    this.menuID,
    this.menuInfo,
    this.menuTitle,
    this.menuPrice,
    this.publishedDate,
    this.sellerUID,
    this.status,
    this.thumbnailUrl,
  });

  Menus.fromJson(Map<String, dynamic> json) {
    menuID = json["menuID"];
    sellerUID = json["sellerUID"];
    menuTitle = json["menuTitle"];
    menuPrice = json["menuPrice"];
    publishedDate = json["publishedDate"];
    menuInfo = json["menuInfo"];
    status = json["status"];
    thumbnailUrl = json["thumbnailUrl"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["menuID"] = menuID;
    data["sellerUID"] = sellerUID;
    data["menuTitle"] = menuTitle;
    data["menuPrice"] = menuPrice;
    data["publishedDate"] = publishedDate;
    data["menuInfo"] = menuInfo;
    data["status"] = status;
    data["thumbnailUrl"] = thumbnailUrl;

    return data;
  }
}

