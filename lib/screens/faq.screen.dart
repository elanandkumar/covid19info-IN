import 'package:flutter/material.dart';

const List<Map<String, String>> FAQ_DATA = [
  {
    'question':
        "What are your sources? How is the data gathered for this project?",
    'answer':
        'Data source for this project is `covid19India`. They have great api and is open source. For more details, feel free to visit the link https://github.com/covid19india/covid19india-react'
  },
  {
    'question': "Why does covid19india.org have more positive count than MoH?",
    'answer':
        "MoHFW updates the data at a scheduled time. However, we update them based on state press bulletins, official (CM, Health M) handles, PBI, Press Trust of India, ANI reports. These are generally more recent."
  },
  {
    'question': "Who are you?",
    'answer':
        "I am a learner who started learning flutter recently. Found `covid19India` website and repository on github with api. So, thought to leverage it for some learning purpose only. All the credits for  data goes to them."
  },
  {
    'question':
        "Why am I putting in time and resources to do this while not gaining a single penny from it?",
    'answer':
        "It's all about learning. I am doing this only for learning Flutter and nothing else. Happy Learning."
  }
];

class FaqScreen extends StatelessWidget {
  static String id = 'faq.screen';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: FAQ_DATA.map<Widget>((faq) {
            return FAQItemText(
              question: faq['question'],
              answer: faq['answer'],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FAQItemText extends StatelessWidget {
  FAQItemText({@required this.question, this.answer});
  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(question, style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          Text(answer, style: TextStyle(fontSize: 20, color: Colors.blue)),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Container(
              height: 1.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
