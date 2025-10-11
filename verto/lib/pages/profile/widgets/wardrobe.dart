import 'package:flutter/material.dart';
import 'package:verto/widgets/coinbalance.dart';

class Wardrobe extends StatefulWidget {
  const Wardrobe({super.key});

  @override
  State<Wardrobe> createState() => _WardrobeState();
}

class _WardrobeState extends State<Wardrobe> with SingleTickerProviderStateMixin<Wardrobe> {
  
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isPanelOpen = false; 

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start off-screen right
      end: Offset.zero,             // End on-screen (right-aligned)
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
  
  Widget _buildBarrier() {
    if (!_isPanelOpen) return Container();

    return GestureDetector(
      onTap: _togglePanel, 
      child: Container(
        color: Colors.black54, 
      ),
    );
  }

  Widget _buildSideModal() {
    return Align(
      alignment: Alignment.centerRight,
      child: SlideTransition(
        position: _offsetAnimation, 
        child: Container(
          width: 280,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 8.0)
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
          ),
          child: ListView(
            children: [
              ListTile(
                style: ListTileStyle.drawer,
                leading: Image.asset('assets/armor.png'),
                title: Text('Medieval Armor'),
                subtitle: Text('Rarity: Common'),
                trailing: Column(
                  children: [
                    Image.asset('assets/coin.png',
                      height: 40,
                      width: 40,
                    ),
                    Text('20'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actionsPadding: const EdgeInsets.only(right: 12),
        actions: [CoinBalance()],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/wardrobe_background.png', fit: BoxFit.fitHeight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 50, height: 50, color: Colors.white),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: _togglePanel,
                        child: Container(width: 80, height: 80,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(118, 199, 100, 35),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 90, 22, 22),
                              width: 5,
                            ),
                          ),
                          // Use ClipRRect to properly clip the child image
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset('assets/armor.png', fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      // ... (other containers should be wrapped similarly if they also open the modal)
                      
                      // Example of another container corrected for clipping
                      GestureDetector(
                        onTap: _togglePanel,
                        child: Container(width: 80, height: 80,
                           decoration: BoxDecoration(
                             color: const Color.fromARGB(118, 199, 100, 35),
                             borderRadius: BorderRadius.circular(15),
                             border: Border.all(
                               color: const Color.fromARGB(255, 90, 22, 22),
                               width: 5,
                             ),
                           ),
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                             child: Image.asset('assets/armor.png', fit: BoxFit.cover),
                           ),
                         ),
                      ),
                      
                      GestureDetector(
                        onTap: _togglePanel,
                        child: Container(width: 80, height: 80,
                           decoration: BoxDecoration(
                             color: const Color.fromARGB(118, 199, 100, 35),
                             borderRadius: BorderRadius.circular(15),
                             border: Border.all(
                               color: const Color.fromARGB(255, 90, 22, 22),
                               width: 5,
                             ),
                           ),
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                             child: Image.asset('assets/armor.png', fit: BoxFit.cover),
                           ),
                         ),
                      ),
                      
                      GestureDetector(
                        onTap: _togglePanel,
                        child: Container(width: 80, height: 80,
                           decoration: BoxDecoration(
                             color: const Color.fromARGB(118, 199, 100, 35),
                             borderRadius: BorderRadius.circular(15),
                             border: Border.all(
                               color: const Color.fromARGB(255, 90, 22, 22),
                               width: 5,
                             ),
                           ),
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                             child: Image.asset('assets/armor.png', fit: BoxFit.cover),
                           ),
                         ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // 7. Add the Barrier and Modal to the Stack (after all main content)
          if(_isPanelOpen) _buildBarrier(), 
          _buildSideModal(), 
        ],
      ),
    );
  }
}