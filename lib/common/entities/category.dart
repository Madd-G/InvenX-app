class Category {
  final int id;
  final String categoryName;
  final String createdAt;
  final String updatedAt;

  Category({
    required this.id,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      categoryName: json['category_name'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_name': categoryName,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
