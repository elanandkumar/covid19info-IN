import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:in_covid19_info/services/covid19.data.dart';
import 'package:in_covid19_info/widgets/states.table.dart';
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
  Map<String, dynamic> summaryAsOfNow;
  List<dynamic> statesData;
  List<dynamic> casesTimeSeries;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    var result = await covid19infoModal.getCovid19Summary();
    statesData = result['statewise'];
    summaryAsOfNow = statesData[0];
    casesTimeSeries = result['cases_time_series'];

    this.setState(() {
      showSpinner = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  dynamic _renderHomePage() {
    if (summaryAsOfNow == null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 80),
        child: Text(
          'Loading...',
          textAlign: TextAlign.center,
        ),
      );
    }
    return Column(
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
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('C - Confirmed'),
              Text('A - Active'),
              Text('R - Recovered')
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              return _getData();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(bottom: 20),
              child: StatesTable(data: statesData),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: _renderHomePage(),
      ),
    );
  }
}
