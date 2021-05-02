import 'package:car_washing_app/model/client.dart';

class WashService {
  Client client;
  String serviceType;
  String dateTime;

  WashService({this.client, this.serviceType, this.dateTime});

  WashService.fromJson(Map<String, dynamic> json) {
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    serviceType = json['service_type'];
    dateTime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.client != null) {
      data['client'] = this.client.toJson();
    }
    data['service_type'] = this.serviceType;
    data['datetime'] = this.dateTime;
    return data;
  }
}
