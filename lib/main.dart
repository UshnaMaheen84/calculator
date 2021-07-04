import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:eval_ex/eval_ex.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String expression = "";
  double equationFontSize = 25.0;
  String result = "";
  String result2 = "";
  double resultFontSize = 15.0;
  bool _isVisible = false;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        resultFontSize = 15.0;
        equationFontSize = 25.0;
        equation = "0";
        result = "";
        result2 = "";
      }
      else if (buttonText == "⌫") {
        equationFontSize = 25.0;
        resultFontSize = 15.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 15.0;
        resultFontSize = 30.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll("π", '3.1415926535897932');
        expression = expression.replaceAll("√", 'sqrt');
        expression = expression.replaceAll("%", '/100');
        expression = expression.replaceAll("mod", '%');
        expression = expression.replaceAll("x10^", '*10^');
        expression = expression.replaceAll("x^2", '^2');


        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';

          if (result.toString().endsWith(".0")) {
            result = int.parse(result.toString().replaceAll(".0", "")+"").toString();
          }
        } catch (e) {
          resultFontSize = 18.0;

          result = e.toString();
        }
      }
      else {
        equationFontSize = 25.0;
        resultFontSize = 15.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor,
      Color textColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      margin: EdgeInsets.all(4),
      child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13.0),
              side: BorderSide(
                  width: 2, color: buttonColor, style: BorderStyle.solid)),
          color: buttonColor,
          padding: EdgeInsets.all(10.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: textColor),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * .16,
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.fromLTRB(5, 15, 15, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      equation,
                      style: TextStyle(fontSize: equationFontSize),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .08,
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: resultFontSize,fontWeight: FontWeight.bold ),
                  ),
                ),
              ],
            ),
          ),


          Expanded(
              child: Divider()
          ),
          Visibility(
            visible: !_isVisible,
            child: Container(
              height: MediaQuery.of(context).size.height * .60,
              alignment: Alignment.bottomCenter,
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 20, 0, 20),
                    width: MediaQuery.of(context).size.width * .70,
                    child: Table(
                      children: [
                        TableRow(children: [
                          buildButton("AC", 1, Colors.purpleAccent, Colors.white),
                          buildButton("⌫", 1, Colors.blue, Colors.white),
                          buildButton("%", 1, Colors.blue, Colors.white),
                        ]),
                        TableRow(children: [
                          buildButton("7", 1, Colors.white, Colors.blue),
                          buildButton("8", 1, Colors.white, Colors.blue),
                          buildButton("9", 1, Colors.white, Colors.blue),
                        ]),
                        TableRow(children: [
                          buildButton("4", 1, Colors.white, Colors.blue),
                          buildButton("5", 1, Colors.white, Colors.blue),
                          buildButton("6", 1, Colors.white, Colors.blue),
                        ]),
                        TableRow(children: [
                          buildButton("1", 1, Colors.white, Colors.blue),
                          buildButton("2", 1, Colors.white, Colors.blue),
                          buildButton("3", 1, Colors.white, Colors.blue),
                        ]),
                        TableRow(children: [
                          buildButton(".", 1, Colors.white, Colors.blue),
                          buildButton("0", 1, Colors.white, Colors.blue),
                          buildButton("00", 1, Colors.white, Colors.blue),
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 15, 20),
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Table(
                      children: [
                        TableRow(children: [
                          buildButton(
                              "÷", 1, Colors.blue, Colors.white),
                        ]),
                        TableRow(children: [
                          buildButton("×", 1, Colors.blue, Colors.white),
                        ]),
                        TableRow(children: [
                          buildButton("-", 1, Colors.blue, Colors.white),
                        ]),
                        TableRow(children: [
                          buildButton("+", 1, Colors.blue, Colors.white),
                        ]),
                        TableRow(children: [
                          buildButton(
                              "=", 1, Colors.greenAccent, Colors.white),
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    width: MediaQuery.of(context).size.width * .05,
                    height: double.infinity,

                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                            side: BorderSide(
                                width: 2,
                                color: Colors.purpleAccent,
                                style: BorderStyle.solid)),
                        color: Colors.purple,
                        padding: EdgeInsets.all(4.0),
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        child: Text(
                          "<",
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white),
                        )),
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: _isVisible,
            child: Container(
              color: Colors.grey[200],
              height: MediaQuery.of(context).size.height * .6,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                    width: MediaQuery.of(context).size.width * .95,
                    child: Table(
                      children: [
                        TableRow(children: [
                          buildButton("sin", 1, Colors.purpleAccent, Colors.white),
                          buildButton("cos", 1, Colors.purpleAccent, Colors.white),
                          buildButton("tan", 1, Colors.purpleAccent, Colors.white),

                        ]),
                        TableRow(children: [
                          buildButton("√", 1, Colors.white, Colors.blue),
                          buildButton("^", 1, Colors.white, Colors.blue),
                          buildButton("^2", 1, Colors.white, Colors.blue),
                        ]),
                        TableRow(children: [
                          buildButton("ln", 1, Colors.white, Colors.blue),
                          buildButton("ln2", 1, Colors.white, Colors.blue),
                          buildButton("e", 1, Colors.white, Colors.blue),
                        ]),
                        TableRow(children: [
                          buildButton("x10^", 1, Colors.white, Colors.blue),
                          buildButton("π", 1, Colors.white, Colors.blue),
                          buildButton("%", 1, Colors.white, Colors.blue),
                        ]),
                        TableRow(children: [
                          buildButton("(", 1, Colors.white, Colors.blue),
                          buildButton(")", 1, Colors.white, Colors.blue),
                          buildButton("mod", 1, Colors.white, Colors.blue),
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    width: MediaQuery.of(context).size.width * .05,
                    height: double.infinity,

                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                            side: BorderSide(
                                width: 2,
                                color: Colors.purpleAccent,
                                style: BorderStyle.solid)),
                        color: Colors.purple,
                        padding: EdgeInsets.all(5.0),
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        child: Text(
                          ">",
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white),
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
