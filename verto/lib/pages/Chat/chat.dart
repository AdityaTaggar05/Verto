import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatUser {
  final int id;
  final String name;
  final String role;

  const ChatUser({required this.id, required this.name, required this.role});
}

final List<ChatUser> _users = [
  ChatUser(id: 00, name: "vedu", role: "teacher"),
  ChatUser(id: 01, name: "shakshak", role: "student"),
];

class ChatMessage {
  final String text;
  final bool isSentByMe;

  const ChatMessage({required this.text, required this.isSentByMe});
}

final Map<int, List<ChatMessage>> _messages = {
  1: [
    const ChatMessage(text: "Hello bhai!", isSentByMe: true),
    const ChatMessage(text: "Hello bhai, kaisa hai?", isSentByMe: false),
  ],
  2: [],
};

ChatUser? _selectedUser;

class VertoChat extends StatefulWidget {
  const VertoChat({super.key});

  @override
  State<VertoChat> createState() => _VertoChatState();
}

class _VertoChatState extends State<VertoChat> {
  void _selectUser(ChatUser user) {
    setState(() {
      _selectedUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verto Chat",
          style: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent[700],
          ),
        ),
        elevation: 1.0,
      ),
      body: Row(children: [_buildRecepientsList(), _buildChatWindow()]),
    );
  }

  Widget _buildRecepientsList() {
    return Container(
      width: 80,
      color: Colors.blueAccent[50],
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          final user = _users[index];
          final isSelected = _selectedUser?.id == user.id;
          return InkWell(
            onTap: () => _selectUser(user),
            child: Container(
              color: isSelected ? Colors.blue.shade50 : Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue.shade300,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.name,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent[400],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.role,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatWindow() {
    return Expanded(
      child: Container(
        color: Colors.blue.shade50,
        child: _selectedUser == null
            ? Center(
                child: Text(
                  "Start chatting with tutors and learners!",
                  style: GoogleFonts.roboto(fontSize: 15, color: Colors.black),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _messages[_selectedUser!.id]?.length ?? 0,
                      itemBuilder: (context, index) {
                        final message = _messages[_selectedUser!.id]![index];
                        return _buildMessageBubble(message);
                      },
                    ),
                  ),
                  _buildMessageComposer(),
                ],
              ),
      ),
    );
  }
}

Widget _buildMessageBubble(ChatMessage message) {
  return Align(
    alignment: message.isSentByMe
        ? Alignment.centerRight
        : Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: message.isSentByMe ? Colors.blueAccent.shade700 : Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        message.text,
        style: GoogleFonts.poppins(
          color: message.isSentByMe ? Colors.blueAccent[700] : Colors.white,
        ),
      ),
    ),
  );
}

Widget _buildMessageComposer() {
  final TextEditingController messageController = TextEditingController();
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
    color: Colors.white,
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: messageController,
            decoration: const InputDecoration.collapsed(
              hintText: "Type your message...",
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send, color: Colors.blueAccent.shade400),
          onPressed: () {
            ChatMessage message = ChatMessage(
              text: messageController.text,
              isSentByMe: true,
            );
            _buildMessageBubble(message);
            messageController.text = "";
          },
        ),
      ],
    ),
  );
}
