import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _TabbarWidget();
  }
}

class _TabbarWidget extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<_TabbarWidget>
    with SingleTickerProviderStateMixin {
  List<Tab> _tabItems = [
    Tab(child: Container(width: 100.0, child: Text("a", style: TextStyle(color: Colors.white)))),
    Tab(child: Container(width: 100.0, child: Text("b", style: TextStyle(color: Colors.white)))),
    // Tab(child: Text("c")),
    // Tab(child: Text("d")),
    // Tab(child: Text("e")),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabItems.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(child: _body()),
      );

  Widget _body() {
    return Container(
      // width: 300.0,
      // height: 500.0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size(300.0, 0.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: TabBar(
                tabs: _tabItems,
                controller: _tabController,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 2,
                indicatorPadding:
                    EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                indicator: _customIndicator,
                isScrollable: true,
              ),
            ),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          width: 500.0,
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(30.0)),
          child: TabBarView(
              controller: _tabController,
              children: _tabItems.map((tab) {
                return _createTab(tab);
              }).toList()),
        ),
      ),
    );
  }

  Widget _createTab(Tab tab) {
    return Center(
      child: Text(
        "10 min Rest Time",
        style: TextStyle(fontSize: 24.0, color: Colors.white),
      ),
    );
  }
}

final _customIndicator = BubbleTabIndicator(
    padding: EdgeInsets.only(right: 0.0, left: 0.0),
    insets: EdgeInsets.only(left: 0, right: 0),
    indicatorHeight: 50.0,
    indicatorColor: Colors.greenAccent,
    indicatorRadius: 1.0,
    tabBarIndicatorSize: TabBarIndicatorSize.tab);
