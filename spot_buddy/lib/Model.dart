import 'package:flutter/material.dart';

class Model extends InheritedWidget {
  const Model({Widget child}): super(child: child);

  @override
  bool updateShouldNotify(Model oldWidget){
    return false;
  }

  static Model of(BuildContext context) =>
    context.inheritFromWidgetOfExactType(InheritedWidget) as Model;
}