import 'package:flutter/material.dart';

class ProSize extends StatefulWidget {
  final List sizeList;
  final Function(String) onselected;
  const ProSize({Key? key, required this.sizeList, required this.onselected})
      : super(key: key);

  @override
  State<ProSize> createState() => _ProSizeState();
}

class _ProSizeState extends State<ProSize> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          for (var i = 0; i < widget.sizeList.length; i++)
            GestureDetector(
              onTap: () {
                widget.onselected("${widget.sizeList[i]}");
                setState(() {
                  _selected = i;
                });
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _selected == i
                      ? Theme.of(context).accentColor
                      : Color(0xffdcdcdc),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  "${widget.sizeList[i]}",
                  style: TextStyle(
                    color: _selected == i ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
