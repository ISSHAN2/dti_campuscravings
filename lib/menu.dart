import 'package:cloud_firestore/cloud_firestore.dart';

class Menus {
  String? menuID;
  String? sellerUID;
  String? menuInfo;
  String? menuTitle;
  Timestamp? publishedDate;
  String? status;
  String? thumbnailUrl;

  Menus({
    this.menuID,
    this.menuInfo,
    this.menuTitle,
    this.publishedDate,
    this.sellerUID,
    this.status,
    this.thumbnailUrl,
  });

  Menus.fromJson(Map<String, dynamic> json) {
    menuID = json["menuID"];
    sellerUID = json["sellerUID"];
    menuTitle = json["menuTitle"];
    publishedDate = json["publishedDate"];
    menuInfo = json["menuInfo"];
    status = json["status"];
    thumbnailUrl = json["thumbnailUrl"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["menuID"] = menuID;
    data["sellerUID"] = sellerUID;
    data["menuTitle"] = menuTitle;
    data["publishedDate"] = publishedDate;
    data["menuInfo"] = menuInfo;
    data["status"] = status;
    data["thumbnailUrl"] = thumbnailUrl;

    return data;
  }
}
