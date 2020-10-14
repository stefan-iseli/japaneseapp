import 'package:flutter/material.dart';
import 'package:japaneseapp/sign_in_firebase.dart';

class UserCredentials {
  UserCredentials();

  Future<String> getUserCredentials(BuildContext context) {
    final _formKey = GlobalKey<FormState>(); //key for input ID/PW
    bool _pwVisibility = false;
    String _inputUser;
    String _inputPW;

    return showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign-in with your Id'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      new TextFormField(
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: 'User Id (email)',
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              gapPadding: 4.0),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return ('please enter your user id');
                          } else {
                            _inputUser = value.toLowerCase().trim();
                            return null;
                          }
                        },
                      ),
                      new TextFormField(
                        obscureText: (_pwVisibility) ? false : true,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: (_pwVisibility)
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () => {
                              (_pwVisibility)
                                  ? _pwVisibility = false
                                  : _pwVisibility = true,
                            },
                          ),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              gapPadding: 4.0),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return ('please enter your password');
                          } else {
                            _inputPW = value.trim();
                            return null;
                          }
                        },
                      ),
                      new Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        margin: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                        child: SizedBox(
                          height: 40,
                          width: 350,
                          child: FlatButton(
                              child: const Text('Sign-in',
                                  style: TextStyle(fontSize: 20)),
                              color: Colors.blue,
                              highlightColor: Colors.deepPurple,
                              textColor: Colors.white,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  print('UserId input was $_inputUser');
                                  print('UserPW input was $_inputPW');
                                  signInService.signInWithEmail(
                                      _inputUser, _inputPW);
                                  Navigator.pop(context);
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

final UserCredentials userCredentials = UserCredentials();
