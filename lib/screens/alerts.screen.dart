import 'package:flutter/material.dart';
import 'package:in_covid19_info/services/covid19.data.dart';
import 'package:in_covid19_info/utils/custom.alert.dart';
import 'package:in_covid19_info/widgets/retry.button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:time_formatter/time_formatter.dart';

Covid19InfoModel covid19infoModal = Covid19InfoModel();
const int MAX_ALERT_COUNT = 15;

class AlertsScreen extends StatefulWidget {
  static String id = 'alerts.screen';

  @override
  _AlertsScreenState createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  bool showSpinner = true;
  bool hasError = false;
  String loadText = 'Loading...';
  List<Alert> alerts = List();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      final response = await covid19infoModal.getAlerts() as List;
      final selectedAlerts = response.skip(response.length - MAX_ALERT_COUNT);
      this.setState(() {
        alerts = selectedAlerts.map((data) {
          return Alert.fromJson(data);
        }).toList();
        showSpinner = false;
        hasError = false;
        loadText = "Loading...";
      });
    } catch (e) {
      CustomAlert.show(context, '');
      this.setState(() {
        showSpinner = false;
        hasError = true;
        loadText = 'Error during communication. Please try again!';
      });
    }
  }

  Container _buildAlert(alert) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text(formatTime(alert.timestamp * 1000),
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(
                width: 0,
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
              left: BorderSide(
                width: 1.0,
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
              right: BorderSide(
                width: 1.0,
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
              bottom: BorderSide(
                width: 1.0,
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
            )),
            child: Text(
              alert.update,
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
        iconTheme: IconThemeData().copyWith(
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: hasError
              ? Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(loadText),
                        RetryButton(
                          onPressed: _getData,
                        )
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(0),
                  child: RefreshIndicator(
                    onRefresh: () {
                      return _getData();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: alerts.reversed.map(_buildAlert).toList(),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class Alert {
  final String update;
  final int timestamp;

  Alert({this.update, this.timestamp});

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(update: json['update'], timestamp: json['timestamp']);
  }
}
