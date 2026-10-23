import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskScreen extends StatefulWidget {
  final List<Task> tasks;

  const TaskScreen({super.key, required this.tasks});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  int get _total => widget.tasks.length;
  int get _done => widget.tasks.where((task) => task.isDone).length;
  int get _notDone => _total - _done;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTask() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập tên công việc.')),
      );
      return;
    }

    final nextId = widget.tasks.isEmpty
        ? 1
        : widget.tasks.map((task) => task.id).reduce((a, b) => a > b ? a : b) + 1;

    setState(() {
      widget.tasks.add(
        Task(
          id: nextId,
          title: title,
          description: description,
          isDone: false,
          dueDate: null,
        ),
      );
      _titleController.clear();
      _descriptionController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã lưu công việc thành công.')),
    );
  }

  Widget _statCard(String label, int value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
          child: Column(
            children: [
              Icon(icon, color: color, size: 25),
              const SizedBox(height: 6),
              Text(
                '$value',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 3),
              Text(label, textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Thống kê công việc',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _statCard('Tổng công việc', _total, Icons.list_alt, Colors.indigo),
            _statCard('Đã xong', _done, Icons.check_circle, Colors.green),
            _statCard('Chưa xong', _notDone, Icons.pending_actions, Colors.orange),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Danh sách công việc',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if (widget.tasks.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Chưa có công việc nào.'),
          )
        else
          ...widget.tasks.map(
            (task) => Card(
              child: CheckboxListTile(
                value: task.isDone,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    decoration: task.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: Text(
                  task.description.isEmpty ? 'Không có mô tả' : task.description,
                ),
                onChanged: (value) {
                  setState(() {
                    task.isDone = value ?? false;
                  });
                },
              ),
            ),
          ),
        const SizedBox(height: 20),
        const Text(
          'Thêm công việc mới',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _titleController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Tên công việc',
            hintText: 'Ví dụ: Ôn tập Flutter',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.edit_note),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _descriptionController,
          minLines: 2,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: 'Mô tả',
            hintText: 'Nhập mô tả (không bắt buộc)',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.description),
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _saveTask,
            icon: const Icon(Icons.save),
            label: const Text('Lưu công việc'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
