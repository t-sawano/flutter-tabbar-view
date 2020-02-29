import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//
class VariableLengthCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(child: VariableLengthCard());
}

class VariableLengthCardBody extends StatelessWidget {
  final double _widgetheight = 100.0;
  final List<Widget> _textList = [];

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => CardLengthProvider(_widgetheight),
        child: Consumer<CardLengthProvider>(
          builder: (_, provider, __) {
            return Column(children: <Widget>[
              // Container(
              //   height: 1000,
              //   decoration: BoxDecoration(color: Colors.greenAccent),
              //   child: Row(
              //     children: _textList,
              //   ),
              // ),
              FlatButton(
                  color: Colors.greenAccent,
                  onPressed: () {
                    _textList.add(_textFieldWidget());
                    provider.setWidgetNumber(_textList.length);
                  },
                  child:
                      Row(children: <Widget>[Icon(Icons.add), Text("追加する")])),
            ]);
          },
        ),
      );

  Widget _textFieldWidget() => Expanded(
        child: TextField(),
      );
}

//
class CardLengthProvider with ChangeNotifier {
  CardLengthProvider(this._widgetHeight);

  // 内部Widgetの高さ
  final double _widgetHeight;
  // Widgetの数
  int _widgetNumber = 1;

  // カードの高さ
  double get cardHeight => _widgetHeight * _widgetNumber;

  // 数が変化するWidgetの数をセットする
  void setWidgetNumber(int num) {
    _widgetNumber = num;
    notifyListeners();
  }
}
