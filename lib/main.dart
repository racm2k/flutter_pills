import 'package:crm/src/MyApp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: const Color.fromARGB(255, 19, 196, 163),
          fontFamily: GoogleFonts.raleway().fontFamily,
          platform: TargetPlatform.android),
      debugShowCheckedModeBanner: false,
      home: const MyApp(),
    );
  }
}
