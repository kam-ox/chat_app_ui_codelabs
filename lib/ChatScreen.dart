import 'package:flutter/material.dart';
import 'package:friendly_chat/ChatMessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  final _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isComposing = false;

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textEditingController,
                onSubmitted: _isComposing ? _handleSubmitted : null,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = !text.isEmpty;
                  });
                },
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textEditingController.text)
                    : null,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textEditingController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = ChatMessage(
      text,
      AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    _focusNode.requestFocus();
    message.animationController.forward();
  }

  @override
  void dispose() {
    for (var message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FriendlyChat'),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
              reverse: true,
              padding: EdgeInsets.all(8),
            ),
          ),
          Divider(height: 1),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}
