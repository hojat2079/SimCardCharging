import 'package:dio/dio.dart';
import 'package:simcard_charging/data/api/api_service.dart';
import 'package:simcard_charging/data/entity/charge.dart';
import 'package:simcard_charging/data/validator_response.dart';

final DioApiService apiService = DioApiService(Dio());

class DioApiService with HttpResponseValidator implements ApiService {
  Dio apiService;

  DioApiService(this.apiService);

  @override
  Future<String> chargeSimCard(Charge charge) async {
    final Response response = await apiService.post(
      'https://chr724.ir/services/v3/EasyCharge/topup',
      data: FormData.fromMap(charge.toJson()),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    validateResponse(response);
    return (response.headers.map)['location']![0];
  }
}
