
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'home.dart';


void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Emeen Fresh',
      theme: ThemeData(
        primaryColor: bgGrey,
        scaffoldBackgroundColor: bgWhite,
        textTheme: Theme.of(context).textTheme.apply(displayColor: primaryText),

      ),


      home:Home(),
    );
  }
}




