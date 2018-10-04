import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_validation_demo_flutter/validator.dart';

class InputValidationPage extends StatefulWidget {
  InputValidationPage({
    @required this.title,
    this.inputDecoration = const InputDecoration(),
    this.textFieldStyle,
    this.textAlign = TextAlign.start,
    @required this.submitText,
    @required this.keyboardType,
    @required this.inputFormatter,
    @required this.submitValidator,
    this.onSubmit,
  });
  final String title;
  final InputDecoration inputDecoration;
  final TextStyle textFieldStyle;
  final TextAlign textAlign;
  final String submitText;
  final TextInputType keyboardType;
  final TextInputFormatter inputFormatter;
  final StringValidator submitValidator;
  final ValueChanged<String> onSubmit;

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
    widget.onSubmit(_value);
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

  Widget _buildTextField() {
    return TextField(
      decoration: widget.inputDecoration,
      style: widget.textFieldStyle,
      textAlign: widget.textAlign,
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
          child: Center(child: _buildTextField()),
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
            BoxConstraints.expand(width: double.infinity, height: 60.0),
        child: FlatButton(
          color: Colors.green[400],
          child: Text(widget.submitText, style: TextStyle(fontSize: 20.0)),
          onPressed: _submit,
        ),
      ),
    );
  }
}
