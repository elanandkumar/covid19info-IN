import 'package:flutter/material.dart';
import 'package:in_covid19_info/screens/alerts.screen.dart';
import 'package:in_covid19_info/screens/faq.screen.dart';
import 'package:in_covid19_info/screens/helpful.links.screen.dart';
import 'package:in_covid19_info/screens/home.screen.dart';
import 'package:in_covid19_info/widgets/FABBottomAppBar.dart';

PageController _pageController = PageController(initialPage: 0, keepPage: true);

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome.screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _selectedTab(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOutQuint,
    );
  }

  List<Widget> _getSelectedPage() {
    return [
      HomeScreen(),
      Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'May be...Coming Soon...',
            style: TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          )),
      HelpfulLinksScreen(),
      FaqScreen(),
    ];
  }

  List<FABBottomAppBarItem> _navItemBuilder() {
    return [
      FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
      FABBottomAppBarItem(iconData: Icons.graphic_eq, text: 'Graphs'),
      FABBottomAppBarItem(iconData: Icons.link, text: 'Links'),
      FABBottomAppBarItem(iconData: Icons.question_answer, text: 'FAQ'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
        leading: Image.asset(
          'assets/images/app_icon.png',
          cacheWidth: 44,
          cacheHeight: 44,
        ),
        title: Text(
          'Covid19 Info - IN',
          style: TextStyle(
            color: Colors.grey.shade100,
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: _getSelectedPage(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
        onPressed: () {
          Navigator.pushNamed(context, AlertsScreen.id);
        },
        child: Icon(
          Icons.notifications_active,
          color: Colors.white,
        ),
        elevation: 5.0,
      ),
      bottomNavigationBar: FABBottomAppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onTabSelected: _selectedTab,
        notchedShape: CircularNotchedRectangle(),
        selectedColor: Theme.of(context).colorScheme.onPrimary,
        color: Theme.of(context).colorScheme.secondary,
        centerItemText: 'Notifications',
        items: _navItemBuilder(),
      ),
    );
  }
}
