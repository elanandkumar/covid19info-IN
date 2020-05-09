import 'package:flutter/material.dart';
import 'dart:async';
import 'package:in_covid19_info/services/covid19.data.dart';
import 'package:in_covid19_info/utils/custom.alert.dart';
import 'package:in_covid19_info/widgets/retry.button.dart';
import 'package:in_covid19_info/widgets/states.table.new.dart';
import 'package:in_covid19_info/widgets/stats.tile.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

Covid19InfoModel covid19infoModal = Covid19InfoModel();

class HomeScreen extends StatefulWidget {
  static String id = 'home.screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSpinner = false;
  bool hasError = false;
  String preloadingText = "Loading...";
  Map<String, dynamic> summaryAsOfNow;
  List<dynamic> statesData;
  List<dynamic> casesTimeSeries;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(milliseconds: 500), _getData);
  }

  _getData() async {
    this.setState(() {
      showSpinner = true;
      hasError = false;
      preloadingText = "Loading...";
    });

    var result = await covid19infoModal.getCovid19Summary();
    if (result["error"] == true) {
      CustomAlert.show(context, result["statusCode"]);
      this.setState(() {
        showSpinner = false;
        hasError = true;
        preloadingText = "Error during communication. Please try again!";
      });
      return null;
    }
    statesData = result['statewise'];
    summaryAsOfNow = statesData[0];
    casesTimeSeries = result['cases_time_series'];

    this.setState(() {
      hasError = false;
      showSpinner = false;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  bool notNull(Object o) => o != null;

  dynamic _renderHomePage() {
    if (summaryAsOfNow == null) {
      return Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 80),
            child: Text(
              preloadingText,
              textAlign: TextAlign.center,
            ),
          ),
          hasError
              ? RetryButton(
                  onPressed: _getData,
                )
              : null
        ].where(notNull).toList(),
      );
    }
    return RefreshIndicator(
      onRefresh: () {
        return _getData();
      },
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StatsTile(
                  label: 'Confirmed',
                  value: summaryAsOfNow['confirmed'],
                  delta: summaryAsOfNow['deltaconfirmed'],
                  seriesData: casesTimeSeries,
                  color: Color(0xFFeb3644),
                ),
                SizedBox(width: 10),
                StatsTile(
                  label: 'Active',
                  value: summaryAsOfNow['active'],
                  seriesData: casesTimeSeries,
                  color: Color(0xFF2e7ff7),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StatsTile(
                  label: 'Recovered',
                  value: summaryAsOfNow['recovered'],
                  delta: summaryAsOfNow['deltarecovered'],
                  seriesData: casesTimeSeries,
                  color: Color(0xFF54a452),
                ),
                SizedBox(width: 10),
                StatsTile(
                  label: 'Deceased',
                  value: summaryAsOfNow['deaths'],
                  delta: summaryAsOfNow['deltadeaths'],
                  seriesData: casesTimeSeries,
                  color: Color(0xFF6f767d),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(bottom: 20),
            child: StatesTableNew(data: statesData),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        color: Theme.of(context).colorScheme.primary,
        inAsyncCall: showSpinner,
        child: _renderHomePage(),
      ),
    );
  }
}
