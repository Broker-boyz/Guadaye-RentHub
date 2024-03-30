import 'package:firebase_auth/firebase_auth.dart';

class EmailPasswordSignout {
  static void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
}
