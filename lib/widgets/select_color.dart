import 'package:ecommerce_app/providers/select_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectColorWidget extends StatefulWidget {
  List<Color>? colors;
  // bool selected = false;
  SelectColorWidget({Key? key, @required this.colors}) : super(key: key);

  @override
  _SelectColorWidgetState createState() => _SelectColorWidgetState();
}

class _SelectColorWidgetState extends State<SelectColorWidget> {
  int? _value = 1;
  @override
  Widget build(BuildContext context) {
    final selectColor = Provider.of<SelectColor>(context);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(widget.colors!.length, (index) {
        var _color = widget.colors!.elementAt(index);
        return SizedBox(
          width: 38,
          height: 38,
          child: FilterChip(
            side: BorderSide(color: Theme.of(context).hintColor, width: 0.7),
            label: Text(''),
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            backgroundColor: _color,
            selectedColor: _color,
            selected: _value == index,
            shape: StadiumBorder(),
            avatar: Text(''),
            onSelected: (bool selected) {
              if (selected) {
                setState(() {
                  _value = index;
                });
                selectColor.setColor(_color);
              } else {
                _value = null;
              }
            },
          ),
        );
      }),
    );
  }
}
