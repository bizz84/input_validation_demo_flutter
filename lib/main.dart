import 'package:flutter/material.dart';
import 'package:input_validation_demo_flutter/input_validation_page.dart';
import 'package:input_validation_demo_flutter/validator.dart';

void main() => runApp(new MyApp());

class DecimalNumberRegexValidator extends RegexValidator {
  DecimalNumberRegexValidator()
      : super(regexSource: "^\$|^(0|([1-9][0-9]{0,3}))(\\.[0-9]{0,2})?\$");
}

class EmailRegexValidator extends RegexValidator {
  EmailRegexValidator()
      : super(regexSource: "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+\$)");
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  void _pushPage(BuildContext context, Widget page) {

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
    ));
  }

  void _forgotPassword(BuildContext context) {
    _pushPage(context, InputValidationPage(
      title: 'Forgot password',
      hintText: 'Enter your email',
      keyboardType: TextInputType.emailAddress,
      inputFormatter: ValidatorInputFormatter(
        validator: EmailRegexValidator()
      ),
    ));
  }

  void _makePayment(BuildContext context) {
    _pushPage(context, InputValidationPage(
      title: 'Make a payment',
      hintText: '£0.00',
      keyboardType: TextInputType.number,
      inputFormatter: ValidatorInputFormatter(
          validator: DecimalNumberRegexValidator()
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Forgot Password'),
            onTap: () => _forgotPassword(context),
          ),
          ListTile(
            title: Text('Make a payment'),
            onTap: () => _makePayment(context),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
