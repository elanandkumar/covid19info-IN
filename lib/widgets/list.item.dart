import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String item;
  ListItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(this.item)
    );
  }
}