import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:rflutter_alert/rflutter_alert.dart";
import 'quiz.dart';

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
  Quiz quiz = new Quiz();
  List<Icon> scoreKeeper = [];

  void nextQuestion({bool playerAnswer}) {
    setState(() {
      if (quiz.isFinished()) {
        scoreKeeper.clear();
        quiz.reset();
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
          style: AlertStyle(
            animationType: AnimationType.fromTop,
          ),
          buttons: [
            DialogButton(
              child: Text(
                "RESTART",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.green,
              radius: BorderRadius.circular(8.0),
            ),
          ],
        ).show();
      } else {
        if (quiz.getQuestionAnswer() == playerAnswer)
          scoreKeeper.add(
            Icon(Icons.check, color: Colors.green),
          );
        else
          scoreKeeper.add(
            Icon(Icons.close, color: Colors.red),
          );

        quiz.nextQuestion();
      }
    });
  }

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
                      quiz.getQuestionText(),
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
                    onPressed: () => nextQuestion(playerAnswer: true),
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
                    onPressed: () => nextQuestion(playerAnswer: false),
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
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}
