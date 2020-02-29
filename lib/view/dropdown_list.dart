import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropdownMenuItemProvider with ChangeNotifier {
  final _items = [
    "砂糖",
    "塩",
    "酢",
    "醤油",
    "味噌",
  ];
  final List<DropdownMenuItem> _widgets = [];
  List<DropdownMenuItem> get widgets => _widgets;
  int _selected;
  int get selected => _selected;

  DropdownMenuItemProvider() {
    _items.asMap().forEach((key, value) {
      _widgets.add(DropdownMenuItem(value: key, child: Text(value)));
    });
  }

  void setSelected(int value) {
    _selected = value;
    notifyListeners();
  }
}

class DropdownListWidget extends StatelessWidget {
  final _provider = DropdownMenuItemProvider();
  DropdownMenuItemProvider get provider => _provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider(
        create: (_) => _provider,
        child: Consumer<DropdownMenuItemProvider>(
          builder: (_, provider, __) => DropdownButton(
              value: provider.selected,
              items: provider.widgets,
              onChanged: (picked) {
                provider.setSelected(picked);
              }),
        ),
      ),
    );
  }
}

class MyWidgetList extends StatelessWidget {
  final List<DropdownListWidget> _items = [
    DropdownListWidget(),
    DropdownListWidget(),
    DropdownListWidget(),
    DropdownListWidget(),
    DropdownListWidget(),
  ];
  List<DropdownListWidget> get items => _items;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: _items.length, itemBuilder: (_, index) => _items[index]),
    );
  }
}
