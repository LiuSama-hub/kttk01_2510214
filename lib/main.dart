import 'package:flutter/material.dart';
import 'models/task.dart';
import 'screens/about_screen.dart';
import 'screens/home_screen.dart';
import 'screens/task_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final sampleTasks = <Task>[
    Task(
      id: 1,
      title: 'Ôn tập Dart cơ bản',
      description: 'Ôn biến, kiểu dữ liệu, hàm và vòng lặp.',
      isDone: true,
    ),
    Task(
      id: 2,
      title: 'Thực hành Widget Flutter',
      description: 'Luyện tập Row, Column, Padding và Expanded.',
      isDone: true,
    ),
    Task(
      id: 3,
      title: 'Làm bài tập giao diện',
      description: 'Hoàn thiện bố cục màn hình ứng dụng.',
    ),
    Task(
      id: 4,
      title: 'Tìm hiểu điều hướng',
      description: 'Thực hành chuyển đổi giữa các màn hình.',
    ),
    Task(
      id: 5,
      title: 'Ôn tập quản lý trạng thái',
      description: 'Sử dụng setState để cập nhật giao diện.',
    ),
  ];

  // In tên và trạng thái của 5 công việc mẫu ra console.
  for (final task in sampleTasks) {
    debugPrint(
      'Công việc: ${task.title} | Trạng thái: ${task.isDone ? "Đã xong" : "Chưa xong"}',
    );
  }

  runApp(SonaTasksApp(tasks: sampleTasks));
}

class SonaTasksApp extends StatelessWidget {
  final List<Task> tasks;

  const SonaTasksApp({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SonaTasks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: MainScreen(tasks: tasks),
    );
  }
}

class MainScreen extends StatefulWidget {
  final List<Task> tasks;

  const MainScreen({super.key, required this.tasks});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomeScreen(),
      TaskScreen(tasks: widget.tasks),
      const AboutScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('SonaTasks'),
        actions: [
          IconButton(
            tooltip: 'Thông báo',
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showMessage('Bạn không có thông báo mới.'),
          ),
          IconButton(
            tooltip: 'Tài khoản',
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => _showMessage('Thông tin tài khoản sinh viên.'),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_outlined),
            selectedIcon: Icon(Icons.task),
            label: 'Task',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
