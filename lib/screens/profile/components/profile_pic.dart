import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waya/api/auth.dart';
import 'package:waya/functions/miscellaneous.dart';

class ProfilePic extends StatefulWidget {
  final int userID;
  final String userToken;
  final String profilePhotoLink;
  const ProfilePic(
      {Key? key,
      required this.userID,
      required this.userToken,
      required this.profilePhotoLink})
      : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  void pickProfilePic() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      confirmPickedImage();
    }
    setState(() {
      imageFile = image;
      file = File(imageFile!.path);
    });
    print(file);
  }

  Future<void> confirmPickedImage() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Save Image?"),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    imageFile = null;
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  savePickedImage();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          );
        });
  }

  Future savePickedImage() async {
    final response = await uploadProfileImage(
        userID: widget.userID,
        profilePhoto: file!,
        userToken: widget.userToken);
    // ignore: unrelated_type_equality_checks
    if (response == 200) {
      showSnackBar(message: 'Image saved successfully!', context: context);
    } else {
      showSnackBar(message: 'Error saving image!', context: context);
    }
  }

  dynamic imageFile;
  File? file;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          if (widget.profilePhotoLink != '[NULL]' &&
              widget.profilePhotoLink != 'null' &&
              widget.profilePhotoLink != '')
            CircleAvatar(
              backgroundImage: NetworkImage(widget.profilePhotoLink),
            )
          else
            imageFile == null
                ? const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/h.jpeg"))
                : CircleAvatar(
                    backgroundImage: FileImage(file!),
                  ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  pickProfilePic();
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
