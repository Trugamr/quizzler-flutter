import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(QuizzlerApp());
}

class QuizzlerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  RaisedButton buildButton({String text, Color color, VoidCallback onPressed}) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
      padding: EdgeInsets.all(10.0),
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'This is where the question will go. You need to anwer it as true of false.',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 8.0, left: 20.0, right: 20.0),
                  child: buildButton(
                    onPressed: () => setState(
                      () => scoreKeeper.add(
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    text: 'True',
                    color: Colors.green,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 8.0, bottom: 20.0, left: 20.0, right: 20.0),
                  child: buildButton(
                    onPressed: () => setState(
                      () => scoreKeeper.add(
                        Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    text: 'False',
                    color: Colors.red,
                  ),
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
        Container(
          height: 40.0,
          padding: EdgeInsets.only(bottom: 16.0, left: 20.0, right: 20.0),
          child: Expanded(
            child: Row(
              children: scoreKeeper,
            ),
          ),
        )
      ],
    );
  }
}
