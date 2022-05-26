import 'package:ecommerce_app/providers/select_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectSizeWidget extends StatefulWidget {
  List<String>? sizes;
  SelectSizeWidget({Key? key, @required this.sizes}) : super(key: key);

  @override
  _SelectSizeWidgetState createState() => _SelectSizeWidgetState();
}

class _SelectSizeWidgetState extends State<SelectSizeWidget> {
  int? _selected = -1;
  @override
  Widget build(BuildContext context) {
    final selectSize= Provider.of<SelectSize>(context);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(widget.sizes!.length, (index) {
        var _size = widget.sizes!.elementAt(index);
        return SizedBox(
          height: 38,
          child: RawChip(
            label: Text(_size),
            labelStyle: TextStyle(color: Theme.of(context).hintColor),
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            backgroundColor: Theme.of(context).focusColor.withOpacity(0.05),
            selectedColor: Theme.of(context).focusColor.withOpacity(0.2),
            selected: _selected == index,
            shape: StadiumBorder(
                side: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.05))),
            onSelected: (bool value) {
              if(value){
                setState(() {
                  _selected=index;

                });
                selectSize.setSize(_size);
              }else{
                _selected=null;
              }
            },
          ),
        );
      }),
    );
  }
}
