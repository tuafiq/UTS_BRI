import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
runApp(const BrimoApp());
}

class BrimoApp extends StatelessWidget {
  const BrimoApp({Key? key}) : super(key: key );
  @override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Roboto',
      primaryColor: const Color(0xFF005EAA),
    ),
    home: const BrimoHomeScreen(),
  );
}
}

class BrimoHomeScreen extends StatefulWidget {
  const BrimoHomeScreen({Key? Key}) : super(key: Key);
  @override
  State<BrimoHomeScreen> createState() => _BrimoHomeScreenState();
}

class _BrimoHomeScreenState extends State<BrimoHomeScreen>{
 bool _isVisible = false;

 @override
  Widget build(BuildContext context) {
    return Scaffold()
  }
}