import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Techcity",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 38,

          ),),
        Image.asset("assets/images/logo.jpg",
          width: 40,),
      ],);
  }
}

