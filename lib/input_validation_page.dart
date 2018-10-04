import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class InputValidationPage extends StatefulWidget {
  InputValidationPage({this.title, this.hintText, this.keyboardType, this.inputFormatter});
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputFormatter inputFormatter;
  @override
  _InputValidationPageState createState() => _InputValidationPageState();
}

class _InputValidationPageState extends State<InputValidationPage> {
  TextEditingController _controller;
  FocusNode _focusNode;
  double _value = 0.0;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {
        _value = totalValue();
      });
    });
  }

  double totalValue() {
    try {
      final text = _controller.text;
      return double.parse(text ?? '0');
    } catch (e) {
      return 0.0;
    }
  }

  void _submit() async {
    _focusNode.unfocus();
    final total = totalValue();
    print('total: $total');
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
    return Opacity(
      opacity: _value > 0 ? 1.0 : 0.0,
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
