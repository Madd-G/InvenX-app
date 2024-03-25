import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/common/apis/apis.dart';
import 'package:invenx_app/common/apis/category.dart';
import 'package:invenx_app/common/entities/entities.dart';
import 'package:invenx_app/pages/product/index.dart';

class ProductController extends GetxController with ScrollMixin {
  final ProductState state = ProductState();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController updateProductNameController =
      TextEditingController();
  final TextEditingController updateStockController = TextEditingController();
  final TextEditingController updatePriceController = TextEditingController();
  RxBool isEditing = false.obs;
  RxList<bool> selectedList = <bool>[].obs;
  RxList<int> selectedIds = <int>[].obs;

  @override
  void onInit() {
    getPaginatedProducts();
    // fetchAllProducts();
    super.onInit();
  }

  @override
  void onClose() {
    productNameController.clear();
    stockController.clear();
    priceController.clear();
    updateProductNameController.clear();
    updateStockController.clear();
    updatePriceController.clear();
    super.onClose();
  }

  @override
  Future<void> onEndScroll() async {
    await getPaginatedProducts();
    // await fetchAllProducts();
  }

  @override
  Future<void> onTopScroll() async {
    await getPaginatedProducts();
  }

  Future<void> fetchAllProducts() async {
    var productList = await ProductAPI.getAllProducts();
    state.products.assignAll(productList);
    selectedIds.clear();
  }

  Future<void> getPaginatedProducts() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      state.isLoading = true;
      var productList = await ProductAPI.getPaginatedProducts();

      state.products.addAll(productList);

      if (productList.length < state.limit.value) {
        state.hasMoreData = false;
      }

      state.skip++;
      update();
    } catch (e) {
      debugPrint('Error fetching data: $e');
    } finally {
      state.isLoading = false;
      update();
    }
  }

  Future<void> deleteMultipleProduct(List<int> productIds) async {
    await ProductAPI.deleteBulkProducts(productIds);
  }

  Future<void> deleteProduct(int productIds) async {
    await ProductAPI.deleteProduct(productIds);
  }

  Future<void> fetchCategories() async {
    var categoryList = await CategoryAPI.getCategories();
    state.categories.assignAll(categoryList);
  }

  Future<void> addProduct() async {
    var newProduct = Product(
      categoryId: state.categoryId!.value,
      productName: productNameController.text,
      stock: int.parse(stockController.text),
      productGroup: state.group!.value,
      price: int.parse(priceController.text),
    );

    await ProductAPI.createProduct(newProduct);
    productNameController.clear();
    stockController.clear();
    priceController.clear();
    // fetchAllProducts();
    // update();
    // getPaginatedProducts();
    // update();
  }

  Future<void> updateProduct(int id) async {
    var newProduct = Product(
      id: id,
      categoryId: state.categoryId!.value,
      productName: updateProductNameController.text,
      stock: int.parse(updateStockController.text),
      productGroup: state.group!.value,
      price: int.parse(updatePriceController.text),
    );
    await ProductAPI.updateProduct(newProduct);
    await fetchAllProducts();
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
    if (!isEditing.value) {
      // Clear all selections when editing is toggled off
      selectedList
          .assignAll(List.generate(state.products.length, (_) => false));
      selectedIds.clear();
    } else {
      // Initialize selectedList when editing is toggled on
      selectedList
          .assignAll(List.generate(state.products.length, (_) => false));
      selectedIds.clear();
    }
  }

  bool isAllSelected() {
    return selectedList.every((element) => element);
  }

  void toggleSelectAll() {
    bool allSelected = selectedList.every((element) => element == true);
    selectedList.assignAll(List.generate(
        state.products.length, (_) => !allSelected)); // Toggle all

    // Update selectedIds accordingly
    if (allSelected) {
      selectedIds.clear();
    } else {
      for (int i = 0; i < state.products.length; i++) {
        if (selectedList[i]) {
          selectedIds.add(state.products[i].id!);
        }
      }
    }
  }

  void toggleProductSelection(int index) {
    selectedList[index] = !selectedList[index];

    // Update selectedIds accordingly
    if (selectedList[index]) {
      selectedIds.add(state.products[index].id!);
    } else {
      selectedIds.remove(state.products[index].id);
    }
  }
}
