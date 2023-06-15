import 'package:flutter/material.dart';

var inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: BorderSide(color: Colors.amber, width: 1),
    gapPadding: 10);

InputDecoration tffDecoration = InputDecoration(
    isDense: true,
    contentPadding: const EdgeInsets.only(bottom: 20),
    enabledBorder:
    inputBorder.copyWith(borderRadius: BorderRadius.circular(10)),
    focusedBorder:
    inputBorder.copyWith(borderRadius: BorderRadius.circular(10)),
    errorBorder:
    inputBorder.copyWith(borderRadius: BorderRadius.circular(10)));