import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileAccount extends StatefulWidget {
  ProfileAccount({Key? key, this.onChanged}) : super(key: key);
  VoidCallback? onChanged;

  @override
  State<ProfileAccount> createState() => _ProfileAccountState();
}

class _ProfileAccountState extends State<ProfileAccount> {
  final _addressFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  GlobalKey<FormState> _profileAccountFormKey = GlobalKey<FormState>();
  var _editedUser = UserModel.advanced(
      id: '',
      name: '',
      email: '',
      avartar: '',
      gender: '',
      phone: '',
      address: '',
      dateOfBirth: DateTime.now());
  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _editedUser = Provider.of<UserProvider>(context).user!;
      _imageUrlController.text = _editedUser.avartar!;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _addressFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
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

  Future<void> _saveForm() async {
    final isValid = _profileAccountFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _profileAccountFormKey.currentState!.save();
    await Provider.of<UserProvider>(context, listen: false)
        .updateUser(_editedUser);
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
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_phoneFocusNode);
                            },
                            decoration: getInputDecoration(
                                hintText: _editedUser.name, labelText: 'Name'),
                            initialValue: _editedUser.name,
                            validator: (input) => input!.trim().length < 3
                                ? 'Not a valid full name'
                                : null,
                            onSaved: (value) {
                              _editedUser = UserModel.advanced(
                                  id: _editedUser.id,
                                  name: value,
                                  phone: _editedUser.phone,
                                  email: _editedUser.email,
                                  avartar: _editedUser.avartar,
                                  gender: _editedUser.gender,
                                  address: _editedUser.address,
                                  dateOfBirth: _editedUser.dateOfBirth);
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                            decoration: getInputDecoration(
                                hintText: _editedUser.phone,
                                labelText: 'Phone Number'),
                            initialValue: _editedUser.phone,
                            textInputAction: TextInputAction.next,
                            focusNode: _phoneFocusNode,
                            validator: (input) => (input!.length >= 9 &&
                                    input.length <= 11)
                                ? null
                                :'Not valid phone number',
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_addressFocusNode);
                            },
                            onSaved: (value) {
                              _editedUser = UserModel.advanced(
                                id: _editedUser.id,
                                phone: value,
                                name: _editedUser.name,
                                email: _editedUser.email,
                                avartar: _editedUser.avartar,
                                gender: _editedUser.gender,
                                address: _editedUser.address,
                                dateOfBirth: _editedUser.dateOfBirth,
                              );
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                            decoration: getInputDecoration(
                                hintText: _editedUser.address,
                                labelText: 'Address'),
                            initialValue: _editedUser.address,
                            textInputAction: TextInputAction.next,
                            focusNode: _addressFocusNode,
                            onSaved: (value) {
                              _editedUser = UserModel.advanced(
                                id: _editedUser.id,
                                name: _editedUser.name,
                                phone:_editedUser.phone ,
                                email: _editedUser.email,
                                avartar: _editedUser.avartar,
                                gender: _editedUser.gender,
                                address: value,
                                dateOfBirth: _editedUser.dateOfBirth,
                              );
                            },
                          ),
                          FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return DropdownButtonFormField<String>(
                                decoration: getInputDecoration(
                                    hintText: _editedUser.gender,
                                    labelText: 'Gender'),
                                value: _editedUser.gender,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('no gender'),
                                    value: 'no gender',
                                  ),
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
                                  setState(() {
                                    _editedUser.gender = input;
                                  });
                                },
                                onSaved: (input) => _editedUser.gender = input,
                              );
                            },
                          ),
                          FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return DateTimeField(
                                  onFieldSubmitted: ((value) =>
                                      FocusScope.of(context)
                                          .requestFocus(_imageUrlFocusNode)),
                                  decoration: getInputDecoration(
                                      hintText:
                                          _editedUser.dateOfBirth.toString()),
                                  format: DateFormat('yyyy-MM-dd'),
                                  initialValue: DateTime.parse(
                                      _editedUser.dateOfBirth.toString()),
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                  },
                                  onSaved: (input) {
                                    setState(() {
                                      _editedUser.dateOfBirth = input;
                                      widget.onChanged!();
                                    });
                                  });
                            },
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 80.0,
                                height: 80.0,
                                margin: EdgeInsets.only(top: 8, right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  width: 1.0,
                                  color: Colors.grey,
                                )),
                                child: _imageUrlController.text.isEmpty
                                    ? Text('Enter a URL')
                                    : FittedBox(
                                        child: Image.network(
                                            _imageUrlController.text),
                                        fit: BoxFit.fill,
                                      ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  // initialValue: _intitValues['imageUrl'],
                                  decoration:
                                      InputDecoration(labelText: 'Image URL'),
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.done,
                                  controller: _imageUrlController,
                                  focusNode: _imageUrlFocusNode,
                                  onFieldSubmitted: (_) {
                                    _saveForm();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a image Url';
                                    }
                                    if (!value.startsWith('http') &&
                                        !value.startsWith('https')) {
                                      return 'Please enter a valid URL';
                                    }
                                    if (value.endsWith('pnp') &&
                                        value.endsWith('jpg') &&
                                        value.endsWith('jpeg')) {
                                      return 'Please enter a valid image URL';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _editedUser = UserModel.advanced(
                                      id: _editedUser.id,
                                      phone: _editedUser.phone,
                                      name: _editedUser.name,
                                      email: _editedUser.email,
                                      avartar: value,
                                      gender: _editedUser.gender,
                                      address: _editedUser.address,
                                      dateOfBirth: _editedUser.dateOfBirth,
                                    );
                                  },
                                ),
                              )
                            ],
                          )
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


// void onChangedSearch(value) {
//       if (value != null) {
//         setState(() {
//           valSearch = value;
//         });
//       }
//     }