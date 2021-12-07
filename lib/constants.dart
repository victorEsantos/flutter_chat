import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Entre um valor',
  // hintStyle: kTextFieldHintStyle,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: kAppDefaultMainCOlor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: kAppDefaultMainCOlor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kAppDefaultMainCOlor = Color.fromARGB(255, 186, 52, 235);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Digite sua mensagem...',
  border: InputBorder.none,

);
