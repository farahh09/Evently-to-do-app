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
  Color onSurface(){
    return Theme.of(this).colorScheme.onSurface;
  }
  Color outline(){
    return Theme.of(this).colorScheme.outline;
  }
  Color onPrimary(){
    return Theme.of(this).colorScheme.onPrimary;
  }
  Color error(){
    return Theme.of(this).colorScheme.error;
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
  TextStyle labelMedium(){
    return Theme.of(this).textTheme.labelMedium!;
  }
  TextStyle headlineLarge(){
    return Theme.of(this).textTheme.headlineLarge!;
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