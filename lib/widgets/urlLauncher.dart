import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher extends StatelessWidget {
  UrlLauncher({@required this.url, this.label});

  final String url;
  final String label;

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          UrlLink(url),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Container(
              height: 1.0,
              color: Colors.grey,
            ),
          ),
        ],
      );
    }
    return UrlLink(url);
  }
}

class UrlLink extends StatelessWidget {
  UrlLink(this.url);
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Text(
        url.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
