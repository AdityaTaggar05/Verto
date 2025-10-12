import 'package:flutter/material.dart';
import 'package:verto/api/session.dart';
import 'package:verto/utils/elements.dart';

class CreateSession extends StatefulWidget {
  const CreateSession({super.key});

  @override
  State<CreateSession> createState() => _CreateSessionState();
}

class _CreateSessionState extends State<CreateSession> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  double _sessionPrice = 10.0;
  TimeOfDay? _selectedTime;
  bool status = true;

  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void submitSession() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final time = _selectedTime;
    final today = DateTime.now();

    if (title.isEmpty || description.isEmpty || time == null) {
      showSnackBar(context, "Please fill in the fields correctly");
      return;
    }

    setState(() => status = false);
    await create(
      startTime: DateTime(
        today.year,
        today.month,
        today.day + 1,
        time.hour,
        time.minute,
      ).toUtc().toIso8601String(),
      price: _sessionPrice.toInt(),
      title: title,
      description: description,
    );
    setState(() => status = true);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a New Session'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _titleController,
                maxLength: 30,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Coding Basics 101',
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                maxLength: 80,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Some more details... ',
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Text(
                    'Session Price',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Slider(
                      value: _sessionPrice,
                      min: 0,
                      max: 100,
                      divisions: 20,
                      label: '\$${_sessionPrice.round()}',
                      onChanged: (double value) {
                        setState(() {
                          _sessionPrice = value.roundToDouble();
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: Text(
                      '\$${_sessionPrice.round()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Text(
                    'Select Start Time',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _selectTime,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade100,
                      foregroundColor: Colors.blue.shade800,
                      minimumSize: const Size(80, 50),
                      alignment: Alignment.centerRight,
                    ),

                    child: Text(
                      _selectedTime == null
                          ? 'Set Time (24h Clock)'
                          : 'Time Selected: ${_selectedTime!.format(context)}',
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: status ? submitSession : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: status
                      ? Colors.blue.shade400
                      : Colors.grey.shade800,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  'Create Session',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
