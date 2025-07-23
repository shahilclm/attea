import '/core/api/base_url_constant.dart';
import '/core/api/dio_helper.dart';
import 'package:dio/dio.dart';

class ApiService{
  static Future fetchData({
    required String endpoint,
    required ApiType apiType,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      Response response = await DioHelper().get(
        endpoint,
        type: apiType,
        queryParameters: queryParams,
      );
      return response.data;
    } catch (e) {
      throw DioHelper().handleError(e);
    }
  }
}
