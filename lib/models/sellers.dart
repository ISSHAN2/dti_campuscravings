class Sellers {
  String? sellerName;
  String? sellerUID;
  String? sellerEmail;
  String? sellerAvatarUrl;

  Sellers({
    this.sellerUID,
    this.sellerAvatarUrl,
    this.sellerEmail,
    this.sellerName,
  });

  Sellers.fromJson(Map<String, dynamic> json) {
    sellerUID = json["sellerUID"];
    sellerName = json["sellerName"];
    sellerEmail = json["sellerEmail"];
    sellerAvatarUrl = json["sellerAvatarUrl"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["sellerUID"] = sellerUID;
    data["sellerAvatarUrl"] = sellerAvatarUrl;
    data["sellerEmail"] = sellerEmail;
    data["sellerName"] = sellerName;
    return data;
  }
}
