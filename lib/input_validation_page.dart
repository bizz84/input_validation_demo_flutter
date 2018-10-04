import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_validation_demo_flutter/validator.dart';

class InputValidationPage extends StatefulWidget {
  InputValidationPage({
    @required this.title,
    @required this.hintText,
    @required this.keyboardType,
    @required this.inputFormatter,
    @required this.submitValidator,
  });
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputFormatter inputFormatter;
  final StringValidator submitValidator;
  @override
  _InputValidationPageState createState() => _InputValidationPageState();
}

class _InputValidationPageState extends State<InputValidationPage> {
  TextEditingController _controller;
  FocusNode _focusNode;
  String _value = '';

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {
        _value = _controller.text;
      });
    });
  }

  void _submit() async {
    _focusNode.unfocus();
    print('value: $_value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontSize: 24.0)),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildTextField(BuildContext context) {
    // https://stackoverflow.com/questions/48706884/change-textfields-underline-in-flutter
    return TextField(
      decoration: InputDecoration.collapsed(hintText: widget.hintText),
      style: TextStyle(fontSize: 32.0, color: Colors.black87),
      textAlign: TextAlign.center,
      keyboardType: widget.keyboardType,
      autofocus: true,
      inputFormatters: [
        widget.inputFormatter,
      ],
      focusNode: _focusNode,
      controller: _controller,
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 80.0),
          child: Center(child: _buildTextField(context)),
        ),
        Expanded(child: Container()),
        _buildDoneButton(context),
      ],
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    bool valid = widget.submitValidator.isValid(_value);
    return Opacity(
      opacity: valid ? 1.0 : 0.0,
      child: Container(
        constraints:
            BoxConstraints.expand(width: double.infinity, height: 48.0),
        child: FlatButton(
          color: Colors.green[400],
          child: Text('Done', style: TextStyle(fontSize: 20.0)),
          onPressed: _submit,
        ),
      ),
    );
  }
}
