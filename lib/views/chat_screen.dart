import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.red,
          pinned: true,
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Title",style: TextStyle(color: Colors.black),),
            background: Image.network(
              "https://rukminim2.flixcart.com/image/416/416/l4yi7bk0/trimmer/q/l/1/0-5-3-mm-rechargeable-shaver-trimmer-for-men-electric-nose-original-imagfqg7c3ryt9pa.jpeg?q=70",
              fit: BoxFit.cover,
            ),
            collapseMode: CollapseMode.parallax
          ),
        ),
        SliverList(
          // delegate: SliverChildListDelegate(
          //   [
          //     Container(
          //       height: 50,
          //       width: 50,
          //       color: Colors.red,
          //       margin: EdgeInsets.all(5),
          //       child: Text("Hello"),
          //     ),
          //     Container(
          //       height: 50,
          //       width: 50,
          //       color: Colors.red,
          //       margin: EdgeInsets.all(5),
          //       child: Text("Hello"),
          //     ), Container(
          //       height: 50,
          //       width: 50,
          //       color: Colors.red,
          //       margin: EdgeInsets.all(5),
          //       child: Text("Hello"),
          //     ),
          //     Container(
          //       height: 50,
          //       width: 50,
          //       color: Colors.red,
          //       margin: EdgeInsets.all(5),
          //       child: Text("Hello"),
          //     )
          //   ],
          // ),
          delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
                height: 50,
                width: 50,
                color: Colors.red,
                margin: EdgeInsets.all(5),
                child: Text("Hello"));
          }, childCount: 2),
        ),
        // SliverAppBar(
        //   backgroundColor: Colors.red,
        //   pinned: true,
        //   flexibleSpace: FlexibleSpaceBar(
        //     title: Text("Title"),
        //   ),
        // ),
        // SliverToBoxAdapter(
        //   child: Image(
        //       image: NetworkImage(
        //           "https://rukminim2.flixcart.com/image/416/416/l4yi7bk0/trimmer/q/l/1/0-5-3-mm-rechargeable-shaver-trimmer-for-men-electric-nose-original-imagfqg7c3ryt9pa.jpeg?q=70")),
        // ),
        SliverGrid(
            // delegate: SliverChildListDelegate(
            //   [
            //     Container(
            //       height: 50,
            //       width: 50,
            //       color: Colors.red,
            //       margin: EdgeInsets.all(5),
            //       child: Text("Hello"),
            //     ),
            //     Container(
            //       height: 50,
            //       width: 50,
            //       color: Colors.red,
            //       margin: EdgeInsets.all(5),
            //       child: Text("Hello"),
            //     ),
            //     Container(
            //       height: 50,
            //       width: 50,
            //       color: Colors.red,
            //       margin: EdgeInsets.all(5),
            //       child: Text("Hello"),
            //     ),
            //     Container(
            //       height: 50,
            //       width: 50,
            //       color: Colors.red,
            //       margin: EdgeInsets.all(5),
            //       child: Text("Hello"),
            //     ),
            //     Container(
            //       height: 50,
            //       width: 50,
            //       color: Colors.red,
            //       margin: EdgeInsets.all(5),
            //       child: Text("Hello"),
            //     ),
            //     Container(
            //       height: 50,
            //       width: 50,
            //       color: Colors.red,
            //       margin: EdgeInsets.all(5),
            //       child: Text("Hello"),
            //     ),
            //   ],
            // ),
            delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                      height: 50,
                      width: 50,
                      color: Colors.red,
                      margin: EdgeInsets.all(5),
                      child: Text("Hello"),
                    ),
                childCount: 1),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)),
        SliverFillRemaining()

        // SliverGrid.builder(gridDelegate: gridDelegate, itemBuilder: (context, index) => ,),
        // SliverGrid.count(crossAxisCount: crossAxisCount,children: [],)
      ],
    );
  }
}
