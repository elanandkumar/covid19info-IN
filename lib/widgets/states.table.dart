import 'package:flutter/material.dart';

class StatesTable extends StatefulWidget {
  StatesTable({@required this.data});
  final List<dynamic> data;

  @override
  _StatesTableState createState() => _StatesTableState();
}

class _StatesTableState extends State<StatesTable> {
  bool _sortAscending = false;
  int _sortColumnIndex = 1;
  List<dynamic> _data;

  List<DataRow> _renderDataRows() {
    List<DataRow> dataRows = List();

    _data.forEach((d) {
      dataRows.add(DataRow(cells: [
        DataCell(Text(d['state'], style: TextStyle(fontSize: 16))),
        DataCell(Text(d['confirmed'],
            style: TextStyle(color: Colors.red, fontSize: 16))),
        DataCell(Text(d['recovered'],
            style: TextStyle(color: Colors.green, fontSize: 16))),
        DataCell(Text(d['active'],
            style: TextStyle(color: Colors.blue, fontSize: 16))),
        DataCell(Text(d['deaths'],
            style: TextStyle(color: Colors.grey, fontSize: 16))),
      ]));
    });

    return dataRows;
  }

  @override
  void initState() {
    super.initState();
    _data = widget.data.skip(1).toList();
  }

  @override
  void dispose() {
    super.dispose();
    _data = null;
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _sortAscending,
      columns: [
        DataColumn(
          onSort: (columnIndex, sortAscending) {
            this.setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = sortAscending;
              _data.sort((a, b) => a['state'].compareTo(b['state']));
              if (!_sortAscending) {
                _data = _data.reversed.toList();
              }
            });
          },
          label: Text(
            'State/UT',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DataColumn(
            numeric: true,
            onSort: (columnIndex, sortAscending) {
              this.setState(() {
                _sortColumnIndex = columnIndex;
                _sortAscending = sortAscending;
                _data.sort((a, b) => int.parse(a['confirmed'])
                    .compareTo(int.parse(b['confirmed'])));
                if (!_sortAscending) {
                  _data = _data.reversed.toList();
                }
              });
            },
            label: Text(
              'C',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            )),
        DataColumn(
            numeric: true,
            onSort: (columnIndex, sortAscending) {
              this.setState(() {
                _sortColumnIndex = columnIndex;
                _sortAscending = sortAscending;
                _data.sort((a, b) => int.parse(a['recovered'])
                    .compareTo(int.parse(b['recovered'])));
                if (!_sortAscending) {
                  _data = _data.reversed.toList();
                }
              });
            },
            label: Text(
              'R',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            )),
        DataColumn(
            numeric: true,
            onSort: (columnIndex, sortAscending) {
              this.setState(() {
                _sortColumnIndex = columnIndex;
                _sortAscending = sortAscending;
                _data.sort((a, b) =>
                    int.parse(a['active']).compareTo(int.parse(b['active'])));
                if (!_sortAscending) {
                  _data = _data.reversed.toList();
                }
              });
            },
            label: Text(
              'A',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            )),
        DataColumn(
            numeric: true,
            onSort: (columnIndex, sortAscending) {
              this.setState(() {
                _sortColumnIndex = columnIndex;
                _sortAscending = sortAscending;
                _data.sort((a, b) =>
                    int.parse(a['deaths']).compareTo(int.parse(b['deaths'])));
                if (!_sortAscending) {
                  _data = _data.reversed.toList();
                }
              });
            },
            label: Text(
              'D',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
      ],
      rows: _renderDataRows(),
    );
  }
}
