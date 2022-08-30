import 'dart:io';
import 'package:flutter/material.dart';

class SCan {
  final int id;
  final int scannum;
  SCan({
    required this.id,
    required this.scannum,
  });
  Map<String, Object?> toJson() => {
        'id': id,
        'scannum': scannum,
      };
}
