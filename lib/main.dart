import 'package:flutter/material.dart';
import 'package:input_validation_demo_flutter/input_validation_page.dart';
import 'package:input_validation_demo_flutter/validator.dart';

void main() => runApp(new MyApp());

class DecimalNumberEditingRegexValidator extends RegexValidator {
  DecimalNumberEditingRegexValidator()
      : super(regexSource: "^\$|^(0|([1-9][0-9]{0,3}))(\\.[0-9]{0,2})?\$");
}

class DecimalNumberSubmitValidator implements StringValidator {
  @override
  bool isValid(String value) {
    try {
      final number = double.parse(value);
      return number > 0.0;
    } catch (e) {
      return false;
    }
  }
}

class EmailEditingRegexValidator extends RegexValidator {
  EmailEditingRegexValidator()
      : super(
            regexSource:
                "^[a-zA-Z0-9_.+-]*(@([a-zA-Z0-9-]*(\\.[a-zA-Z0-9-]*)?)?)?\$");
}

class EmailSubmitRegexValidator extends RegexValidator {
  EmailSubmitRegexValidator()
      : super(
            regexSource: "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+\$)");
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
      home: MyHomePage(title: 'Regex Input Validation'),
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

  void _onSubmit(BuildContext context, String value) {
    print(value);
  }

  void _forgotPassword(BuildContext context) {
    _pushPage(
      context,
      InputValidationPage(
        title: 'Forgot password',
        inputDecoration: InputDecoration(
          hintText: 'test@test.com',
        ),
        textFieldStyle: TextStyle(fontSize: 32.0, color: Colors.black87),
        textAlign: TextAlign.start,
        submitText: 'Submit',
        keyboardType: TextInputType.emailAddress,
        inputFormatter: ValidatorInputFormatter(
          editingValidator: EmailEditingRegexValidator(),
        ),
        submitValidator: EmailSubmitRegexValidator(),
        onSubmit: (value) => _onSubmit(context, value),
      ),
    );
  }

  void _makePayment(BuildContext context) {
    _pushPage(
      context,
      InputValidationPage(
        title: 'Make a payment',
        inputDecoration: InputDecoration.collapsed(hintText: '\$0.00'),
        textFieldStyle: TextStyle(fontSize: 32.0, color: Colors.black87),
        textAlign: TextAlign.center,
        submitText: 'Submit',
        keyboardType: TextInputType.number,
        inputFormatter: ValidatorInputFormatter(
          editingValidator: DecimalNumberEditingRegexValidator(),
        ),
        submitValidator: DecimalNumberSubmitValidator(),
        onSubmit: (value) => _onSubmit(context, value),
      ),
    );
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
            title: Text('Make a payment', style: TextStyle(fontSize: 20.0)),
            onTap: () => _makePayment(context),
          ),
          ListTile(
            title: Text('Forgot Password', style: TextStyle(fontSize: 20.0)),
            onTap: () => _forgotPassword(context),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
