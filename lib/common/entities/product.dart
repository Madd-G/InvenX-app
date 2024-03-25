class Product {
  final int? id;
  final String productName;
  final int categoryId;
  final int stock;
  final String productGroup;
  final int price;

  Product({
    this.id,
    required this.productName,
    required this.categoryId,
    required this.stock,
    required this.productGroup,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      productName: json['product_name'] as String,
      categoryId: json['category_id'] as int,
      stock: json['stock'] as int,
      productGroup: json['product_group'] as String,
      price: json['price'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_name': productName,
      'category_id': categoryId,
      'stock': stock,
      'product_group': productGroup,
      'price': price,
    };
  }
}
