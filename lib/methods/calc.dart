import 'package:flutter/material.dart';
import './buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculate extends StatefulWidget {
  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {

  var value = '', result = 'ANS: ';
  final List<String> opts = [
    'clr',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+'
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          alignment: Alignment.centerRight,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          decoration: BoxDecoration(color: Colors.black54)),
                      Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          alignment: Alignment.centerRight,
                          child: Text(
                            result,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          decoration: BoxDecoration(color: Colors.black54))
                    ]))),
            Expanded(
                flex: 3,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.1,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: width/(height/2)),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              value = '';
                              result = '0';
                            });
                          },
                          buttonText: opts[index],
                          color: doOperation(opts[index])
                              ? Colors.redAccent
                              : Colors.white,
                          textColor: doOperation(opts[index])
                              ? Colors.white
                              : Colors.black,
                        );
                      } else if (index == 1) {
                        return MyButton(
                          buttontapped: () {},
                          buttonText: opts[index],
                          color: doOperation(opts[index])
                              ? Colors.blueAccent
                              : Colors.white,
                          textColor: doOperation(opts[index])
                              ? Colors.white
                              : Colors.black,
                        );
                      } else if (index == 2) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              value += opts[index];
                            });
                          },
                          buttonText: opts[index],
                          color: doOperation(opts[index])
                              ? Colors.blueAccent
                              : Colors.white,
                          textColor: doOperation(opts[index])
                              ? Colors.white
                              : Colors.black,
                        );
                      } else if (index == 3) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              int len = value.length;
                              if (len > 0) value = value.substring(0, len - 1);
                            });
                          },
                          buttonText: opts[index],
                          color: doOperation(opts[index])
                              ? Colors.redAccent
                              : Colors.white,
                          textColor: doOperation(opts[index])
                              ? Colors.white
                              : Colors.black,
                        );
                      } else if (index == 18) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: opts[index],
                          color: doOperation(opts[index])
                              ? Colors.lightGreen
                              : Colors.white,
                          textColor: doOperation(opts[index])
                              ? Colors.white
                              : Colors.black,
                        );
                      } else {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              value += opts[index];
                            });
                          },
                          buttonText: opts[index],
                          color: doOperation(opts[index])
                              ? Colors.blueAccent
                              : Colors.white,
                          textColor: doOperation(opts[index])
                              ? Colors.white
                              : Colors.black,
                        );
                      }
                    },
                    itemCount: opts.length,
                  ),
                ))
          ]),
    );
  }

  bool doOperation(String s) {
    if (s == '/' ||
        s == '*' ||
        s == '-' ||
        s == '+' ||
        s == '=' ||
        s == 'clr' ||
        s == 'DEL' ||
        s == '+/-' ||
        s == '%') return true;
    return false;
  }

  void equalPressed() {
    String totVal = value;

    Parser p = Parser();
    Expression exp = p.parse(totVal);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    result = eval.toString();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _portraitMode() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Calculate(),
              )
            ]),
      ],
    );
  }

  Widget _landscapeMode() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Calculate(),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _portraitMode();
          } else {
            return _landscapeMode();
          }
        },
      ),
    );
  }
}
