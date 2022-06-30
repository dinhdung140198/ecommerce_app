import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final callback;
  const SearchBarWidget({Key? key, required this.callback}) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor.withOpacity(0.1),
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            onChanged: (value) {
              widget.callback(value);
            },
            controller: editingController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: 'Search',
                hintStyle: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(0.8)),
                prefixIcon: Icon(
                  UiIcons.loupe,
                  size: 20,
                  color: Theme.of(context).hintColor,
                ),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none)),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                UiIcons.settings_2,
                size: 20,
                color: Theme.of(context).hintColor.withOpacity(0.5),
              )),
        ],
      ),
    );
  }
}
