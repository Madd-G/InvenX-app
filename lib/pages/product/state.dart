import 'package:get/get.dart';
import 'package:invenx_app/common/entities/entities.dart';

class ProductState {
  RxList<Product> products = <Product>[].obs;
  RxList<Category> categories = <Category>[].obs;
  bool isLoading = false;
  RxInt skip = 0.obs;
  RxInt limit = 10.obs;
  bool hasMoreData = true;
  RxString? category = 'Pilih Kategori Barang'.obs;
  RxInt? categoryId = 1.obs;
  RxString? group = 'Pilih Kelompok Barang'.obs;

  final List<ProductGroup> groups = [
    ProductGroup(
      categoryName: 'Electronics',
      categoryId: 1,
      groups: ['Smartphone', 'Laptop', 'Refrigerator', 'Others'],
    ),
    ProductGroup(
      categoryName: 'Clothing',
      categoryId: 2,
      groups: ['Shirt', 'Pants', 'Dress', 'Others'],
    ),
    ProductGroup(
      categoryName: 'Books',
      categoryId: 3,
      groups: ['Fiction', 'Non-Fiction', 'Comic', 'Others'],
    ),
  ];
}
