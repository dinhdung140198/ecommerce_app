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


class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final user =Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            UiIcons.return_icon,
            color: Theme.of(context).hintColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
            child: InkWell(
              borderRadius: BorderRadius.circular(300),
              onTap: () {Navigator.of(context).pushNamed(AccountScreen.routeName);},
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    user!.avartar!),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 150),
            padding: EdgeInsets.only(bottom: 15),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        UiIcons.shopping_cart,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Shopping Cart',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      subtitle: Text(
                        'Verify your quantity and click checkout',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                  ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (ctx, i) => CartItemWidget(
                          id: cart.items.values.toList()[i].id,
                          productId: cart.items.keys.toList()[i],
                          name: cart.items.values.toList()[i].name,
                          quantity: cart.items.values.toList()[i].quantity,
                          price: cart.items.values.toList()[i].price,
                          color: cart.items.values.toList()[i].color,
                          size: cart.items.values.toList()[i].size,
                          urlImage: cart.items.values.toList()[i].urlImage),
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 15);
                      },
                      itemCount: cart.items.length)
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 1,
              child: Container(
                height: 170,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.15),
                          offset: Offset(0, -2),
                          blurRadius: 5.0)
                    ]),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'subtotal',
                            style: Theme.of(context).textTheme.bodyText1,
                          )),
                          Text(
                            '\$${cart.totalAmount}',
                            style: Theme.of(context).textTheme.subtitle1,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'TAX(10%)',
                            style: Theme.of(context).textTheme.subtitle1,
                          )),
                          Text(
                            '\$10',
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        fit: StackFit.loose,
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(CheckoutScreen.routeName);
                              },
                              padding: EdgeInsets.symmetric(vertical: 14),
                              color: Theme.of(context).accentColor,
                              shape: StadiumBorder(),
                              child: Text(
                                'Checkout',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              '\$${cart.totalAmount}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .merge(TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final String? id;
  final String? productId;
  final String? name;
  final int? quantity;
  final double? price;
  final Color? color;
  final String? size;
  final String? urlImage;
  const CartItemWidget(
      {Key? key,
      @required this.id,
      @required this.productId,
      @required this.name,
      @required this.quantity,
      @required this.price,
      @required this.color,
      @required this.size,
      @required this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (directon) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are Your sure?'),
            content: Text('Do you want to remove ${name} from the cart?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: Text('No')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: Text('Yes')),
            ],
          ),
        );
      },
      onDismissed: (direction) =>
          Provider.of<Cart>(context, listen: false).removeItem(productId!),
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        focusColor: Theme.of(context).accentColor,
        highlightColor: Theme.of(context).primaryColor,
        onTap: () {
          Navigator.of(context).pushNamed(ProductDetailWidget.routeName,
              arguments: this.productId);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).focusColor.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                  tag: id!,
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(urlImage!), fit: BoxFit.cover)),
                  )),
              SizedBox(
                width: 15,
              ),
              Flexible(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          '\$$price',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Color:',style: Theme.of(context).textTheme.subtitle1,),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(shape: BoxShape.circle,color: color),
                            ),
                            SizedBox(width: 15,),
                            Text('Size: $size',style: Theme.of(context).textTheme.subtitle1,)
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => cart.addItem(productId: productId!),
                        iconSize: 30,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        icon: Icon(Icons.add_circle_outline),
                        color: Theme.of(context).hintColor,
                      ),
                      Text(quantity.toString()),
                      IconButton(
                        onPressed: () => cart.removeSingleItem(productId!),
                        iconSize: 30,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        icon: Icon(Icons.remove_circle_outline),
                        color: Theme.of(context).hintColor,
                      ),
                    ],
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}



// https://stackoverflow.com/questions/50129761/flutter-hold-splash-screen-for-3-seconds-how-to-implement-splash-screen-in-flut
// ReorderableListView