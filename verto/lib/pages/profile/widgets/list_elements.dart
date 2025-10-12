import 'package:flutter/material.dart';
import 'confirm_dialogue.dart';

class UnlockedAcquiredNotEquippedListElement extends StatefulWidget {
  UnlockedAcquiredNotEquippedListElement({
    super.key,
  });

  @override
  State<UnlockedAcquiredNotEquippedListElement> createState() => _UnlockedAcquiredNotEquippedListElementState();
}

class _UnlockedAcquiredNotEquippedListElementState extends State<UnlockedAcquiredNotEquippedListElement> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/armor.png',
                height: 80,
                width: 80,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Medieval Armor',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Rarity: Common',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UnlockedAcquiredEquippedListElement extends StatefulWidget {
  UnlockedAcquiredEquippedListElement({
    super.key,
  });

  @override
  State<UnlockedAcquiredEquippedListElement> createState() => _UnlockedAcquiredEquippedListElementState();
}

class _UnlockedAcquiredEquippedListElementState extends State<UnlockedAcquiredEquippedListElement> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          border: BoxBorder.all(
            color: Colors.blueAccent,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/armor.png',
                height: 80,
                width: 80,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Medieval Armor',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Rarity: Common',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UnlockedUnaquiredListElement extends StatefulWidget {
  UnlockedUnaquiredListElement({
    super.key,
  });

  @override
  State<UnlockedUnaquiredListElement> createState() => _UnlockedUnaquiredListElementState();
}

class _UnlockedUnaquiredListElementState extends State<UnlockedUnaquiredListElement> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          border: BoxBorder.all(
            width: 3,
            color: Colors.yellow,
          ),
          color: Colors.yellow.shade50,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/armor.png',
                height: 80,
                width: 80,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Medieval Armor',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Rarity: Common',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () => ConfirmDialogue(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/coin.png',
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
}

class LockedListElement extends StatefulWidget {
  LockedListElement({
    super.key,
  });

  @override
  State<LockedListElement> createState() => _LockedListElementState();
}

class _LockedListElementState extends State<LockedListElement> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children:[ 
          Container(
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            border: BoxBorder.all(
              color: Colors.red,
              width: 3
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/armor.png',
                  height: 80,
                  width: 80,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Medieval Armor',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Rarity: Common',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/coin.png',
                      height: 40,
                      width: 40,
                    ),
                    Text('20'),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 150, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(100),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Container(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 150, vertical: 20),
          child: Image.asset('assets/lock.png',
            height: 100,
            width: 100,
            fit: BoxFit.fitHeight,
          )),
        ],
      ),
    );
  }
}

Widget ListElement(int state){
  switch(state){
    case 0: return LockedListElement(); 
    case 1: return UnlockedUnaquiredListElement(); 
    case 2: return UnlockedAcquiredNotEquippedListElement(); 
    case 3: return UnlockedAcquiredEquippedListElement();
    default: return const Placeholder(fallbackHeight: 100, fallbackWidth: 300);
  }
}