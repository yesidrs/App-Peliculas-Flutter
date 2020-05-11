import 'package:flutter/material.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return CircularProgressIndicator(
      backgroundColor: Colors.indigo[100],
      valueColor: AlwaysStoppedAnimation<Color>(Colors.indigoAccent),
    );
  }
}
