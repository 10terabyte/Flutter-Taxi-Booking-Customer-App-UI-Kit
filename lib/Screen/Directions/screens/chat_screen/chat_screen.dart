import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/Screen/Directions/screens/chat_screen/bubble_chat_widget.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatWidget extends StatelessWidget {
  ChatWidget({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          BubbleChatWidget(
            message: text,
            time: '12:00',
            delivered: true,
            isMe: false,
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatWidget> _messages = <ChatWidget>[];
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatWidget message = ChatWidget(
      text: text,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  Widget _buildTextComposer() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textController,
                  autofocus: true,
                  textInputAction: TextInputAction.unspecified,
                  decoration: InputDecoration.collapsed(
                      hintText: "Aa"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: primaryColor,
                    ),
                    onPressed: () => _handleSubmitted(_textController.text)),
              ),
            ]
        )
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message"),
        leading: IconButton(
          icon: Icon(Icons.clear,color: whiteColor,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
            children: <Widget>[
              Flexible(
                child: _messages.isNotEmpty ?
                GestureDetector(
                    onHorizontalDragDown: (_){
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      reverse: true,
                      itemCount: _messages.length,
                      itemBuilder: (_, int index) => _messages[index],
                    )
                ) : Center(
                  child: Container(
                    child: SvgPicture.asset(
                        'assets/image/svg/no_message.svg',
                        color: disabledColor,
                        semanticsLabel: 'Acme Logo'
                    ),
                  ),
                ),
              ),
              Divider(height: 1.0),
              SafeArea(
                child: _buildTextComposer(),
              )
            ]
        ),
      ),
    );
  }
}

