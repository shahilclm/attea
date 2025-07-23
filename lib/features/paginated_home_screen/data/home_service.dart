import '/core/api/base_url_constant.dart';
import '/core/api/dio_helper.dart';

class HomeService {
  static Future<Map<String, dynamic>?> getPost(int skip, int limit) async {
    try {
      final response = await DioHelper().get(
        '/products',
        type: ApiType.product,
        queryParameters: {
          'skip': skip,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }
}
