import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final String btnname;
  final void Function()? onTap;
  const Mybutton({super.key, required this.btnname, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.secondary,
        ),
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(child: Text(btnname)),
      ),
    );
  }
}
