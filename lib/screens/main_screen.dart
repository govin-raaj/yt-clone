import 'package:flutter/material.dart';

import 'home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List screens = [const Home(),const Text("Shorts"),const Text("UserAccount")];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.network("https://upload.wikimedia.org/wikipedia/commons/e/ef/Youtube_logo.png", scale: 15,),
        title:const Text("Youtube",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(icon:const Icon(Icons.cast),onPressed: (){},),
          IconButton(icon:const Icon(Icons.notifications),onPressed: (){},),
          IconButton(icon:const Icon(Icons.search),onPressed: (){},),
          
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:currentIndex ,
        items:  [
        const BottomNavigationBarItem(icon: Icon(Icons.home) , label: "home"),
        BottomNavigationBarItem(icon: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRS6w0iBsfY5N0nCu4Vvu3HztBVHUJUPfdPw&s",scale: 12,),label: "shorts"),
        const BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: "user")
      ],
      onTap: (value) {
          currentIndex=value;
          setState(() {
            
          });
      },
      ) ,

      body:screens[currentIndex],
    );
  }
}