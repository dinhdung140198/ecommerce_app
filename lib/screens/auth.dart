import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/models/http_exception.dart';
import 'package:ecommerce_app/providers/auth.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:ecommerce_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  bool _showPassword = false;
  Map<String, String> _authData = {'email': '', 'password': ''};
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController? _controller;
  Animation<Size>? _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _heightAnimation = Tween<Size>(
            begin: Size(double.infinity, 260), end: Size(double.infinity, 320))
        .animate(CurvedAnimation(
            parent: _controller as Animation<double>,
            curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  void _showErrorDialog(String? message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('An Error Occured !'),
              content: Text(message!),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Okay'))
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context,listen: false)
            .signIn(_authData['email'], _authData['password']);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email'], _authData['password']);
        await Provider.of<UserProvider>(context,listen: false).addUser();
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'this email address is already in use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'this is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'this is password is too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with email ';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller!.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 60),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor.withOpacity(0.6)),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).hintColor.withOpacity(0.2)),
                      ]),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 25),
                        _authMode == AuthMode.Login
                            ? Text(
                                'Sign In',
                                style: Theme.of(context).textTheme.headline2,
                              )
                            : Text(
                                'Sign Up',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['email'] = value!;
                          },
                          decoration: InputDecoration(
                              hintText: "Email Address",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .merge(TextStyle(
                                      color: Theme.of(context).accentColor)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor)),
                              prefixIcon: Icon(
                                UiIcons.envelope,
                                color: Theme.of(context).accentColor,
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          obscureText: !_showPassword,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 5) {
                              return 'Password is too short!';
                            }
                          },
                          onSaved: _authMode == AuthMode.Login
                              ? (value) {
                                  _authData['password'] = value!;
                                }
                              : (value) {
                                  _authData['password'] = '';
                                },
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .merge(TextStyle(
                                    color: Theme.of(context).accentColor)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              UiIcons.padlock_1,
                              color: Theme.of(context).accentColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    _showPassword = !_showPassword;
                                  },
                                );
                              },
                              icon: Icon(_showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _authMode == AuthMode.Login
                            ? FlatButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot your password ?',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              )
                            : TextFormField(
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                                keyboardType: TextInputType.emailAddress,
                                obscureText: !_showPassword,
                                validator: _authMode == AuthMode.Signup
                                    ? (value) {
                                        if (value != _passwordController.text) {
                                          return 'Password do not match!';
                                        }
                                      }
                                    : null,
                                onSaved: (value) {
                                  _authData['password'] = value!;
                                },
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .merge(TextStyle(
                                          color:
                                              Theme.of(context).accentColor)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.2))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).accentColor)),
                                  prefixIcon: Icon(
                                    UiIcons.padlock_1,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          _showPassword = !_showPassword;
                                        },
                                      );
                                    },
                                    icon: Icon(_showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.4),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        _isLoading
                            ? CircularProgressIndicator()
                            : FlatButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 70),
                                onPressed: () {
                                  _submit();
                                },
                                child: Text(
                                  _authMode == AuthMode.Login
                                      ? 'LOGIN'
                                      : 'SIGN UP',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .merge(
                                        TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                ),
                                color: Theme.of(context).accentColor,
                                shape: StadiumBorder(),
                              ),
                        SizedBox(height: 50),
                        Text(
                          'Or using social media',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            FlatButton(
              onPressed: _switchAuthMode,
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.headline6!.merge(
                        TextStyle(color: Theme.of(context).primaryColor),
                      ),
                  children: _authMode == AuthMode.Login
                      ? [
                          TextSpan(text: 'Don\'t have an account ?'),
                          TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(fontWeight: FontWeight.w700)),
                        ]
                      : [
                          TextSpan(text: 'Already have an account ?'),
                          TextSpan(
                              text: ' Sign In',
                              style: TextStyle(fontWeight: FontWeight.w700)),
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
