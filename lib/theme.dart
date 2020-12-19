import 'package:flutter/material.dart';

ThemeData get appTheme => ThemeData(
      scaffoldBackgroundColor: Colors.grey[200],
      primarySwatch: Colors.indigo,
      accentColor: Colors.blueGrey,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'Quicksand',
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                  ),
                ),
          ),
      textTheme: ThemeData.light().textTheme.copyWith(
            headline4: TextStyle(
              color: Colors.grey[800],
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
            headline5: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            headline6: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
    );
