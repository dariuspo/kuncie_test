import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFa88beb);
const kSecondaryColor = Color(0xFFf8ceec);
const kPrimaryGradient = LinearGradient(
  colors: [
    kPrimaryColor,
    kSecondaryColor,
  ],
  stops: [0.5, 0.9],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
