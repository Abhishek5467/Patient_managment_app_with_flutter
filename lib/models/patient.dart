import 'dart:ui';

class Patient{
  final String name;
  final String age;
  final String gender;
  final String contact;
  final String? imagePath;
  final String? videoPath;

  Patient({
    required this.name,
    required this.age,
    required this.gender,
    required this.contact,
    required this.imagePath,
    required this.videoPath,
  });

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'contact': contact,
      'imagePath': imagePath,
      'videoPath': videoPath,

    };
  }

}