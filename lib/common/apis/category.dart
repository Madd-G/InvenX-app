import 'package:invenx_app/common/entities/entities.dart';
import 'package:invenx_app/common/utils/utils.dart';

class CategoryAPI {
  static Future<List<Category>> getCategories() async {
    try {
      var response = await HttpUtil().get('/categories');
      List<dynamic> data = response;
      return data.map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  static Future<Category> getCategoryById(int id) async {
    try {
      var response = await HttpUtil().get('/categories/$id');
      return Category.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }
}
