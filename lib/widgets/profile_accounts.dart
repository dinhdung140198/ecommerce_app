import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileAccount extends StatefulWidget {
  const ProfileAccount({Key? key}) : super(key: key);

  @override
  State<ProfileAccount> createState() => _ProfileAccountState();
}

class _ProfileAccountState extends State<ProfileAccount> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  GlobalKey<FormState> _profileAccountFormKey = GlobalKey<FormState>();
  var _editedUser = UserModel.advanced(
      id: null,
      name: '',
      email: '',
      avartar: '',
      gender: '',
      address: '',
      dateOfBirth: DateTime.now());
  var _initUser = {
    'name': '',
    'email': '',
    'avartar': '',
    'gender': '',
    'address': '',
    'dateOfBirth': DateTime.now().toString(),
  };
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _editedUser = Provider.of<UserProvider>(context).user;
    _initUser = {
      'name': _editedUser.name!,
      'email': _editedUser.email!,
      'avartar': _editedUser.avartar!,
      'gender': _editedUser.gender!,
      'address': _editedUser.address!,
      'dateOfBirth': DateTime.now().toString(),
    };
    _imageUrlController.text = _editedUser.avartar!;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (_imageUrlController.text.endsWith('pnp') &&
              _imageUrlController.text.endsWith('jpg') &&
              _imageUrlController.text.endsWith('jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {}

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
                            initialValue: _initUser['name'],
                            validator: (input) => input!.trim().length < 3
                                ? 'Not a valid full name'
                                : null,
                            onSaved: (value) {
                              _editedUser = UserModel.advanced(
                                  name: value,
                                  email: _editedUser.email,
                                  avartar: _editedUser.avartar,
                                  gender: _editedUser.gender,
                                  address: _editedUser.address,
                                  dateOfBirth: _editedUser.dateOfBirth);
                            },
                          ),
                          TextFormField(
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                            decoration: getInputDecoration(
                                hintText: _initUser['address'],
                                labelText: 'Address'),
                            initialValue: _initUser['address'],
                            // validator: (input) => !input!.contains('@')
                            //     ? 'Not a valid email'
                            //     : null,
                            onSaved: (value) {
                              _editedUser = UserModel.advanced(
                                  name: _editedUser.name,
                                  email: _editedUser.email,
                                  avartar: _editedUser.avartar,
                                  gender: _editedUser.gender,
                                  address: value,
                                  dateOfBirth: _editedUser.dateOfBirth);
                            },
                          ),
                          FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return DropdownButtonFormField<String>(
                                decoration: getInputDecoration(
                                    hintText: _initUser['gender'], labelText:'Gender' ),
                                hint: Text('Select Device'),
                                value: _editedUser.gender,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Male'),
                                    value: 'Male',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Female'),
                                    value: 'Female',
                                  )
                                ],
                                onChanged: (input) {
                                  _editedUser.gender = input;
                                },
                                onSaved: (input) => _editedUser.gender = input,
                              );
                            },
                          ),
                          // TextFormField(
                          //   style:
                          //       TextStyle(color: Theme.of(context).hintColor),
                          //   decoration:
                          //       getInputDecoration(hintText: '', labelText: ''),
                          //   initialValue: '',
                          //   onSaved: (value) {

                          //   },
                          // ),
                          // FormField<String>(
                          //   builder: (FormFieldState<String> state) {
                          //     return DateTimeField(
                          //       decoration: getInputDecoration(
                          //           hintText:
                          //               _editedUser.dateOfBirth.toString()),
                          //       format: DateFormat('yyyy-MM-dd'),
                          //       onShowPicker: (context, currentValue) {
                          //         return showDatePicker(
                          //             context: context,
                          //             firstDate: DateTime(1900),
                          //             initialDate:
                          //                 currentValue ?? DateTime.now(),
                          //             lastDate: DateTime(2100));
                          //       },
                          //       onSaved: (input) =>
                          //           _editedUser.dateOfBirth = input,
                          //     );
                          //   },
                          // ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     Container(
                          //       width: 80.0,
                          //       height: 80.0,
                          //       margin: EdgeInsets.only(top: 8, right: 10),
                          //       decoration: BoxDecoration(
                          //           border: Border.all(
                          //         width: 1.0,
                          //         color: Colors.grey,
                          //       )),
                          //       child: _imageUrlController.text.isEmpty
                          //           ? Text('Enter a URL')
                          //           : FittedBox(
                          //               child: Image.network(
                          //                   _imageUrlController.text),
                          //               fit: BoxFit.fill,
                          //             ),
                          //     ),
                          //     Expanded(
                          //       child: TextFormField(
                          //         // initialValue: _intitValues['imageUrl'],
                          //         decoration:
                          //             InputDecoration(labelText: 'Image URL'),
                          //         keyboardType: TextInputType.url,
                          //         textInputAction: TextInputAction.done,
                          //         controller: _imageUrlController,
                          //         focusNode: _imageUrlFocusNode,
                          //         // onEditingComplete: (){
                          //         //   setState(() {

                          //         //   });
                          //         // },
                          //         onFieldSubmitted: (_) {
                          //           _saveForm();
                          //         },
                          //         validator: (value) {
                          //           if (value!.isEmpty) {
                          //             return 'Please enter a image Url';
                          //           }
                          //           if (!value.startsWith('http') &&
                          //               !value.startsWith('https')) {
                          //             return 'Please enter a valid URL';
                          //           }
                          //           if (value.endsWith('pnp') &&
                          //               value.endsWith('jpg') &&
                          //               value.endsWith('jpeg')) {
                          //             return 'Please enter a valid image URL';
                          //           }
                          //           return null;
                          //         },
                          //         onSaved: (value) {
                          //           _editedUser = UserModel.advanced(
                          //             name: _editedUser.name,
                          //             email: _editedUser.email,
                          //             avartar: value,
                          //             gender: _editedUser.gender,
                          //             address: _editedUser.address,
                          //             dateOfBirth: _editedUser.dateOfBirth,
                          //           );
                          //         },
                          //       ),
                          //     )
                          //   ],
                          // )
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
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
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
                    SizedBox(
                      height: 10,
                    )
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
