import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIntest = GoogleSignIn(
  scopes: <String>[
    'email',
    'profile',
  ],
);
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('TodoItems');
