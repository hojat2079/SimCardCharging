import 'package:flutter/material.dart';
import 'package:simcard_charging/data/config_data.dart';
import 'package:simcard_charging/ui/color.dart';
import 'package:simcard_charging/util/extention.dart';

class PriceItem extends StatefulWidget {
  int selectedIndex;
  Function(int) onTap;

  PriceItem({Key? key, required this.selectedIndex, required this.onTap})
      : super(key: key);

  @override
  State<PriceItem> createState() => _PriceItemState();
}

class _PriceItemState extends State<PriceItem> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      textDirection: TextDirection.rtl,
      children: List.generate(
        Data.prices.length,
        (index) => _priceItem(index, widget.selectedIndex, (newIndex) {
          setState(() {
            widget.selectedIndex = newIndex;
            widget.onTap(newIndex);
          });
        }),
      ),
    );
  }

  Widget _priceItem(int index, int selectedIndex, Function(int) onTap) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: selectedIndex == index
              ? const BorderSide(color: ColorPalette.borderColor, width: 3)
              : BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ریال',
                style: TextStyle(
                    fontFamily: 'CustomFont',
                    color: Colors.grey[700],
                    fontWeight: FontWeight.normal,
                    fontSize: 11),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                Data.prices[index].toFaNumber().addComma(),
                style: const TextStyle(
                    fontFamily: 'CustomFont',
                    color: ColorPalette.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
