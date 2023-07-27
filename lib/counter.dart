import 'package:flutter/material.dart';
import 'inc_dec.dart';
import 'counterblock.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = Provider.of<CounterBloc>(context as BuildContext);
    return Scaffold(
        body: Container(
            child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'State Management',
            style: TextStyle(fontSize: 30, color: Colors.teal),
          ),
          Text(counterBloc.counter.toString()),
          IncrementButton(),
          DecrementButton()
        ],
      ),
    )));
  }
}
