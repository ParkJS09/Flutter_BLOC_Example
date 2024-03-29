import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloC Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterPage()
    );
  }
}

class CounterPage extends StatefulWidget{
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {

  int _counter = 0;
  final StreamController<int> _streamController = StreamController();
  final StreamController<int> _ctrl = StreamController();
  final Stream<int> stream = Stream.periodic(Duration(seconds: 1), (int x) => x);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Stream version of the counter app'),),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Hello'),
              //1.버튼 누를 때마다 텍스트 변경
              StreamBuilder<int>(
                //어떤 스트림을 쓸지 정함
                stream: _streamController.stream,
                //초기값 정하기, 스트림에 값이 없을지도 모르니 초기값을 정함.
                initialData: _counter,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  //UI 만드는 부분
                  return Text('You hit me ${snapshot.data} times');
                },
              ),
              StreamBuilder<int>(
                stream: stream,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return Text('${snapshot.data} second passed');
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            _streamController.sink.add(++_counter);
          },
        ),
    );
  }
}

