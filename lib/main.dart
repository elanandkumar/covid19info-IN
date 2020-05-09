import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_covid19_info/screens/alerts.screen.dart';
import 'package:in_covid19_info/screens/welcome.screen.two.dart';
import 'package:in_covid19_info/screens/welcome.screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) => runApp(
      Covid19InfoApp(),
    ),
  );
}

Map<int, Color> color = {
  50: Color.fromRGBO(5, 34, 102, .1),
  100: Color.fromRGBO(5, 34, 102, .2),
  200: Color.fromRGBO(5, 34, 102, .3),
  300: Color.fromRGBO(5, 34, 102, .4),
  400: Color.fromRGBO(5, 34, 102, .5),
  500: Color.fromRGBO(5, 34, 102, .6),
  600: Color.fromRGBO(5, 34, 102, .7),
  700: Color.fromRGBO(5, 34, 102, .8),
  800: Color.fromRGBO(5, 34, 102, .9),
  900: Color.fromRGBO(5, 34, 102, 1),
};

MaterialColor darkColorSwatch = MaterialColor(0xFF000000, color);
MaterialColor lightColorSwatch = MaterialColor(0xFFFFFFFF, color);

class Covid19InfoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: lightColorSwatch,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: darkColorSwatch,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreenTwo.id: (context) => WelcomeScreen(),
        AlertsScreen.id: (context) => AlertsScreen(),
      },
    );
  }
}
