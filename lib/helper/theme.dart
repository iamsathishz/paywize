import 'package:flutter/material.dart';

final ThemeData appDarkTheme = ThemeData.dark().copyWith(
  textTheme: ThemeData.dark().textTheme.apply(
    fontFamily: 'Inter',
  ),
  primaryTextTheme: ThemeData.dark().primaryTextTheme.apply(
    fontFamily: 'Inter',
  ),
  scaffoldBackgroundColor: Colors.black,
);