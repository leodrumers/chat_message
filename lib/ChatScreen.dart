import 'package:basic_layouts/ChatMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FriendlyChat'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Container(
        child: Column(
          children: [
            _flexibleListView(),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[200])))
            : null,
      ),
    );
  }

  Flexible _flexibleListView() {
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        reverse: true,
        itemBuilder: (_, int index) => _messages[index],
        itemCount: _messages.length,
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [_flexibleTextField(), _sendButton()],
        ),
      ),
    );
  }

  Flexible _flexibleTextField() {
    return Flexible(
      child: TextField(
        controller: _textController,
        onChanged: (String text) {
          setState(() {
            _isComposing = text.length > 0;
          });
        },
        onSubmitted: _isComposing ? _handleSubmitted : null,
        decoration: InputDecoration.collapsed(hintText: 'Send message'),
        focusNode: _focusNode,
      ),
    );
  }

  Container _sendButton() {
    var curpetinoButton = CupertinoButton(
      child: Text('Send'),
      onPressed:
          _isComposing ? () => _handleSubmitted(_textController.text) : null,
    );

    var iconButton = IconButton(
      icon: const Icon(Icons.send),
      onPressed:
          _isComposing ? () => _handleSubmitted(_textController.text) : null,
    );

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        child: Theme.of(context).platform == TargetPlatform.iOS
            ? curpetinoButton
            : iconButton);
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: const Duration(milliseconds: 500),
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
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
