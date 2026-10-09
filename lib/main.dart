import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  final String _name = 'Diluka';
  final String _email = 'diluka.w@nsbm.ac.lk';
  Uint8List? _profileImageBytes;
  int _points = 0;

  void _incrementPoints() {
    setState(() {
      _points++;
    });
  }

  Future<void> _pickProfileImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null || !mounted) return;

    final imageBytes = await image.readAsBytes();
    if (!mounted) return;

    setState(() {
      _profileImageBytes = imageBytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileImageBytes = _profileImageBytes;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Profile avatar with a badge overlay.
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Center(
              child: SizedBox(
                width: 108,
                height: 108,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFEBCBD2),
                            width: 1,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: profileImageBytes == null
                            ? Image.asset(
                                'assets/avatar.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.person,
                                      size: 64,
                                      color: Colors.black54,
                                    ),
                              )
                            : Image.memory(
                                profileImageBytes,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.person,
                                      size: 64,
                                      color: Colors.black54,
                                    ),
                              ),
                      ),
                    ),
                    Positioned(
                      left: 1,
                      bottom: 3,
                      child: Tooltip(
                        message: 'Choose profile photo',
                        child: Material(
                          color: Colors.black,
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: _pickProfileImage,
                            child: const SizedBox(
                              width: 32,
                              height: 32,
                              child: Icon(
                                Icons.camera_alt,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 1,
                      bottom: 3,
                      child: Icon(
                        Icons.check,
                        size: 36,
                        color: Color(0xFF00E000),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          // Name, email, and points details.
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileField(label: 'Name', value: Text(_name)),
                const SizedBox(height: 16),
                ProfileField(
                  label: 'Email',
                  value: Row(
                    children: [
                      const Icon(Icons.email, size: 16, color: Colors.black),
                      const SizedBox(width: 8),
                      Text(_email),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ProfileField(
                  label: 'Points',
                  value: Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.black),
                      const SizedBox(width: 8),
                      Text('$_points'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementPoints,
        tooltip: 'Add point',
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Reusable label and value layout for each profile detail.
class ProfileField extends StatelessWidget {
  const ProfileField({super.key, required this.label, required this.value});

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        DefaultTextStyle(
          style: const TextStyle(fontSize: 14, color: Colors.black),
          child: value,
        ),
      ],
    );
  }
}
