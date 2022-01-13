import 'package:aswenna/community/services/auth.dart';
import 'package:aswenna/community/services/database.dart';
import 'package:aswenna/community/ui/authenticate_ui/register.dart';
import 'package:aswenna/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

bool isLoading = false;

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _authService = AuthService();
  final _dbService = Database();

  String email;
  String password;

  bool validateEmail(email) {
    String regex =
        '^[a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$';
    RegExp validate = RegExp(regex);
    if (!validate.hasMatch(email)) return true;

    return false;
  }

  void _signInSubmitForm() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator(),);
          });
      try {
        final success = await _authService.signInUserWithEmailAndPassword(email, password);
        print(success);

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                    'Login To Continue',
                    style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Container(
              width: size.width * 0.8,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: 'Password'),
                        onChanged: (value) {
                          password = value;
                        },
                        // ignore: missing_return
                        validator: (value) {
                          if (value == null) return 'password cannot be empty';
                          if (value.length < 6)
                            return 'password cannot be less than 6 characters';
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 130.0),
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
                            _signInSubmitForm();
                          },
                          child: Text('Login')),
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
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => RegisterPage()));
                          },
                          child: Text('Create new account')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
