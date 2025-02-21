import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/presentation/widgets/circular_icon/custom_circular_icon.dart';

class MYEditableProfileImage extends StatefulWidget {
  const MYEditableProfileImage({
    super.key,
    this.width = 200,
    this.height = 200,
    this.iconSize = 24,
    this.defaultImage, // Now defaultImage is File?
    required this.onImageSelected,
    this.iconColor = Colors.white,
    this.iconBackgroundColor,
    this.icon,
  });

  final double width;
  final double height;
  final double iconSize;
  final IconData? icon;
  final File? defaultImage; // ✅ Changed to File?
  final Function(File?) onImageSelected;
  final Color iconColor;
  final Color? iconBackgroundColor;

  @override
  State<MYEditableProfileImage> createState() => _MYEditableProfileImageState();
}

class _MYEditableProfileImageState extends State<MYEditableProfileImage> {
  File? _imageFile;

  void _showImagePreview(BuildContext context) {
    if (_imageFile != null || widget.defaultImage != null) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: MySizes.ninty.sw,
                height: MySizes.fifty.sh,
                decoration: const BoxDecoration(color: Colors.white),
                child: ClipRRect(
                  child: _imageFile != null
                      ? Image.file(_imageFile!, fit: BoxFit.cover)
                      : widget.defaultImage != null
                      ? Image.file(widget.defaultImage!, fit: BoxFit.cover)
                      : Container(),
                ),
              ),
              Positioned(
                top: -20,
                right: -20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Future<void> _showImagePicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take Photo"),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text("Choose from Gallery"),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 85,
      );

      setState(() {
        _imageFile = pickedFile != null ? File(pickedFile.path) : null;
      });

      widget.onImageSelected(_imageFile);
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => _showImagePreview(context),
            child: Container(
              width: widget.width.w,
              height: widget.height.h,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: _imageFile != null
                    ? Image.file(_imageFile!, width: widget.width.w, height: widget.height.h, fit: BoxFit.cover)
                    : widget.defaultImage != null
                    ? Image.file(widget.defaultImage!, width: widget.width.w, height: widget.height.h, fit: BoxFit.cover)
                    : Icon(Icons.person, size: widget.width.w * 0.5, color: Colors.grey[400]),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 25,
            child: MyCircularIcon(
              icon: widget.icon ?? Icons.camera_alt,
              backgroundColor: MYColors.secondaryColor,
              onTap: () => _showImagePicker(context),
            ),
          ),
        ],
      ),
    );
  }
}
