class Products {
  final int productID;
  final String productName;
  final String category;
  final int price;

  Products.fromJson(Map<String, dynamic> json)
      : productID = json['productID'],
        productName = json['productName'],
        category = json['category'],
        price = json['price'];
  Map<String, dynamic> toJson() => {
        "productID": productID,
        "productName": productName,
        "category": category,
        "price": price
      };
  @override
  String toString() {
    return '{ ${this.productID}, ${this.productName} , ${this.category},${this.price}}';
  }
}
