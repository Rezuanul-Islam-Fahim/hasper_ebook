import 'package:flutter/material.dart';

TextStyle errorTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 12,
    color: Theme.of(context).errorColor,
  );
}

TextStyle appBarTitle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );
}

TextStyle dataPanelTitle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
}

TextStyle dataPanelValue() {
  return TextStyle(color: Colors.white60, fontSize: 12);
}

TextStyle searchBookItem() {
  return TextStyle(
    fontSize: 14,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  );
}

TextStyle bookDescription() {
  return TextStyle(color: Colors.black54);
}

TextStyle actionButtonText() {
  return TextStyle(color: Colors.white, fontSize: 15);
}
