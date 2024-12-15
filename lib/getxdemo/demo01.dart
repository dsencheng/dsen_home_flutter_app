import 'dart:async';

import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';

void main(List<String> args) {
  runApp(Demo01());
}

class Demo01Data {
  String name;
  int age;
  Demo01Data(this.name, this.age);
}

class Demo01Controller {
  StreamController<Demo01Data> streamController =
      StreamController<Demo01Data>();
}

class Demo01 extends StatefulWidget {
  @override
  _Demo01State createState() => _Demo01State();
}

class _Demo01State extends State<Demo01> {
  Demo01Controller controller = Demo01Controller();
  late TypeWriterController streamController;
  int count = 0;
  @override
  void initState() {
    super.initState();
    Stream<String> stream =
        controller.streamController.stream.map((ele) => ele.name);
    streamController = TypeWriterController.fromStream(stream);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.streamController.close();
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.streamController.sink.add(Demo01Data("$count", count++));
          },
        ),
        body: Center(
          child: TypeWriter(
            controller: streamController,
            builder: (BuildContext context, TypeWriterValue value) {
              return Text(
                value.text,
                style: const TextStyle(fontSize: 14),
                maxLines: null,
              );
            },
          ),
        ),
      ),
    );
    ;
  }
}
