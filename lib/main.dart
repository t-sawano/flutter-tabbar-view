import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myapp/view/sample_datepicker.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

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
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale("en", "US"),
          const Locale("ja", "JP")
        ]);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyState>(
      create: (_) => MyState(),
      child: Consumer<MyState>(
        builder: (_, provider, __) => Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            // child: VariableLengthCard()
            // child: MyListWidget(ListViewWidgetProvider())
            // child: TextWithDatePicker(DatePickerProvider())
            child: DateTextFieldListView(provider),
            //BodyWidget()
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.plus_one),
            onPressed: () {
              print("要素数 => ${provider.items.length}");
              provider.items.asMap().forEach((key, value) {
                print("要素${key + 1} => ${value.controller.text}");
              });
            },
          ),
        ),
      ),
    );
  }
}
