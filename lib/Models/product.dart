class Product {
  String? itemId;
  String? itemBrand;
  String? itemName;
  String? itemPrice;
  String? itemImage;
  String? itemRegister;

  Product(
      {this.itemId,
      this.itemBrand,
      this.itemName,
      this.itemPrice,
      this.itemImage,
      this.itemRegister});

  Product.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemBrand = json['item_brand'];
    itemName = json['item_name'];
    itemPrice = json['item_price'];
    itemImage = json['item_image'];
    itemRegister = json['item_register'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['item_brand'] = itemBrand;
    data['item_name'] = itemName;
    data['item_price'] = itemPrice;
    data['item_image'] = itemImage;
    data['item_register'] = itemRegister;
    return data;
  }
}
