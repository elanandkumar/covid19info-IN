import 'package:in_covid19_info/services/networking.dart';

const covid19DataUrl = 'https://api.covid19india.org/data.json';
const covid19AlertsUrl = 'https://api.covid19india.org/updatelog/log.json';
const covid19RawDataUrl = 'https://api.covid19india.org/raw_data.json';

class Covid19InfoModel {
  Future<dynamic> getCovid19Summary() async {
    NetworkHelper networkHelper = NetworkHelper(covid19DataUrl);

    return await networkHelper.getData();
  }

  Future<dynamic> getAlerts() async {
    NetworkHelper networkHelper = NetworkHelper(covid19AlertsUrl);

    return await networkHelper.getData();
  }

  Future<dynamic> getCovid19RawData() async {
    NetworkHelper networkHelper = NetworkHelper(covid19RawDataUrl);

    return await networkHelper.getData();
  }
}
