import 'dart:io';

import 'package:chat_app/widgets/user_image.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String username, String password, String emailID,
      bool isLogin, File? imagefile) _submitform;
  AuthForm(this._submitform);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String _userEmail = " ";
  String _username = ' ';
  String _password = ' ';
  bool _isLogin = true;
  File? userimageFile;
  final _formkey = GlobalKey<FormState>();
  void _pickedimage(File image) {
    userimageFile = image;
  }

  void _trysumbit() {
    final bool? isValid = _formkey.currentState?.validate();
    // closes the keyboard once form is submitted.
    FocusScope.of(context).unfocus();
    // check this condition.
    if (userimageFile == null && !_isLogin) {
      Scaffold.of(context)
          .showSnackBar(const SnackBar(content: Text('Please pick an image')));
      return;
    }
// check this.
    if (isValid != null && isValid) {
      // this triggers onSaved fucntion on every TextFormField.
      _formkey.currentState?.save();
      // understand this.
      widget._submitform(_username.trim(), _password.trim(), _userEmail.trim(),
          _isLogin, userimageFile);

      print(_username);
      print(_password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formkey,
            child: Column(
              // this makes sure thAT THE column takes as less size as possible.
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) UserImagePicker(_pickedimage),
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Error has Occured';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  onSaved: (value) {
                    _userEmail = value.toString();
                  },
                ),
                // check this if_isLogin
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('Username'),
                    validator: (value) {
                      if (value == null) {
                        return 'Error has Occured';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Username'),
                    onSaved: (value) {
                      _username = value.toString();
                    },
                  ),
                TextFormField(
                  // keys are important.
                  // so the value problems dont occur.
                  key: const ValueKey('Password'),
                  validator: (value) {
                    // error occurs use vlaue.isEmpty
                    if (value == null) {
                      return 'Error has Occured';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Password'),
                  onSaved: (value) {
                    _password = value.toString();
                  },
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _trysumbit,
                  child: Text(
                    _isLogin ? 'Login' : 'Signup',
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create Account'
                        : 'I already have an account'))
              ],
            )),
      ),
    ));
  }
}
