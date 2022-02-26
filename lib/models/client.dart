import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_blog/models/firebase.dart';
import 'package:flutter_firebase_blog/helpers/functions.dart';

class Client {
  String? id;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? password;
  bool? isEmailVerified = false;
  String? mobileNo;
  bool isMobileVerified = false;
  String? sex;
  Timestamp? dob;
  String? avatar;
  bool isNextLogin = false;
  String? dialCode;
  String? countryCode;
  DateTime? createdOn;

  Client(
      {this.id,
      this.firstName,
      this.lastName,
      this.emailAddress,
      this.isEmailVerified = false,
      this.sex,
      this.dob,
      this.mobileNo,
      this.isMobileVerified = false,
      this.avatar,
      this.isNextLogin = false,
      this.dialCode,
      this.countryCode,
      this.createdOn});

  /*Future<Client> authenticate({required email, required password}) async {
    await FirebaseBridge.signIn(email, password).then((value) {
      printer('authenticate', value);
      if (value!.containsKey('user')) {
        setClient(value['user']);
        value.remove('user');
      }
      if (value!['status'] == true || value['code'] == 200) {
        setClient(value['user']);
        value.remove('user');
      }
      result = value;
    });
    return this;
  }

  Future<Client> register(
      {required firstName,
      required lastName,
      required email,
      required password}) async {
    await FirebaseBridge.signUp(firstName, lastName, email, password)
        .then((value) {
      print('print register');
      print(value);
      print('ending register');
      if (value!['status'] == true || value['code'] == 200) {
        setClient(value['user']);
        value.remove('user');
      }
      result = value;
    });
    return this;
  }

  Future<void> setClient(Map<String, dynamic> user) async {
    printer('setClient', user);
    id = user['id'];
    firstName = user['firstName'];
    lastName = user['lastName'];
    emailAddress = user['emailAddress'];
    isEmailVerified = user['isEmailVerified'];
    sex = user['sex'];
    dob = user['dob'];
    mobileNo = user['mobileNo'];
    isMobileVerified = user['isMobileVerified'];
    avatar = user['avatar'];
    isNextLogin = user['isNextLogin'];
    dialCode = user['dialCode'];
    countryCode = user['countryCode'];
    createdOn = (user['createdOn'] as Timestamp).toDate();
  }

  Future<Client> sendEmailVerification() async {
    await FirebaseBridge.activationMail(id!).then((value) {
      result = value;
    });
    return this;
  }

  factory Client.getClient({String uid = ''}) {
    return Client.fromMap(FirebaseBridge.getUser(uid: uid));
  }*/

  factory Client.fromMap(Map<String, dynamic>? client) {
    return Client(
      id: client!['id'],
      firstName: client['firstName'],
      lastName: client['lastName'],
      emailAddress: client['emailAddress'],
      isEmailVerified: client['isEmailVerified'],
      sex: client['sex'],
      dob: client['dob'],
      mobileNo: client['mobileNo'],
      isMobileVerified: client['isMobileVerified'],
      avatar: client['avatar'],
      isNextLogin: client['isNextLogin'],
      dialCode: client['dialCode'],
      countryCode: client['countryCode'],
      createdOn: (client['createdOn'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> get client {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'emailAddress': emailAddress,
      'mobileNo': mobileNo,
      'isMobileVerified': isMobileVerified,
      'dialCode': dialCode,
      'countryCode': countryCode,
      'sex': sex,
      'dob': dob,
      'avatar': avatar,
      'isNextLogin': isNextLogin,
      'createdOn': createdOn,
    };
  }
}
