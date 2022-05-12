import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordWidget extends StatefulWidget {
  String? email;
  ResetPasswordWidget({Key? key, this.email}) : super(key: key);

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  final _passwordFocusNode = FocusNode();
  GlobalKey<FormState> _profileAccountFormKey = GlobalKey<FormState>();
  String? _password;

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _profileAccountFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _profileAccountFormKey.currentState!.save();
    await Provider.of<Auth>(context, listen: false)
        .resetPassword(widget.email, _password);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                titlePadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                title: Row(
                  children: [
                    Icon(Icons.lock_open),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Reset password ?',
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                ),
                children: [
                  Form(
                    key: _profileAccountFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                          decoration: getInputDecoration(
                              hintText: widget.email, labelText: 'Email'),
                          initialValue: widget.email,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            widget.email = value;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          decoration: getInputDecoration(
                              hintText: 'Add new password',
                              labelText: 'NewPassword'),
                          textInputAction: TextInputAction.next,
                          focusNode: _passwordFocusNode,
                          onSaved: (value) {
                            _password = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          _saveForm();
                        },
                        child: Text(
                          'Reset',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              );
            });
      },
      child: Text(
        'Forgot your password ?',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  InputDecoration getInputDecoration({String? hintText, String? labelText}) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.bodyText2!.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor)),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );
  }
}
