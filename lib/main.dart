import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'push_notifications.dart';
import 'signin.dart';
import 'package:madproj1/tab_one.dart';
import 'tab_two.dart';
import 'listUser.dart';
import 'vid_player.dart';
import 'uploadImage.dart';
import 'form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'sharedPreferences.dart';
import 'counter.dart';
import 'api_crud.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCWwGWhtRHlDjsuZkmMtxyw9k6RzRClMb0",
      appId: "1:890739516810:android:b1679f13179b5ef0351473",
      messagingSenderId: "890739516810",
      projectId: "mobile-app-d8c82",
      storageBucket: "mobile-app-d8c82.appspot.com",
    ),

  );
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification Channel for basic tests',
      )
    ],
    debug: true,
  );


  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD Project',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  // MyHomePage({required Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 10, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MAD Project'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.edit), text: 'Firebase CRUD'),
            Tab(icon: Icon(Icons.view_carousel), text: 'Carousel'),
            Tab(icon: Icon(Icons.edit_note_outlined), text: 'SQFLite'),
            Tab(icon: Icon(Icons.video_collection), text: 'Video'),
            Tab(icon: Icon(Icons.image), text: 'Image'),
            Tab(icon: Icon(Icons.notifications), text: 'Push Notification'),
            Tab(icon: Icon(Icons.edit_note), text: 'Form'),
            Tab(icon: Icon(Icons.login_outlined), text: 'Auth'),
            Tab(icon: Icon(Icons.numbers), text: 'Pref'),
            // Tab(icon: Icon(Icons.storage), text: 'State'),
            Tab(icon: Icon(Icons.list_alt), text: 'Quotes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Form_(),
          TabTwo(),
          ListOfItems(),
          VideoPlayerScreen(),
          ImageUploadScreen(title: 'null',),
          PushNotification_(),
          FormScreen(),
          SigninScreen(),
          SharedPref(title: 'Shared Prefrences',),
          // CounterPage(),
          ApiCrud(),
        ],
      ),
    );
  }
}


