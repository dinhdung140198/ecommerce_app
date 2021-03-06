import 'package:ecommerce_app/providers/auth.dart';

import 'package:email_auth/email_auth.dart';
// import 'package:email_auth_example/auth.config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordWidget extends StatefulWidget {
  String? email;
  ResetPasswordWidget({Key? key, this.email}) : super(key: key);

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  GlobalKey<FormState> _profileAccountFormKey = GlobalKey<FormState>();
  String? _password;
  EmailAuth? emailAuth;
  bool submitValid = false;
  bool isVerify = false;

  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );

    /// Configuring the remote server
    // emailAuth!.config(remoteServerConfiguration);
  }
  // @override
  // void dispose() {
  //   _passwordFocusNode.dispose();
  //   super.dispose();
  // }

  Future<void> _saveForm() async {

    // final isValid = _profileAccountFormKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    // _profileAccountFormKey.currentState!.save();
    await Provider.of<Auth>(context, listen: false).resetPassword('dinhdung.jr@gmail.com');
    Navigator.pop(context);
  }

  void verify() {
    bool result = emailAuth!.validateOtp(
        recipientMail: _emailController.value.text,
        userOtp: _otpController.value.text);
    if (result) {
      setState(() {
        isVerify = true;
      });
    }
  }

  void sendOtp() async {
    bool result = await emailAuth!
        .sendOtp(recipientMail: _emailController.value.text, otpLength: 5);
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
        // Form(
        //   key: _profileAccountFormKey,
        //   child: Column(
        //     children: [
        //       TextFormField(
        //         controller: _emailController,
        //         style: TextStyle(color: Theme.of(context).hintColor),
        //         keyboardType: TextInputType.text,
        //         onFieldSubmitted: (value) {
        //           FocusScope.of(context).requestFocus(_passwordFocusNode);
        //         },
        //         decoration: getInputDecoration(
        //             hintText: widget.email, labelText: 'Email'),
        //         // initialValue: widget.email==null?'':widget.email,
        //         validator: (value) {
        //           if (value!.isEmpty || !value.contains('@')) {
        //             return 'Invalid email';
        //           }
        //           return null;
        //         },
        //         onSaved: (value) {
        //           widget.email = value;
        //         },
        //       ),
        //       (!submitValid)
        //           ? Container(
        //               height: 1,
        //             )
        //           : ((!isVerify)
        //               ? TextFormField(
        //                   controller: _otpController,
        //                   style: TextStyle(color: Theme.of(context).hintColor),
        //                   decoration: getInputDecoration(
        //                       hintText: 'OTP', labelText: 'OTP'),
        //                   textInputAction: TextInputAction.next,
        //                 )
        //               : TextFormField(
        //                   keyboardType: TextInputType.text,
        //                   style: TextStyle(color: Theme.of(context).hintColor),
        //                   decoration: getInputDecoration(
        //                       hintText: 'Add new password',
        //                       labelText: 'NewPassword'),
        //                   textInputAction: TextInputAction.done,
        //                   focusNode: _passwordFocusNode,
        //                   onSaved: (value) {
        //                     _password = value;
        //                   },
        //                 )),
        //     ],
        //   ),
        // ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            MaterialButton(
              onPressed: () {
                _saveForm();
                // Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
          //   (!submitValid)?MaterialButton(
          //     onPressed: () => sendOtp(),
          //     child: Text(
          //       'OTP',
          //       style: TextStyle(color: Theme.of(context).accentColor),
          //     ),
          //   ):
          //   ((!isVerify)
          //       ? MaterialButton(
          //           onPressed: () => verify(),
          //           child: Text(
          //             'Verify',
          //             style: TextStyle(color: Theme.of(context).accentColor),
          //           ),
          //         )
          //       : MaterialButton(
          //           onPressed: () {
          //             _saveForm();
          //           },
          //           child: Text(
          //             'Change',
          //             style: TextStyle(color: Theme.of(context).accentColor),
          //           ),
          //         ))
          // ],
          // mainAxisAlignment: MainAxisAlignment.end,
      ]),
        SizedBox(
          height: 10,
        )
      ],
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
