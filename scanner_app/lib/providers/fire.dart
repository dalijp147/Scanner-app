import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FireBAS {
  String? id;

  FireBAS(element, {
    this.id,
  });
  Map<String, dynamic> tojson() => {'id': id};
  FireBAS.fromSnapshot(snapshot) : id = snapshot.data()['id'];
}
