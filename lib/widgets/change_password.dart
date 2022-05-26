import 'package:ecommerce_app/providers/auth.dart';

import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordWidget extends StatefulWidget {
  String? email;
  ChangePasswordWidget({Key? key, this.email}) : super(key: key);

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  GlobalKey<FormState> _profileAccountFormKey = GlobalKey<FormState>();
  String? _password;
  EmailAuth? emailAuth;
  bool submitValid = false;
  bool isVerify = false;
  bool isOtp = true;

  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );

    /// Configuring the remote server
    // emailAuth!.config(remoteServerConfiguration);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _profileAccountFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _profileAccountFormKey.currentState!.save();
    await Provider.of<Auth>(context, listen: false).changePassword(_password!);
    Navigator.pop(context);
  }

  void verify() {
    bool result = emailAuth!.validateOtp(
        recipientMail: widget.email!,
        userOtp: _otpController.value.text);
    if (result) {
      setState(() {
        isVerify = true;
      });
    } else {
      isOtp = false;
    }
  }

  void sendOtp() async {
    bool result = await emailAuth!.sendOtp(
        recipientMail: widget.email!,
        otpLength: 5);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      title: Row(
        children: [
          Icon(Icons.lock_open),
          SizedBox(
            width: 10,
          ),
          Text(
            'Change password ?',
            style: Theme.of(context).textTheme.bodyText2,
          )
        ],
      ),
      children: [
        Form(
          key: _profileAccountFormKey,
          child: Column(
            children: [
              ListTile(
                dense: true,
                title: Text(
                  widget.email!,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              (!submitValid)
                  ? Container(
                      height: 1,
                    )
                  : ((!isVerify)
                      ? TextFormField(
                          controller: _otpController,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          decoration: InputDecoration(
                            hintText: 'OTP',
                            labelText: 'OTP',
                            hintStyle:
                                Theme.of(context).textTheme.bodyText2!.merge(
                                      TextStyle(
                                          color: Theme.of(context).focusColor),
                                    ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).hintColor)),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!=null&&!isOtp) {
                              return 'OTP is not exactly';
                            }
                          })
                      : TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          decoration: InputDecoration(
                            hintText: 'Add new password',
                            labelText: 'NewPassword',
                            hintStyle:
                                Theme.of(context).textTheme.bodyText2!.merge(
                                      TextStyle(
                                          color: Theme.of(context).focusColor),
                                    ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).hintColor)),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          textInputAction: TextInputAction.done,
                          initialValue: '',
                          onFieldSubmitted: (_) {
                            verify();
                          },
                          onSaved: (value) {
                            _password = value;
                          },
                        )),
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
            (!submitValid)
                ? MaterialButton(
                    onPressed: () => sendOtp(),
                    child: Text(
                      'OTP',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  )
                : ((!isVerify)
                    ? MaterialButton(
                        onPressed: () => verify(),
                        child: Text(
                          'Verify',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                      )
                    : MaterialButton(
                        onPressed: () {
                          _saveForm();
                        },
                        child: Text(
                          'Change',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ))
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
