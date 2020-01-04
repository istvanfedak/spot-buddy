import 'package:flutter/material.dart';
import 'package:spot_buddy/services/AuthService.dart';
import 'package:spot_buddy/services/ValidatorService.dart';

/*
class StatefulInheritedModel extends StatefulWidget {
  StatefulInheritedModel({Key key, this.child, this.appName, this.appColor}) : super(key: key);
  final Widget child;
  final String appName;
  final Color appColor;

  @override
  _InheritedModelState createState() => _InheritedModelState();
}

class _InheritedModelState extends State<StatefulInheritedModel> {
  @override
  Widget build(BuildContext context) {
    return Model(
      child: widget.child,
      appName: widget.appName,
      appColor: widget.appColor,
    );
  }
}
*/
class Model extends InheritedWidget {
  const Model(
  {
    this.appName, 
    this.appColor, 
    this.authService, 
    this.validatorService, 
    Widget child
  }): super(child: child);
  
  final Color appColor;
  final String appName;
  final AuthService authService;
  final ValidatorService validatorService;

  @override
  bool updateShouldNotify(Model oldWidget) => true;

  static Model of(BuildContext context) =>
    context.inheritFromWidgetOfExactType(Model) as Model;
}