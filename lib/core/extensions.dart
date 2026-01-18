import 'package:flutter/material.dart';

extension ThemeExtentions on BuildContext{
  Color primary(){
    return Theme.of(this).colorScheme.primary;
  }
  Color secondary(){
    return Theme.of(this).colorScheme.secondary;
  }
  Color surface(){
    return Theme.of(this).colorScheme.surface;
  }
  Color onPrimary(){
    return Theme.of(this).colorScheme.onPrimary;
  }
  Color containerBorder(){
    return Theme.of(this).colorScheme.primaryContainer;
  }
  TextStyle bodySmall(){
    return Theme.of(this).textTheme.bodySmall!;
  }
  TextStyle displayLarge(){
    return Theme.of(this).textTheme.displayLarge!;
  }
  TextStyle displaySmall(){
    return Theme.of(this).textTheme.displaySmall!;
  }
  Color onSecondary(){
    return Theme.of(this).colorScheme.onSecondary;
  }
  TextStyle titleLarge(){
    return Theme.of(this).textTheme.titleLarge!;
  }
  TextStyle bodyMedium(){
    return Theme.of(this).textTheme.bodyMedium!;
  }
  TextStyle displayMedium(){
    return Theme.of(this).textTheme.displayMedium!;
  }
}