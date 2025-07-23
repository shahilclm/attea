

import '/core/api/api_service.dart';
import '/core/api/base_url_constant.dart';
import '/core/api/endpoints/end_points.dart';

class CoffeeService {
  static Future getCoffee() async {
    return await ApiService.fetchData(
      endpoint: Endpoints.getHotCoffee,
      apiType: ApiType.coffee,
    );
  }
}
