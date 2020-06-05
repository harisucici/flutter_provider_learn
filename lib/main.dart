import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() {
  int _count = 5;
  runApp( ChangeNotifierProvider(
      create: (_) => MyChangeNotifier(_count),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyChangeNotifier notifier = Provider.of(context); //通过Provider.of(context)获取MyChangeNotifier
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [GestureDetector(onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SecondPage();
          }));
        },child: Text('下一页'))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${context.watch<MyChangeNotifier>().counter}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: notifier.incrementCounter,//点击时我们期望输出点击次数
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyChangeNotifier notifier = Provider.of(context); //通过Provider.of(context)获取MyChangeNotifier
    return Scaffold(
      appBar: AppBar(
        title: Text('2222222'),
        actions: [GestureDetector(onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SecondPage();
          }));
        },child: Text('下一页'))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${context.watch<MyChangeNotifier>().counter}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: notifier.incrementCounter,//点击时我们期望输出点击次数
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}


class MyChangeNotifier extends ChangeNotifier {
  int count;

  MyChangeNotifier(this.count);

  int get counter => count;


  incrementCounter() {
    count++;
    notifyListeners();//要更新UI记得调用这个方法
  }
}
