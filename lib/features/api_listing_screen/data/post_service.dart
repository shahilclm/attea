// import '/core/api/base_url_constant.dart';
// import '/core/api/dio_helper.dart';
// import '/exporter/exporter.dart';
// import 'package:dio/dio.dart';

// class PostService {
//   static Future getPost() async {
//     try {
//       Response response = await DioHelper().get('/posts', type: ApiType.base);
//       logSuccess(response);
//       return response.data;
//     } catch (e) {
//       throw DioHelper().handleError(e);
//     }
//   }
// }

import '/core/api/api_service.dart';
import '/core/api/base_url_constant.dart';
import '/core/api/endpoints/end_points.dart';

class PostService {
  static Future getPost()async{
    return await ApiService.fetchData(endpoint: Endpoints.getPost,  apiType:ApiType.base );
  }
  
}