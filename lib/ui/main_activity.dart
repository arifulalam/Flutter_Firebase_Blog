import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/controllers/user_controller.dart';
import 'package:flutter_firebase_blog/helpers/constants.dart';
import 'package:flutter_firebase_blog/helpers/functions.dart';
import 'package:flutter_firebase_blog/ui/screener.dart';
import 'package:flutter_firebase_blog/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity>
    with SingleTickerProviderStateMixin, passwordValidationMixin {
  final _fName = TextEditingController();
  final _lName = TextEditingController();
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  final _cPwd = TextEditingController();

  UserController userController = UserController();

  bool signInPwd = true;
  bool signUpPwd = true;
  bool signUpCPwd = true;

  var eye = const FaIcon(FontAwesomeIcons.eye);
  var eyeSlash = const FaIcon(FontAwesomeIcons.eyeSlash);

  bool _isDisabled = false;

  var focusPass = FocusNode();

  final _signinFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  Widget buttonChildDefault(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buttonChildAfterClicked(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        spinKit('FadingCircle'),
        const SizedBox(
          width: 10,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  signupForm() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      elevation: 2,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: ((MediaQuery.of(context).size.height / 4) * 3),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              color: Color.fromRGBO(158, 213, 203, 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.35),
                    Colors.black38.withOpacity(0.35)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Form(
                      key: _signupFormKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: _fName,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter first name';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'First Name',
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      errorStyle: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: _lName,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter last name';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Last Name',
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      errorStyle: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                    textInputAction: TextInputAction.next,
                                  ),
                                )
                              ],
                            ),
                          ),
                          TextFormField(
                            controller: _email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address.';
                              } else if (!isEmailValid(value)) {
                                return 'Please, enter a valid email address.';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              labelText: 'Email Address',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              errorStyle: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          TextFormField(
                            controller: _pwd,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a strong password';
                              } else if (!isPasswordLengthValid(_pwd.text)) {
                                return 'Password should at least 8 characters long';
                              }
                              return null;
                            },
                            focusNode: focusPass,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                errorStyle: const TextStyle(
                                  color: Colors.red,
                                ),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      signUpPwd = !signUpPwd;
                                    });
                                  },
                                  icon: signUpPwd ? eyeSlash : eye,
                                  iconSize: 15,
                                  color: Colors.white,
                                )),
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                            obscureText: signUpPwd,
                            textInputAction: TextInputAction.next,
                          ),
                          TextFormField(
                            controller: _cPwd,
                            validator: (value) {
                              if ((value == null || value.isEmpty) ||
                                  _pwd.text != _cPwd.text) {
                                return 'Password and Confirm password not matched.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                labelText: 'Confirm Password',
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                errorStyle: const TextStyle(
                                  color: Colors.red,
                                ),
                                suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      signUpCPwd = !signUpCPwd;
                                    });
                                  },
                                  icon: signUpCPwd ? eyeSlash : eye,
                                  iconSize: 15,
                                  color: Colors.white,
                                )),
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                            obscureText: signUpCPwd,
                            textInputAction: TextInputAction.done,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.cyan),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                  child: (_isDisabled != true)
                                      ? buttonChildDefault('Sign Up')
                                      : buttonChildAfterClicked('Sign Up'),
                                  onPressed: (_isDisabled != true)
                                      ? () async {
                                          // Validate returns true if the form is valid, or false otherwise.
                                          if (_signupFormKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              _isDisabled = true;
                                            });

                                            await userController
                                                .register(
                                                    _fName.text,
                                                    _lName.text,
                                                    _email.text,
                                                    _pwd.text)
                                                .then((value) {
                                              var value =
                                                  userController.message;

                                              if (value == null) {
                                                alertSnackBar(context,
                                                    'Something went wrong. Contact developer.');
                                              } else {
                                                /*print('printing signup');
                                                print(value);
                                                print('ending signup');*/
                                                if (value['status'] == true &&
                                                    value['code'] == 200) {
                                                  alert(context, 'Info',
                                                      value['message'],
                                                      buttons: [
                                                        {
                                                          'text': 'Ok',
                                                          'value': 1
                                                        }
                                                      ]).then((value) {
                                                    setState(() {
                                                      _fName.text =
                                                          _lName.text =
                                                              _cPwd.text = '';
                                                      _isDisabled = false;
                                                      Navigator.pop(context);
                                                    });
                                                  });
                                                } else if (value['status'] ==
                                                        false &&
                                                    value['code'] == 401) {
                                                  alert(context, 'Info',
                                                      value['message'],
                                                      buttons: [
                                                        {
                                                          'text': 'Ok',
                                                          'value': 1
                                                        }
                                                      ]).then((value) {
                                                    setState(() {
                                                      _isDisabled = false;
                                                    });
                                                  });
                                                } else if (value['status'] ==
                                                        false &&
                                                    value['code'] == 404) {
                                                  alert(context, 'Error',
                                                      value['message'],
                                                      buttons: [
                                                        {
                                                          'text': 'Ok',
                                                          'value': 1
                                                        }
                                                      ]).then((value) {
                                                    //Whatever you need to run
                                                  });
                                                } else if (value['status'] ==
                                                        false &&
                                                    value['code'] == 408) {
                                                  alert(context, 'Error',
                                                      value['message'],
                                                      buttons: [
                                                        {
                                                          'text': 'Ok',
                                                          'value': 1
                                                        }
                                                      ]).then((value) {
                                                    //whatever you need to run
                                                  });
                                                } else {
                                                  alert(context, 'Error',
                                                      value['message'],
                                                      buttons: [
                                                        {
                                                          'text': 'Ok',
                                                          'value': 1
                                                        }
                                                      ]).then((value) {
                                                    //Whatever you need to do
                                                  });
                                                }
                                              }
                                            });
                                          }
                                          setState(() {
                                            _isDisabled = false;
                                          });
                                        }
                                      : null,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.cyan),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                  child: const Text('Cancel'),
                                  onPressed: (_isDisabled != true)
                                      ? () {
                                          setState(() {
                                            _isDisabled = false;
                                            Navigator.pop(context);
                                          });
                                        }
                                      : null,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: constants['background_decoration'],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                const Image(
                  image: AssetImage('assets/images/_blog.png'),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _signinFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please, input your email address.';
                          } else if (!isEmailValid(value)) {
                            return 'Please, enter a valid email address.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Email Address',
                            labelText: 'Email Address'),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _pwd,
                        validator: (value) {
                          if ((value == null || value.isEmpty) ||
                              !isPasswordLengthValid(value)) {
                            return 'Please, input password with min 8 characters long';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            border: const OutlineInputBorder(),
                            hintText: 'Enter password',
                            labelText: 'Password',
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  signInPwd = !signInPwd;
                                });
                              },
                              icon: signInPwd ? eyeSlash : eye,
                              iconSize: 15,
                            )),
                        obscureText: signInPwd,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {},
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Forgot password?',
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  animationDuration:
                                      Duration(microseconds: 250),
                                ),
                                child: (!_isDisabled)
                                    ? buttonChildDefault('Sign In')
                                    : buttonChildAfterClicked('Sign In'),
                                onPressed: (_isDisabled != true)
                                    ? () async {
                                        // Validate returns true if the form is valid, or false otherwise.
                                        if (_signinFormKey.currentState!
                                            .validate()) {
                                          setState(() {
                                            _isDisabled = true;
                                          });
                                          await userController
                                              .authentication(
                                                  _email.text, _pwd.text)
                                              .then((value) {
                                            print('printing view...');
                                            print(userController.message);
                                            print('ending view');
                                            var value = userController.message;
                                            print('printing value');
                                            print(value);
                                            print('ending value');
                                            if (value == null) {
                                              alertSnackBar(context,
                                                  'Something went wrong. Contact developer.');
                                            } else {
                                              if (value['status'] == true &&
                                                  value['code'] == 200) {
                                                alertSnackBar(
                                                    context, value['message']);
                                                if (userController
                                                        .client.isNextLogin ==
                                                    false) {
                                                  //print('profile');
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Screener(
                                                                  activity:
                                                                      'profile')));
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Screener(
                                                                  activity:
                                                                      'dashboard')));
                                                }
                                              } else if (value['status'] ==
                                                      false &&
                                                  value['code'] == 401) {
                                                alert(context, 'Error',
                                                    value['message'],
                                                    buttons: [
                                                      {
                                                        'text': 'Ok',
                                                        'value': 1
                                                      },
                                                    ]).then((value) {
                                                  //you can focus email field in sign up form.
                                                });
                                              } else if (value['status'] ==
                                                      false &&
                                                  value['code'] == 403) {
                                                alert(context, 'Information',
                                                    value['message'],
                                                    buttons: [
                                                      {
                                                        'text': 'Ok',
                                                        'value': 0
                                                      },
                                                      {
                                                        'text': 'Resent email',
                                                        'value': 1
                                                      },
                                                    ]).then((value) {
                                                  if (value == 1) {
                                                    //printer('send activation mail', userController.message);
                                                    userController
                                                        .sendActivationMail()
                                                        .then((value) {
                                                      //printer('after sent activation mail', userController.message);
                                                      alert(
                                                          context,
                                                          'Info',
                                                          userController
                                                                  .message![
                                                              'message']);
                                                    });
                                                  }
                                                });
                                              } else if (value['status'] ==
                                                      false &&
                                                  value['code'] == 404) {
                                                alert(context, 'Error',
                                                    value['message'],
                                                    buttons: [
                                                      {
                                                        'text': 'Ok',
                                                        'value': 0
                                                      },
                                                    ]).then((value) {
                                                  //Whatever you need to do
                                                });
                                              } else if (value['status'] ==
                                                      false &&
                                                  value['code'] == 404.1) {
                                                alert(context, 'Error',
                                                    value['message'],
                                                    buttons: [
                                                      {
                                                        'text': 'Cancel',
                                                        'value': 0
                                                      },
                                                      {
                                                        'text': 'Sign Up',
                                                        'value': 1
                                                      },
                                                    ]).then((value) {
                                                  if (value == 1) signupForm();
                                                });
                                              } else {
                                                alert(context, 'Info',
                                                    'Something wrong happened. Try again.');
                                              }
                                            }
                                          });
                                          setState(() {
                                            _isDisabled = false;
                                          });
                                          /*FirebaseBridge.signIn(
                                                    _email.text, _pwd.text)
                                                .then((value) {
                                          });*/
                                        } else {
                                          setState(() {
                                            _isDisabled = false;
                                          });
                                        }
                                      }
                                    : null,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: (_isDisabled != true)
                                    ? () {
                                        signupForm();
                                      }
                                    : null,
                                child: const Text('Sign Up'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Screener(activity: 'about'))),
                  child: const Text('About Developer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
