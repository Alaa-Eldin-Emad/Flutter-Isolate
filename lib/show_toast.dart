import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String text,Color? backgroundColor) => Fluttertoast.showToast(
    msg: text,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor:backgroundColor?? Colors.red.shade700,
    textColor: Colors.white,
    fontSize: 16.0);