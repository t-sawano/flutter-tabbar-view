import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyListWidget extends StatelessWidget {
  final ListViewWidgetProvider _provider;

  MyListWidget(this._provider) {
    final list = [
      MyData("要素１"),
      MyData("要素２"),
      MyData("要素３"),
      MyData("要素４"),
      MyData("要素５"),
    ];

    _provider.setData(list);
    _provider.createWidgets(_provider);
  }

  @override
  Widget build(BuildContext context) {
    return MyListView(_provider);
  }
}

class MyData {
  String _args;

  MyData(this._args);
  String get args => _args;

  void changeParam(String arg) {
    _args = arg;
    print("MyData => $_args");
  }
}

class ListViewWidgetProvider with ChangeNotifier {
  final List<MyData> _data = [];
  final List<Widget> _widgets = [];
  List<MyData> get data => _data;
  List<Widget> get widgets => _widgets;

  void changeArg(int index, String arg) {
    _data[index].changeParam(arg);
    notifyListeners();

    print("変更されました。 ${this._data[index].args}");
  }

  void setData(List<MyData> data) {
    _data.addAll(data);
    notifyListeners();
  }

  void createWidgets(ListViewWidgetProvider provider) {
    _widgets.addAll(this
        ._data
        .map<MyWidget>(
            (element) => MyWidget(this._data.indexOf(element), provider))
        .toList());
    notifyListeners();
  }
}

class MyWidget extends StatelessWidget {
  final int _index;
  final ListViewWidgetProvider _provider;
  MyWidget(this._index, this._provider);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
                // ここにConsumerを配置しないと変更の通知がいかない
                child:
                    Consumer<ListViewWidgetProvider>(builder: (_, model, __) {
              return Text("${model.data[_index].args}");
            })),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: TextFormField(
                  initialValue: "${_provider.data[_index].args}",
                  onChanged: (value) {
                    // この変更事態でMyDataの値が変更される。
                    _provider.changeArg(_index, value);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  final ListViewWidgetProvider _provider;

  MyListView(this._provider);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider<ListViewWidgetProvider>(
        create: (_) => _provider,
        child: Consumer<ListViewWidgetProvider>(
          builder: (_, provider, __) {
            return ListView.builder(
              itemCount: provider.widgets.length,
              itemBuilder: (_, index) => provider.widgets[index],
            );
          },
        ),
      ),
    );
  }
}
