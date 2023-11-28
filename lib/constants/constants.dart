import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final CollectionReference userCollections =
    FirebaseFirestore.instance.collection('userCollections');
const TextStyle headingTextStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);
