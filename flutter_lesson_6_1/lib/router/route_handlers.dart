import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

Handler emptyHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return Container();
});