import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final AnimationController animationController;
  ChatMessage(this.text, this.animationController);

  String _name = 'Kamil';

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        curve: Curves.fastOutSlowIn,
        parent: animationController,
      ),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16),
              child: CircleAvatar(
                child: Text(_name[0]),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(text),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
