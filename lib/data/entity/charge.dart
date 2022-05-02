import 'package:simcard_charging/util/constant.dart';

class Charge {
  String type;
  String amount;
  String callPhone;
  String firstOutputType;
  String secondOutputType;
  String issuer;
  String webserviceId;

  Charge({
    required this.type,
    required this.amount,
    required this.callPhone,
    this.firstOutputType = 'json',
    this.secondOutputType = 'json',
    this.issuer = Constant.issuer,
    this.webserviceId = Constant.webserviceId,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'amount': amount,
      'cellphone': callPhone,
      'firstUOutputType': firstOutputType,
      'secondOutputType': secondOutputType,
      'issuer': issuer,
      'webserviceId': webserviceId
    };
  }
}
