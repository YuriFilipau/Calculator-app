import 'package:calculator_app/my_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userQuestion = '';
  var userAnswer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '+',
    '3',
    '2',
    '1',
    '-',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQuestion,
                        style:
                            const TextStyle(color: Colors.green, fontSize: 24),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userAnswer,
                        style:
                            const TextStyle(color: Colors.green, fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 30,
              thickness: 3,
              color: Colors.white10,
              indent: 10,
              endIndent: 10,
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        color: Colors.orangeAccent,
                        textColor: Colors.white,
                        title: buttons[index],
                        onTap: () {
                          setState(() {
                            userQuestion = '';
                          });
                        },
                      );
                    } else if (index == 1) {
                      return MyButton(
                        color: Colors.red,
                        textColor: Colors.white,
                        title: buttons[index],
                        onTap: () {
                          setState(
                            () {
                              userQuestion = userQuestion.substring(
                                  0, userQuestion.length - 1);
                            },
                          );
                        },
                      );
                    } else if (index == 19) {
                      return MyButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        title: buttons[index],
                        onTap: () {
                          setState(
                            () {
                              equalPressed();
                            },
                          );
                        },
                      );
                    }
                    else if (index == 18) {
                      return MyButton(
                        color: Colors.white10,
                        textColor: Colors.white,
                        title: buttons[index],
                        onTap: () {
                          setState(
                                () {
                              ansPressed();
                            },
                          );
                        },
                      );
                    } else {
                      return MyButton(
                        onTap: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                        title: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.green
                            : Colors.white10,
                        textColor: Colors.white,
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == 'C' ||
        x == 'DEL' ||
        x == '%' ||
        x == '/' ||
        x == 'x' ||
        x == '+' ||
        x == '-' ||
        x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
  void ansPressed() {
    String finalQuestion = userQuestion;
    finalQuestion=finalQuestion.replaceAll('ANS',userAnswer);
    userQuestion = userAnswer;
  }
}
