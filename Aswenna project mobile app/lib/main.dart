import 'package:aswenna/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'community/services/auth.dart';
import 'community/ui/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          StreamProvider<User>.value(value: _authService.user, initialData: null,),
          ChangeNotifierProvider.value(value: MMber()),
        ],
        child: Wrapper(),
      ),
    );
  }
}