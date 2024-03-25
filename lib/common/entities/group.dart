class ProductGroup {
  final String categoryName;
  final int categoryId;
  final List<String> groups;

  ProductGroup({
    required this.categoryName,
    required this.categoryId,
    required this.groups,
  });
}

// class ProductGroups {
//   static List<ProductGroup> groups = [
//     ProductGroup(
//       categoryName: 'Electronics',
//       groups: ['Smartphone', 'Laptop', 'Refrigerator', 'Others'],
//     ),
//     ProductGroup(
//       categoryName: 'Clothing',
//       groups: ['Shirt', 'Pants', 'Dress', 'Others'],
//     ),
//     ProductGroup(
//       categoryName: 'Books',
//       groups: ['Fiction', 'Non-Fiction', 'Comic', 'Others'],
//     ),
//   ];
// }
