import 'dart:async';
import 'counter_event.dart';

class CounterBloc {

  int _counter = 0;

  final _counterStateCountroller = StreamController<int>();
  final _counterEventController = StreamController<CounterVoteEvent>();
  
  StreamSink<int> get _inCounter => _counterStateCountroller.sink;
  Stream<int> get counter => _counterStateCountroller.stream;

  Sink<CounterVoteEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {

    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterVoteEvent event) {

    if (event is Increment)
      _counter++;
    else if (event is Decrement)
      _counter--;
    else
      _counter = 0;
      
    _inCounter.add(_counter);
  }

  void dispose() {

    _counterStateCountroller.close();
    _counterEventController.close();
  }
}