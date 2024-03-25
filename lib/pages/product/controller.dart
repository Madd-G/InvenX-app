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
  final TextEditingController updateProductNameController = TextEditingController();
  final TextEditingController updateStockController = TextEditingController();
  final TextEditingController updatePriceController = TextEditingController();

  @override
  void onInit() {
    getPaginatedProducts();
    fetchAllProducts();
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

  void filterProduct(String productName) {
    if (productName.isEmpty) {
      // Jika input pencarian kosong, atur foundProducts ke list kosong
      state.foundProducts.value = [];
    } else {
      // Jika ada input pencarian, filter daftar produk awal berdasarkan nama
      List<Product> results = state.initialProducts.where((product) =>
          product.productName.toLowerCase().contains(productName.toLowerCase())).toList();
      state.foundProducts.value = results;
    }
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
    state.initialProducts = productList;
    state.selectedIds.clear();
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
    state.isEditing.value = !state.isEditing.value;
    if (!state.isEditing.value) {
      // Clear all selections when editing is toggled off
      state.selectedList
          .assignAll(List.generate(state.products.length, (_) => false));
      state.selectedIds.clear();
    } else {
      // Initialize selectedList when editing is toggled on
      state.selectedList
          .assignAll(List.generate(state.products.length, (_) => false));
      state.selectedIds.clear();
    }
  }

  bool isAllSelected() {
    return state.selectedList.every((element) => element);
  }

  void toggleSelectAll() {
    bool allSelected = state.selectedList.every((element) => element == true);
    state.selectedList.assignAll(List.generate(
        state.products.length, (_) => !allSelected)); // Toggle all

    // Update selectedIds accordingly
    if (allSelected) {
      state.selectedIds.clear();
    } else {
      for (int i = 0; i < state.products.length; i++) {
        if (state.selectedList[i]) {
          state.selectedIds.add(state.products[i].id!);
        }
      }
    }
  }

  void toggleProductSelection(int index) {
    state.selectedList[index] = !state.selectedList[index];

    if (state.selectedList[index]) {
      state.selectedIds.add(state.products[index].id!);
    } else {
      state.selectedIds.remove(state.products[index].id);
    }
  }
}
