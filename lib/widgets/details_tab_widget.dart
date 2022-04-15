import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:flutter/material.dart';

class DetailsTabWidget extends StatefulWidget {
  final String? productDetails;
  const DetailsTabWidget({Key? key,@required this.productDetails}) : super(key: key);

  @override
  _DetailsTabWidgetState createState() => _DetailsTabWidgetState();
}

class _DetailsTabWidgetState extends State<DetailsTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              UiIcons.file_2,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Description',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(widget.productDetails!),
        ),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.box,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Related Poducts',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
      ],
    );
  }
}
