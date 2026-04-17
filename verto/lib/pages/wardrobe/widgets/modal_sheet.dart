import 'package:flutter/material.dart';

class SideModal extends StatefulWidget {
  @override
  _SideModalState createState() => _SideModalState();
}

class _SideModalState extends State<SideModal> with SingleTickerProviderStateMixin<SideModal> {
  
  // 1. Animation Controller and Animation
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isPanelOpen = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Define the Tween for sliding from right (1.0) to in view (0.0)
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Off-screen to the right
      end: Offset.zero,             // On-screen (right-aligned)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 2. Toggle Function (called by GestureDetector)
  void _togglePanel() {
    setState(() {
      _isPanelOpen = !_isPanelOpen;
    });
    if (_isPanelOpen) {
      _controller.forward(); // Slide in
    } else {
      _controller.reverse(); // Slide out
    }
  }

  // 3. Optional: Close Panel when tapping outside (GestureDetector for barrier)
  Widget _buildBarrier() {
    // Only show the barrier if the panel is open
    if (!_isPanelOpen) return Container();

    return GestureDetector(
      onTap: _togglePanel, // Close panel when tapping barrier
      child: Container(
        color: Colors.black54, // Dark transparent overlay
      ),
    );
  }

  // 💥 4. THE FIX: Implement the required 'build' method 💥
  @override
  Widget build(BuildContext context) {
    // This Container acts as your app's main area where the modal lives
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 400, // Define the height of the main area
      child: Stack(
        children: [
          // Layer 1: Main Content
          Center(
            child: GestureDetector(
              onTap: _togglePanel, 
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.blue,
                child: const Text(
                  'Tap to Open Right Side Modal', 
                  style: TextStyle(color: Colors.white)
                ),
              ),
            ),
          ),

          // Layer 2: The Semi-Transparent Barrier
          _buildBarrier(),

          // Layer 3: The Sliding Panel (Right Side Modal)
          Align(
            alignment: Alignment.centerRight,
            child: SlideTransition(
              position: _offsetAnimation, // Applies the slide animation
              child: Container(
                width: 200, // Fixed width for the modal
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 8.0)
                  ]
                ),
                child: Center(
                  child: ElevatedButton(
                    onPressed: _togglePanel,
                    child: const Text('Close Panel'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}