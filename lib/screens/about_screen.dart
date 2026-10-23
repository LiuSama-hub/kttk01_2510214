import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  // Thay các giá trị bên dưới bằng thông tin của bạn.
  static const String fullName = 'Họ và tên sinh viên';
  static const String studentId = 'MSSV của bạn';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        SizedBox(height: 20),
        Icon(Icons.task_alt, size: 90, color: Colors.indigo),
        SizedBox(height: 18),
        Center(
          child: Text(
            'SonaTasks',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 24),
        ListTile(
          leading: Icon(Icons.apps),
          title: Text('Tên ứng dụng'),
          subtitle: Text('SonaTasks - Quản lý công việc học tập'),
        ),
        ListTile(
          leading: Icon(Icons.school),
          title: Text('Môn học'),
          subtitle: Text('Lập trình Mobile với Flutter'),
        ),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('Phiên bản'),
          subtitle: Text('1.0'),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Mai Tran Gia Baao'),
          subtitle: Text(fullName),
        ),
        ListTile(
          leading: Icon(Icons.badge),
          title: Text('2510214'),
          subtitle: Text(studentId),
        ),
      ],
    );
  }
}
