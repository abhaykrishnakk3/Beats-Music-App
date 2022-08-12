import 'package:flutter/material.dart';

class NewBox extends StatelessWidget {
  final child;
  const NewBox({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(child: child),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 15,
              offset: const Offset(5,5)
            ),
              const BoxShadow(
              color: Colors.white,
              blurRadius: 15,
              offset:  Offset(-5,-5)
            )
          ]
        ),
      );
  }
}