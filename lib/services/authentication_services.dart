import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChnages => _firebaseAuth.authStateChanges();

//  sign in into firebase


  Future<void> SignIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

//    Creating user on the basis of their email and password

  Future<void> Signup(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // called logout event

  Future<void> Signout() async {
    await _firebaseAuth.signOut();
  }

  // signin With google

  Future<void> signInWithGoogle() async {
    
  }
}
