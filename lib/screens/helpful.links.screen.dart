import 'package:flutter/material.dart';
import 'package:in_covid19_info/widgets/urlLauncher.dart';

const List<Map<String, String>> URLS_LIST = [
  {
    'url': 'https://github.com/elanandkumar/covid19info-IN/',
    'label': 'Source code'
  },
  {'url': 'https://covid19india.org', 'label': 'Original Creator\'s website'},
  {
    'url': 'https://www.mohfw.gov.in/pdf/coronvavirushelplinenumber.pdf',
    'label': 'HELPLINE NUMBERS [by State]',
  },
  {
    'url': 'https://www.mohfw.gov.in/pdf/coronvavirushelplinenumber.pdf',
    'label': 'HELPLINE NUMBERS [by State]',
  },
  {
    'url': 'https://www.mohfw.gov.in/',
    'label': 'Ministry of Health and Family Welfare, Gov. of India',
  },
  {
    'url': "https://www.who.int/emergencies/diseases/novel-coronavirus-2019",
    'label': "WHO : COVID-19 Home Page",
  },
  {
    'url': "https://www.cdc.gov/coronavirus/2019-ncov/faq.html",
    'label': 'CDC',
  },
  {
    'url': "https://coronavirus.thebaselab.com/",
    'label': "COVID-19 Global Tracker",
  },
  {
    'url': "https://bit.ly/covid19resourcelist",
    'label': "Crowdsourced list of Resources & Essentials from across India",
  },
];

class HelpfulLinksScreen extends StatelessWidget {
  static String id = 'helpful.links.screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: URLS_LIST.map<Widget>((item) {
              return UrlLauncher(url: item['url'], label: item['label']);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
