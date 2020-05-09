import 'package:flutter/material.dart';

class RetryButton extends StatelessWidget {
  RetryButton({this.onPressed});

  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).colorScheme.secondary,
      onPressed: onPressed,
      child: Text(
        'Retry',
        style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
      ),
    );
  }
}
