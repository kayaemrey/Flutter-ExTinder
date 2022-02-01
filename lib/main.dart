import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login/loginstatus.dart';
import 'model/homeWidgetModel.dart';
import 'services/authService.dart';
import 'services/firebaseDB.dart';
import 'services/firebaseStorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => firebasedb()),
        ChangeNotifierProvider(create: (_) => firebasestorage()),
        ChangeNotifierProvider(create: (_) => homeWidgetModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TinderEx',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => loginstatus()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/icon/teamwork.png",
                  width: 178,
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              "TinderEx",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "From",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                ),
                SizedBox(
                  width: 5,
                ),
                Image.asset(
                  "assets/icon/yeksoftware.png",
                  width: 50,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "yeksoftware",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
