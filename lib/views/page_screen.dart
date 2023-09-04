// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';

class PageScreen extends StatefulWidget {
  const PageScreen({Key? key}) : super(key: key);

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  int cIndex = 0;
  Timer? time;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    time= Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(cIndex>1){
          cIndex=0;
        }else{
          cIndex++;
        }
        pageController.animateToPage(cIndex,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page"),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            margin: EdgeInsets.all(10),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: (value) {
                    cIndex=value;
                    setState(() {

                    });
                  },
                  children: [
                    Container(
                      color: Colors.red,
                      child: Center(child: Text("Home")),
                    ),
                    Container(
                      color: Colors.grey,
                      child: Center(child: Text("Setting")),
                    ),
                    Container(
                      color: Colors.blue,
                      child: Center(child: Text("Cart")),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(5),
                              child: CircleAvatar(
                                radius: 3,
                                backgroundColor: cIndex==index ? Colors.black:Colors.white,
                              ),
                            )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      // body: PageView(
      //   controller: pageController,
      //   // scrollDirection: Axis.vertical,
      //   onPageChanged: (value) {
      //     setState(() {
      //       cIndex = value;
      //     });
      //   },
      //   children: [
      //     Container(
      //       color: Colors.red,
      //       child: Center(child: Text("Home")),
      //     ),
      //     Container(
      //       color: Colors.grey,
      //       child: Center(child: Text("Setting")),
      //     ),
      //     Container(
      //       color: Colors.blue,
      //       child: Center(child: Text("Cart")),
      //     ),
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: cIndex,
        // showUnselectedLabels: false,
        // showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            tooltip: "Hello",
            label: "Home",
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            tooltip: "Setting",
            label: "Setting",
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            tooltip: "Cart",
            label: "Cart",
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: (value) {
          pageController.animateToPage(value,
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          setState(() {
            cIndex = value;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    time?.cancel();
    super.dispose();
  }
}
