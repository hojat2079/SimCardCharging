import 'package:flutter/material.dart';
import 'package:simcard_charging/data/config_data.dart';
import 'package:simcard_charging/ui/color.dart';

class OperatorList extends StatefulWidget {
  int selectOperatorIndex;
  Function(int) onTap;

  OperatorList(
      {Key? key, required this.selectOperatorIndex, required this.onTap})
      : super(key: key);

  @override
  State<OperatorList> createState() => _OperatorListState();
}

class _OperatorListState extends State<OperatorList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        Data.operators.length,
        (index) => _operatorItem(widget.selectOperatorIndex, index, (newIndex) {
          setState(() {
            widget.selectOperatorIndex = newIndex;
            widget.onTap(newIndex);
          });
        }),
      ),
    );
  }
}

Expanded _operatorItem(
    int selectOperatorIndex, int index, Function(int) onTap) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.only(left: 8),
      child: InkWell(
        onTap: () {
          onTap(index);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            border: selectOperatorIndex == index
                ? Border.all(color: ColorPalette.borderColor, width: 3)
                : null,
            image: DecorationImage(
                image: AssetImage(
                  Data.operators[index],
                ),
                fit: BoxFit.fitWidth),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
  );
}
