import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const RoundButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).height;

    return Center(
      child: InkWell(
          splashColor: Colors.blue[200],
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Ink(
            height: height * 0.054,
            width: width * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue[300],
            ),
            child: Center(
                child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            )),
          )),
    );
  }
}
