import 'package:cartify/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends StateNotifier<User?> {
  //constructor initialize with default User Object
  // perpose : Manege the state of the user allowing updates
  UserProvider()
    : super(
        User(
          id: '',
          fullName: '',
          email: '',
          state: '',
          city: '',
          locality: '',
          password: '',
          token: '',
        ),
      );
  // getter methode to extract the value of an object
  User? get uset => state;
  // method to set user state fromJson
  // perpose: update the state of the user object based on the json data
  void setUser(String userjson){
    state = User.fromJson(userjson);
  }
  // methode to clear the state
  void signOut(){
    state = null;
  }
}
// make the data accecsible within the app
  final userProvider = StateNotifierProvider<UserProvider, User?> ((ref)=> UserProvider());