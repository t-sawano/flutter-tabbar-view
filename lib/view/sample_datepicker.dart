import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// 今日日付を基準としたDatePickerを呼び出すstaticクラス
class CommonDatepicker {
  static Future<DateTime> showCommonDatePicker(BuildContext context) async {
    final now = DateTime.now();

    return await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
      locale: Locale("ja"),
    );
  }

  static String dateFormatter(DateTime date) {
    final formatter = DateFormat("yyyy/MM/dd HH:mm:ss");
    return formatter.format(date);
  }
}

class DatePickerProvider with ChangeNotifier {
  DateTime now;
  void changePickedDate(DateTime picked) {
    now = picked;
    notifyListeners();

    print("$now");
  }
}

class TextWithDatePicker extends StatelessWidget {
  final format = DateFormat("yyyy年MM月dd日");
  final TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(25.0)),
      height: 40.0,
      child: ChangeNotifierProvider<DatePickerProvider>(
        create: (_) => DatePickerProvider(),
        child: Consumer<DatePickerProvider>(
          builder: (_, provider, __) => Container(
              child: DateTimeField(
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0),
                border: InputBorder.none,
                hintText: "年/月/日"),
            format: format,
            onShowPicker: (context, value) {
              return CommonDatepicker.showCommonDatePicker(context);
            },
            controller: _controller,
            onChanged: (value) {
              // provider
            },
          )),
        ),
      ),
    );
  }
}

class MyState with ChangeNotifier {
  final List<TextWithDatePicker> _items = [];
  List<TextWithDatePicker> get items => _items;

  MyState() {
    _items.addAll([
      TextWithDatePicker(),
      TextWithDatePicker(),
      TextWithDatePicker(),
      TextWithDatePicker(),
      TextWithDatePicker(),
    ]);
  }
}

class DateTextFieldListView extends StatelessWidget {
  final MyState _provider;
  DateTextFieldListView(this._provider);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 9,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (_, index) {
                    final i = index ~/ 2;
                    if (index.isOdd) return Divider();

                    return _provider.items[i];
                  })),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: ButtonTheme(
                height: 40.0,
                minWidth: 200.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(
                        color: Colors.green,
                        width: 3.0,
                        style: BorderStyle.solid)),
                child: FlatButton(
                  color: Colors.white,
                  child: Text(
                    "次へ",
                    style: TextStyle(color: Colors.green, fontSize: 18.0),
                  ),
                  onPressed: () {
                    print("${DateTime.now()}");
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
