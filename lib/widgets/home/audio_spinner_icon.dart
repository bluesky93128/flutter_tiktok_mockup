import 'package:flutter/material.dart';

Widget audioSpinner(avatar) {
  return Container(
      width: 50.0,
      height: 50.0,
      child: Center(
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            gradient: audioDiscGradient,
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(avatar)),
          ),
        ),
      ),
      decoration: BoxDecoration(
          gradient: audioDiscGradient,
          shape: BoxShape.circle,
         ));
}

LinearGradient get audioDiscGradient => LinearGradient(colors: [
      Colors.grey[800],
      Colors.grey[900],
      Colors.grey[900],
      Colors.grey[800]
    ], stops: [
      0.0,
      0.4,
      0.6,
      1.0
    ], begin: Alignment.bottomLeft, end: Alignment.topRight);
