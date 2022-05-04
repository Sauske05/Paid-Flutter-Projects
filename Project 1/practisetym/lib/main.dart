import 'package:flutter/material.dart';

import './questions.dart';
import './buttons.dart';
import './finaltext.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _listcount = 0;
  final _questionList = const [
    {
      'question': "What is your favourite animal?",
      'answer': [
        {'text': 'Eagle', 'score': 10},
        {'text': 'Lion', 'score': 7},
        {'text': 'Tiger', 'score': 8},
        {'text': 'Turtle', 'score': 6},
        {'text': 'Horse', 'score': 9}
      ]
    },
    {
      'question': 'What is your favourite food?',
      'answer': [
        {'text': 'Pizza', 'score': 10},
        {'text': 'Burger', 'score': 7},
        {'text': 'Mo:Mo', 'score': 8},
        {'text': 'Daal Bhat', 'score': 6},
        {'text': 'Masu', 'score': 9}
      ]
    },
    {
      'question': 'What is your favourite color?',
      'answer': [
        {'text': 'Red', 'score': 10},
        {'text': 'Blue', 'score': 7},
        {'text': 'Green', 'score': 8},
        {'text': 'Yellow', 'score': 6},
        {'text': 'Orange', 'score': 9}
      ]
    },
    {
      'question': 'What is your favourite anime?',
      'answer': [
        {'text': 'Naruto', 'score': 10},
        {'text': 'Bleach', 'score': 7},
        {'text': 'AOT', 'score': 8},
        {'text': 'One Piece', 'score': 6},
        {'text': 'DBZ', 'score': 9}
      ]
    }
  ];
  int _totalscore = 0;

  increase(int score) {
    _totalscore += score;
    setState(() {
      _listcount += 1;
    });
  }

  reset() {
    setState(() {
      _totalscore = 0;
      _listcount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Practice'),
          centerTitle: true,
        ),
        body: _listcount < _questionList.length
            ? Column(
                children: [
                  Questions(_questionList[_listcount]['question']),
                  ...(_questionList[_listcount]['answer']
                          as List<Map<String, Object>>)
                      .map((answers) {
                    return Button(
                        () => increase(answers['score']), answers['text']);
                  }).toList()
                ],
              )
            : Finaltext(_totalscore, reset));
  }
}
