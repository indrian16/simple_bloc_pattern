import 'package:flutter/material.dart';
import 'counter_bloc.dart';
import 'counter_event.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  final titleApp = 'Simple BLoC Pattern';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.titleApp,
      theme: ThemeData.light(),
      home: HomePage(title: this.titleApp),
    );
  }
}

class HomePage extends StatefulWidget {

  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _bloc = CounterBloc();

  Widget _cardCounting(AsyncSnapshot<int> snapshot) {
    return Center(
        child: SizedBox(
          width: 150.0,
          height: 150.0,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Counting Vote', style: TextStyle(
                  fontSize: 18.0,
                )),
                SizedBox(height: 16.0),
                Text('${snapshot.data}', style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                )),
              ],
            )
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: () => _bloc.counterEventSink.add(Reset()),
            tooltip: 'Reset Vote',
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: StreamBuilder(
        stream: _bloc.counter,
        initialData: 0,
        builder: (ctx, snapshot) {
          return _cardCounting(snapshot);
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => _bloc.counterEventSink.add(Increment()),
            tooltip: 'Increment Vote',
            child: Icon(Icons.add),
          ),
          SizedBox(width: 6.0),
          FloatingActionButton(
            onPressed: () => _bloc.counterEventSink.add(Decrement()),
            tooltip: 'Decrement Vote',
            child: Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}