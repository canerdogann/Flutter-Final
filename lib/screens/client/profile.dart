import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: unused_field
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? _image;
  final ImagePicker picker = ImagePicker();
  late User? _user;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _loadImage();
  }

  _loadCurrentUser() async {
    _user = _auth.currentUser;
    setState(() {});
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/selected_image.png';
      final File newImage = await File(pickedFile.path).copy(imagePath);

      setState(() {
        _image = newImage;
      });

      _saveImagePath(imagePath);
    }
  }

  Future<void> _saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('image_path', path);
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('image_path');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _user != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), shape: BoxShape.rectangle, color: Colors.white, border: Border.all(color: Colors.black, width: 1.3)),
                          child: _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(_image!.path),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                        Positioned(
                          child: GestureDetector(
                            onTap: () {
                              _pickImage();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), shape: BoxShape.rectangle, color: Colors.black, border: Border.all(color: Colors.black, width: 1.3)),
                              child: const Icon(
                                Icons.photo,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Name: ${_user!.displayName ?? "Not available"}",
                      //  style: Theme.of(context).textTheme.headline6, //todo
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Email: ${_user!.email ?? "Not available"}",
                      //   style: Theme.of(context).textTheme.subtitle1, //todo
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).go('/home');
                      },
                      child: Text('Home Screen'),
                    ),
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
