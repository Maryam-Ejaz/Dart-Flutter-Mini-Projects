
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends StatefulWidget {
  const SharedPref({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SharedPref> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SharedPref> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  int _getInt(String key) {
    return prefs.getInt(key) ?? 119;

  }

  String _getString(String key) {
    return prefs.getString(key) ?? 'minion';
  }

  bool _getBool(String key) {
    return prefs.getBool(key) ?? false;
  }

  double _getDouble(String key) {
    return prefs.getDouble(key) ?? 3.14;
  }

  void _setInt(String key, int value) {
    prefs.setInt(key, value);
    setState(() {});
  }

  void _setString(String key, String value) {
    prefs.setString(key, value);
    setState(() {});
  }

  void _setBool(String key, bool value) {
    prefs.setBool(key, value);
    setState(() {});
  }

  void _setDouble(String key, double value) {
    prefs.setDouble(key, value);
    setState(() {});
  }

  void _remove(String key) {
    prefs.remove(key);
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Settings'),
      ),
      body: prefs == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          ListTile(
            title: Text('Integer Value'),
            subtitle: Text('${_getInt('integerValue')}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  child: Text('Set'),
                  onPressed: () {
                    _setInt('integerValue', 42);
                  },
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  child: Text('Change'),
                  onPressed: () {
                    _setInt('integerValue', _getInt('integerValue') + 1);
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('String Value'),
            subtitle: Text('${_getString('stringValue')}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  child: Text('Set'),
                  onPressed: () {
                    _setString('stringValue', 'Hello, World!');
                  },
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  child: Text('Change'),
                  onPressed: () {
                    _setString('stringValue', '${DateTime.now()}');
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Boolean Value'),
            subtitle: Text('${_getBool('booleanValue')}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  child: Text('Set'),
                  onPressed: () {
                    _setBool('booleanValue', true);
                  },
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  child: Text('Change'),
                  onPressed: () {
                    _setBool('booleanValue', !_getBool('booleanValue'));
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Double Value'),
            subtitle: Text('${_getDouble('doubleValue')}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  child: Text('Set'),
                  onPressed: () {
                    _setDouble('doubleValue', 3.14);
                  },
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  child: Text('Change'),
                  onPressed: () {
                    _setDouble('doubleValue', _getDouble('doubleValue') + 1.0);
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Delete Value'),
            subtitle: Text('Deletes all values'),
            trailing: ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                _remove('integerValue');
                _remove('stringValue');
                _remove('booleanValue');
                _remove('doubleValue');
              },
            ),
          ),
        ],
      ),
    );
  }
}
