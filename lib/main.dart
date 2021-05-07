import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:max_course/homePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.deepPurple[900],
          fontFamily: 'Quicksand',
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 1
            ),
            subtitle1: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
            subtitle2: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5
          ),
          ),
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  headline6: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                  )
              ),
            ),
        ),
        home: HomePage()
    );
  }
}