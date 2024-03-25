import 'package:get/get.dart';
import 'package:invenx_app/common/entities/entities.dart';
import 'package:invenx_app/common/utils/utils.dart';
import 'package:invenx_app/pages/product/controller.dart';

final ProductController controller = Get.put(ProductController());

class ProductAPI {
  static Future<List<Product>> getAllProducts() async {
    try {
      var response = await HttpUtil().get('/products');
      List<dynamic> data = response;
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  static Future<List<Product>> searchProducts(String query) async {
    try {
      Map<String, dynamic> queryParameters = {
        'query': query,
      };
      var response = await HttpUtil()
          .get('/products/search', queryParameters: queryParameters);
      List<dynamic> data = response;
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  static Future<List<Product>> getPaginatedProducts() async {
    try {
      Map<String, dynamic> queryParameters = {
        'limit': controller.state.limit.toString(),
        'skip': (controller.state.skip * 10).toString(),
      };
      var response = await HttpUtil()
          .get('/products/paginated', queryParameters: queryParameters);
      final List<Product> data = List<Product>.from(
        response["data"].map((x) => Product.fromJson(x)),
      );
      return data;
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  static Future<void> createProduct(Product product) async {
    try {
      await HttpUtil().post('/products', data: product.toJson());
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  static Future<Product> getProductById(int id) async {
    try {
      var response = await HttpUtil().get('/products/$id');
      return Product.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }

  static Future<void> updateProduct(Product product) async {
    try {
      await HttpUtil().put('/products/${product.id}', data: product.toJson());
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  static Future<void> deleteProduct(int id) async {
    try {
      await HttpUtil().delete('/products/$id');
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

  static Future<void> deleteBulkProducts(List<int> ids) async {
    try {
      await HttpUtil().delete('/products', data: {'ids': ids});
    } catch (e) {
      throw Exception('Failed to delete bulk products: $e');
    }
  }
}
