import 'package:flutter/material.dart';
import '../widgets/tab-bar.dart';
import '../widgets/tab-item.dart';

class WelcomeScreenTwo extends StatefulWidget {
  static String id = 'welcome.screen';
  WelcomeScreenTwo({Key key}) : super(key: key);

  @override
  _WelcomeScreenTwoState createState() => _WelcomeScreenTwoState();
}

class _WelcomeScreenTwoState extends State<WelcomeScreenTwo>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("Tab Bar Animation"),
      ),
      bottomNavigationBar: CustomTabBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
