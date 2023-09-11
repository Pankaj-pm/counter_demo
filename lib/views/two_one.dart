import 'package:flutter/cupertino.dart';

class TwoPage extends StatefulWidget {
  const TwoPage({Key? key}) : super(key: key);

  @override
  State<TwoPage> createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Two",
        style: TextStyle(color: CupertinoColors.white),
      ),
    );
  }
}
