import 'package:flutter/material.dart';
class Location extends StatefulWidget {
  

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
    
  
  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 153, 83, 165),
        title: Text('choose location'),
        centerTitle: true,
      ),
      
      );
 }
}

   
    