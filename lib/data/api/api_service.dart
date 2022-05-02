import 'package:simcard_charging/data/entity/charge.dart';

abstract class ApiService {
  Future<String> chargeSimCard(Charge charge);
}
