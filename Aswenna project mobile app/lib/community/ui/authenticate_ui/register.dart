import 'package:aswenna/community/services/auth.dart';
import 'package:aswenna/community/services/database.dart';
import 'package:aswenna/community/ui/dashboard/community_home.dart';
import 'package:aswenna/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //const
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  final _dbService = Database();
  String username;
  String email;
  String password;
  String confirmPassword;


  void registerSubmitForm() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator(),);
          });

      try {
        final success = await _authService.registerUserWithEmailAndPassword(email, password, username);

        if (success) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            e.toString(),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red[600],
        ));
      }
    }
  }

  bool validateEmail(String email) {
    if (email == null) return true;

    String regex =
        '^[a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$';
    RegExp validate = RegExp(regex);
    if (!validate.hasMatch(email)) return true;

    return false;
  }

  bool verifyPassword(String password, String confirmPassword) {
    if (password == null || confirmPassword == null) return true;
    if (password.trim() == "" || confirmPassword.trim() == "") return true;
    if (password.length < 6 || confirmPassword.length < 6) return true;
    if (password != confirmPassword) return true;

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 70,
              ),
              width: size.width,
              height: size.height * 0.35 - 27,
              decoration: BoxDecoration(
                color: Color(0xFF00695C),
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Smart Agriculture',
                      style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    Text(""),
                    Text(
                      'Jump start your computer vision deep learning for modern farming and agriculture',
                      style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white,fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              transform: Matrix4.translationValues(0, -36, 1),
              height: size.height * 0.1 - 27,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: Row(
                mainAxisAlignment : MainAxisAlignment.center,
                crossAxisAlignment : CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Create A New Account',
                    style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width * 0.8,
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusColor: Colors.blueAccent[700],
                              contentPadding: EdgeInsets.only(
                                  left: 20, bottom: 11, top: 13, right: 20),
                              hintText: 'Full name'),
                          onChanged: (value) {
                            setState(() {
                              username = value;
                            });
                          },
                          validator: (value) => value.isEmpty
                              ? 'Please Enter a valid username'
                              : null,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusColor: Colors.blueAccent[700],
                              contentPadding: EdgeInsets.only(
                                  left: 20, bottom: 11, top: 13, right: 20),
                              hintText: 'Email'),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          validator: (value) => validateEmail(value)
                              ? 'Please Enter a valid email'
                              : null,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusColor: Colors.blueAccent[700],
                                contentPadding: EdgeInsets.only(
                                    left: 20, bottom: 11, top: 13, right: 20),
                                hintText: 'Password'),
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            validator: (value) => verifyPassword(
                                    password, confirmPassword)
                                ? "Password do not match or must not less than 6"
                                : null),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: TextFormField(
                          obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusColor: Colors.blueAccent[700],
                                contentPadding: EdgeInsets.only(
                                    left: 20, bottom: 11, top: 13, right: 20),
                                hintText: 'Confirm Password'),
                            onChanged: (value) {
                              setState(() {
                                confirmPassword = value;
                              });
                            },
                            validator: (value) => verifyPassword(
                                    password, confirmPassword)
                                ? "Password do not match or must not less than 6"
                                : null),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFE57373),
                                onPrimary: Colors.white,
                                onSurface: Colors.red,
                                shadowColor: Color(0xFFE57373),
                                minimumSize: Size(size.width*0.75, 40.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                            onPressed: () {
                              registerSubmitForm();
                            },
                            child: Text('Create account')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Color(0xFFE57373),
                                onSurface: Colors.red,
                                shadowColor: Color(0xFFE57373),
                                minimumSize: Size(size.width*0.75, 40.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginPage()));
                            },
                            child: Text('Back to Login')),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
