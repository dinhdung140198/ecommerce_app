import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class ProfileAccount extends StatefulWidget {
  const ProfileAccount({Key? key}) : super(key: key);

  @override
  State<ProfileAccount> createState() => _ProfileAccountState();
}

class _ProfileAccountState extends State<ProfileAccount> {
  GlobalKey<FormState> _profileAccountFormKey = GlobalKey<FormState>();
  var _editedUser = UserModel.advanced(id:null, name:'', email:'', avartar:'', gender:'', address:'', dateOfBirth:'');

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
                      Icon(UiIcons.user_1),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Profile Settings',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  children: [
                    Form(
                      key: _profileAccountFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                            keyboardType: TextInputType.text,
                            decoration:
                                getInputDecoration(hintText: '', labelText: ''),
                            initialValue: '',
                            validator: (input) => input!.trim().length < 3
                                ? 'Not a valid full name'
                                : null,
                            onSaved: (){},
                          ),
                          TextFormField(
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                            decoration:
                                getInputDecoration(hintText: '', labelText: ''),
                            initialValue: '',
                            validator: (input) => !input!.contains('@')
                                ? 'Not a valid email'
                                : null,
                            onSaved: () {},
                          ),
                          FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return DropdownButtonFormField<String>(
                                decoration: getInputDecoration(
                                    hintText: '', labelText: ''),
                                hint: Text('Select Device'),
                                value: '',
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Male'),
                                    value: '',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Female'),
                                    value: '',
                                  )
                                ],
                                onChanged: (input) {},
                              );
                            },
                          ),
                          FormField<String>(
                              builder: (FormFieldState<String> state) {
                            return DateTimeField(
                              format: DateFormat('yyyy-MM-dd'),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                              onSaved: (input) => setState(() {}),
                            );
                          })
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          child: Text('Cancel',style:TextStyle(color: Colors.red),),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'Save',
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                    SizedBox(height: 10,)
                  ],
                );
              });
        },
        child: Text(
          'Edit',
          style: Theme.of(context).textTheme.bodyText2,
        ));
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
