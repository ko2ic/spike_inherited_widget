import 'package:flutter/material.dart';

void main() => runApp(TopPage());

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        child: Scaffold(
          appBar: AppBar(
            title: Text('InheritedWidget Demo'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              WidgetA(),
              WidgetB(),
              WidgetC(),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  HomePageState createState() => HomePageState();

  static HomePageState of(BuildContext context, {bool rebuild = true}) {
    if (rebuild) {
      return (context.inheritFromWidgetOfExactType(_MyInheritedWidget) as _MyInheritedWidget).data;
    }
    return (context.ancestorInheritedElementForWidgetOfExactType(_MyInheritedWidget).widget as _MyInheritedWidget).data;
    //return (context.ancestorWidgetOfExactType(_MyInheritedWidget) as _MyInheritedWidget).data;
  }
}

class HomePageState extends State<HomePage> {
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _MyInheritedWidget extends InheritedWidget {
  _MyInheritedWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final HomePageState data;

  @override
  bool updateShouldNotify(_MyInheritedWidget oldWidget) {
    return true;
  }
}

class WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomePageState state = HomePage.of(context);

    return Center(
      child: Text(
        '${state.counter}',
        style: Theme.of(context).textTheme.display1,
      ),
    );
  }
}

class WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('I am a widget that will not be rebuilt.');
  }
}

class WidgetC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomePageState state = HomePage.of(context, rebuild: false);
    return RaisedButton(
      onPressed: () {
        // Scaffold.of(context).showSnackBar(SnackBar(content: Text('message')));
        state._incrementCounter();
      },
      child: Icon(Icons.add),
    );
  }
}

//class TopPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Demo'),
//        ),
//        body: HomePage(),
//      ),
//    );
//  }
//}
//
//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        children: [
//          WidgetA(_counter),
//          WidgetB(),
//          WidgetC(_incrementCounter),
//        ],
//      ),
//    );
//  }
//}
//
//class WidgetA extends StatelessWidget {
//  final int counter;
//
//  WidgetA(this.counter);
//
//  @override
//  Widget build(BuildContext context) {
//    return Center(
//      child: Text(
//        '${counter}',
//        style: Theme.of(context).textTheme.display1,
//      ),
//    );
//  }
//}
//
//class WidgetB extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Text('I am a widget that will not be rebuilt.');
//  }
//}
//
//class WidgetC extends StatelessWidget {
//  final void Function() incrementCounter;
//
//  WidgetC(this.incrementCounter);
//
//  @override
//  Widget build(BuildContext context) {
//    return RaisedButton(
//      onPressed: () {
//        incrementCounter();
//      },
//      child: Icon(Icons.add),
//    );
//  }
//}
