import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/controllers/user_controller.dart';
import 'package:flutter_firebase_blog/helpers/constants.dart';
import 'package:flutter_firebase_blog/helpers/functions.dart';
import 'package:flutter_firebase_blog/models/client.dart';
import 'package:flutter_firebase_blog/ui/screener.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileActivity extends StatefulWidget {
  final String? uid;

  const ProfileActivity({Key? key, this.uid}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileActivityState();
}

class _ProfileActivityState extends State<ProfileActivity> {
  String? id;
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobileNo = TextEditingController();
  String? _sex;
  String? avatar;

  DateTime? _dob = DateTime.now();

  String countryCode = '';
  String country = '';

  final UserController userController = UserController();

  _selectDate(BuildContext context, {DateTime? initialDate}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: (initialDate != null) ? initialDate : DateTime.now(),
        firstDate: DateTime((DateTime.now().year - 100), 8),
        lastDate: DateTime.now());
    if (picked != null && picked != _dob) {
      setState(() {
        _dob = picked;
      });
    }
  }

  File? _imageFile;
  final picker = ImagePicker();

  Future selectImage({ImageSource imageSource = ImageSource.camera}) async {
    XFile? selectedFile = await picker.pickImage(source: imageSource);
    // File imageFile = File(selectedFile!.path);

    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: selectedFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          /*CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9*/
        ],
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.blueGrey,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          hideBottomControls: true,
          lockAspectRatio: false,
        ),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    setState(() {
      _imageFile = croppedFile;
    });
  }

  Future<bool> _onWillPop() async {
    var result = await alert(context, 'Warning', 'You have to save your profile first.').then((value){
      return false;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Client>(
        future: userController.getUser(), // function where you call your api
        builder: (BuildContext context, AsyncSnapshot<Client> snapshot) {
          if (snapshot.hasData) {
            var user = snapshot.data?.client;
            printer('user object', user);
            id = user!['id'];
            _firstName.text = user['firstName'] ?? '';
            _lastName.text = user['lastName'] ?? '';
            _email.text = user['emailAddress'] ?? '';
            _mobileNo.text = user['mobileNo'] ?? '';

            _sex = (_sex != null) ? _sex : (user['sex'] ?? '');
            _dob = (_dob != null)
                ? _dob
                : ((user['dob'] != null)
                    ? (user['dob'] as Timestamp).toDate()
                    : DateTime.now());
            countryCode = user['dialCode'] ?? '';
            country = user['countryCode'] ?? '';
            if (user['avatar'] != null) {
              avatar = user['avatar'];
            }
            //_imageFile = (_imageFile != null) ? _imageFile : user['avatar'];

            return WillPopScope(
              onWillPop: _onWillPop,
              child: Scaffold(
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: constants['decoration_background'],
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 500,
                              margin: const EdgeInsets.only(bottom: 10, top: 80),
                              child: const Text(
                                'Profile',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  child: ClipRRect(
                                      child: (_imageFile == null)
                                          ? Image.asset(
                                        "assets/images/avatar.png",
                                        height: 130,
                                        width: 130,
                                        fit: BoxFit.contain,
                                      )
                                          : ((_imageFile != null)
                                          ? Image.file(
                                        _imageFile!,
                                        height: 130,
                                        width: 130,
                                        fit: BoxFit.contain,
                                      )
                                          : Image.network(avatar ?? '')),
                                      borderRadius: BorderRadius.circular(100.0)),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: -10,
                                  child: IconButton(
                                    icon: const Icon(Icons.camera),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: 120,
                                              child: Column(
                                                children: [
                                                  TextButton.icon(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        selectImage(
                                                            imageSource:
                                                            ImageSource.camera);
                                                      },
                                                      icon: const FaIcon(
                                                          FontAwesomeIcons.camera),
                                                      label: const Text(
                                                          "Select from camera")),
                                                  TextButton.icon(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        selectImage(
                                                            imageSource:
                                                            ImageSource.gallery);
                                                      },
                                                      icon: const FaIcon(
                                                          FontAwesomeIcons.image),
                                                      label: const Text(
                                                          "Select from gallery")),
                                                ],
                                              ),
                                            );
                                          });
                                      /*setState(() {
                          pickImage();
                        });*/
                                    },
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _firstName,
                                    decoration: const InputDecoration(
                                      labelText: 'First Name',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _lastName,
                                    decoration: const InputDecoration(
                                      labelText: 'Last Name',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _email,
                                    decoration: const InputDecoration(
                                      labelText: 'Email Address',
                                      border: OutlineInputBorder(),
                                      enabled: false,
                                    ),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Sex',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: RadioListTile(
                                          onChanged: (value) {
                                            setState(() {
                                              _sex = value.toString();
                                            });
                                          },
                                          groupValue: _sex,
                                          selected: (_sex == 'Male') ? true : false,
                                          value: 'Male',
                                          title: const Text('Male'),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: RadioListTile(
                                          onChanged: (value) {
                                            setState(() {
                                              _sex = value.toString();
                                            });
                                          },
                                          groupValue: _sex,
                                          selected: (_sex == 'Female') ? true : false,
                                          value: 'Female',
                                          title: const Text('Female'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 2,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Birth Date',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          formattedDate(_dob!, format: 'd MMM yyyy'),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: TextButton(
                                          onPressed: () =>
                                              _selectDate(context, initialDate: _dob),
                                          child: const Icon(Icons.event),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _mobileNo,
                                    decoration: InputDecoration(
                                      contentPadding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 8),
                                      prefix: CountryCodePicker(
                                        onChanged: (value) {
                                          countryCode = value.dialCode.toString();
                                          country = value.code.toString();
                                        },
                                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                        initialSelection: (countryCode.isNotEmpty)
                                            ? countryCode
                                            : 'BD',
                                        favorite: [],
                                        // optional. Shows only country name and flag
                                        showCountryOnly: true,
                                        // optional. Shows only country name and flag when popup is closed.
                                        showOnlyCountryWhenClosed: false,
                                        showFlag: false,
                                        // optional. aligns the flag and the Text left
                                        alignLeft: false,
                                      ),
                                      hintText: 'Mobile No',
                                      border: const OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          String? fileUrl =
                                          await userController.uploadFile(
                                            file: _imageFile,
                                            directory: 'avatar',
                                            uid: id!,
                                          );

                                          var updateUser = <String, dynamic>{};
                                          if (fileUrl != null) {
                                            updateUser = {
                                              'id': id,
                                              'firstName': _firstName.text,
                                              'lastName': _lastName.text,
                                              'mobileNo': _mobileNo.text,
                                              'dialCode': countryCode,
                                              'countryCode': country,
                                              'isEmailVerified': true,
                                              'dob': _dob,
                                              'avatar': fileUrl,
                                              'isNextLogin': true,
                                              'sex': _sex,
                                            };
                                          } else {
                                            updateUser = {
                                              'id': id,
                                              'firstName': _firstName.text,
                                              'lastName': _lastName.text,
                                              'mobileNo': _mobileNo.text,
                                              'dialCode': countryCode,
                                              'countryCode': country,
                                              'isEmailVerified': true,
                                              'dob': _dob,
                                              'isNextLogin': true,
                                              'sex': _sex,
                                            };
                                          }
                                          await userController
                                              .updateUser(updateUser)
                                              .then((value) {
                                            printer('update message',
                                                userController.message);
                                            if (userController.message!['status'] ==
                                                true &&
                                                userController.message!['code'] ==
                                                    200) {
                                              toast('Update successfully done');
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => Screener(
                                                          activity: 'dashboard')));
                                            }
                                          });
                                          setState(() {});
                                        },
                                        child: const Text(
                                          'Save',
                                          style: TextStyle(fontSize: 20),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
