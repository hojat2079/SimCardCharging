import 'package:dio/dio.dart';
import 'package:simcard_charging/util/custom_error.dart';

class HttpResponseValidator {
  validateResponse(Response response) {
    if (response.statusCode != 200 &&
        response.statusCode != 302 &&
        response.statusCode != 201) {
      throw CustomError(
        errorCode: response.statusCode!,
        message: (response.data as Map<String, dynamic>)['message'] ??
            response.statusMessage,
      );
    }
  }
}
