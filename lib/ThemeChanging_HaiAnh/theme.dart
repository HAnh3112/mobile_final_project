// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class theme {
  final Color background_color;
  final Color main_text_color;
  final Color sub_text_color;
  final Color main_button_color;
  final Color sub_button_color;

  theme({
    required this.background_color,
    required this.main_button_color,
    required this.main_text_color,
    required this.sub_button_color,
    required this.sub_text_color
  });
}

theme lightTheme = theme(
  background_color: Colors.grey[100]!,
  main_text_color: Colors.black,
  sub_text_color: Colors.black54,
  main_button_color: Colors.purple[400]!,
  sub_button_color: Colors.white
);

theme darkTheme = theme(
  background_color: Colors.black, 
  main_button_color: Colors.deepPurple, 
  main_text_color: Colors.white, 
  sub_button_color: Colors.grey[800]!, 
  sub_text_color: Colors.grey[400]!
);