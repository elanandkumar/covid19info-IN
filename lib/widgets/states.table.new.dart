import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

const Color C_CONFIRMED = Color(0xFFeb3644);
const Color C_ACTIVE = Color(0xFF2e7ff7);
const Color C_RECOVERED = Color(0xFF54a452);
const Color C_DECEASED = Color(0xFF6f767d);

const double W_STATE = 120;
const double W_CONFIRMED = 90;
const double W_ACTIVE = 90;
const double W_RECOVERED = 90;
const double W_DEATHS = 80;

class StatesTableNew extends StatefulWidget {
  StatesTableNew({this.data});
  final List<dynamic> data;

  @override
  _StatesTableNewState createState() => _StatesTableNewState();
}

class _StatesTableNewState extends State<StatesTableNew> {
  static const int sortName = 0;
  static const int sortConfirmed = 1;
  bool isAscending = true;
  int sortType = sortConfirmed;

  @override
  void initState() {
    super.initState();
    statesData.initData(widget.data);
  }

  @override
  void dispose() {
    statesData.destroyData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      color: Colors.transparent,
      child: HorizontalDataTable(
        leftHandSideColumnWidth: W_STATE,
        rightHandSideColumnWidth: 400,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: statesData.stateInfo.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Colors.transparent,
        rightHandSideColBackgroundColor: Colors.transparent,
      ),
      height: MediaQuery.of(context).size.height,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget(
            'State/UT' +
                (sortType == sortName ? (isAscending ? '▲' : '▼') : ''),
            W_STATE,
            Theme.of(context).colorScheme.onPrimary),
        onPressed: () {
          sortType = sortName;
          isAscending = !isAscending;
          statesData.sortName(isAscending);
          setState(() {});
        },
      ),
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget(
            'Confirmed' +
                (sortType == sortConfirmed ? (isAscending ? '▲' : '▼') : ''),
            W_CONFIRMED,
            C_CONFIRMED),
        onPressed: () {
          sortType = sortConfirmed;
          isAscending = !isAscending;
          statesData.sortConfirmed(isAscending);
          setState(() {});
        },
      ),
      _getTitleItemWidget('Active', W_ACTIVE, C_ACTIVE),
      _getTitleItemWidget('Recovered', W_RECOVERED, C_RECOVERED),
      _getTitleItemWidget('Deaths', W_DEATHS, C_DECEASED),
    ];
  }

  Widget _getTitleItemWidget(String label, double width,
      [Color color = Colors.black]) {
    return Container(
      child: Text(label,
          style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      alignment: label.startsWith('State/UT')
          ? Alignment.centerLeft
          : Alignment.centerRight,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text(statesData.stateInfo[index].name),
      width: W_STATE,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            statesData.stateInfo[index].confirmed,
            style: TextStyle(color: C_CONFIRMED),
          ),
          width: W_CONFIRMED,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerRight,
        ),
        Container(
          child: Text(
            statesData.stateInfo[index].active,
            style: TextStyle(color: C_ACTIVE),
          ),
          width: W_ACTIVE,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerRight,
        ),
        Container(
          child: Text(
            statesData.stateInfo[index].recovered,
            style: TextStyle(color: C_RECOVERED),
          ),
          width: W_RECOVERED,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerRight,
        ),
        Container(
          child: Text(
            statesData.stateInfo[index].deaths,
            style: TextStyle(color: C_DECEASED),
          ),
          width: W_DEATHS,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerRight,
        ),
      ],
    );
  }
}

StatesData statesData = StatesData();

class StatesData {
  List<StateInfo> stateInfo = List<StateInfo>();

  void initData(List states) {
    states.skip(1).forEach((state) {
      int confirmed = int.parse(state['confirmed']);
      if (confirmed != 0) {
        stateInfo.add(StateInfo(state['state'], state['confirmed'],
            state['active'], state['recovered'], state['deaths']));
      }
    });
  }

  void destroyData() {
    stateInfo.clear();
  }

  ///
  /// Single sort, sort Name's id
  void sortName(bool isAscending) {
    stateInfo.sort((a, b) {
      return isAscending ? a.name.compareTo(b.name) : b.name.compareTo(a.name);
    });
  }

  ///
  /// sort with Status and Name as the 2nd Sort
  void sortConfirmed(bool isAscending) {
    stateInfo.sort((a, b) {
      int aId = int.parse(a.confirmed);
      int bId = int.parse(b.confirmed);
      return isAscending ? bId - aId : aId - bId;
    });
  }
}

class StateInfo {
  String name;
  String confirmed;
  String active;
  String recovered;
  String deaths;

  StateInfo(
    this.name,
    this.confirmed,
    this.active,
    this.recovered,
    this.deaths,
  );
}
