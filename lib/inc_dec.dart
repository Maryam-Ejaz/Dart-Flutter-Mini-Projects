import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'counterblock.dart';

class IncrementButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = Provider.of<CounterBloc>(context);
    return ElevatedButton.icon(
      icon: Icon(Icons.add),
      label: Text("Increment"),
      onPressed: () => counterBloc.increment(),
    );
  }
}

class DecrementButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = Provider.of<CounterBloc>(context);
    return ElevatedButton.icon(
      icon: Icon(Icons.remove),
      label: Text("Decrement"),
      onPressed: () => counterBloc.decrement(),
    );
  }
}
