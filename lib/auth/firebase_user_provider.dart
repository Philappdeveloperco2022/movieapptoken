import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MCXTMovieFirebaseUser {
  MCXTMovieFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

MCXTMovieFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MCXTMovieFirebaseUser> mCXTMovieFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<MCXTMovieFirebaseUser>(
      (user) {
        currentUser = MCXTMovieFirebaseUser(user);
        return currentUser!;
      },
    );
