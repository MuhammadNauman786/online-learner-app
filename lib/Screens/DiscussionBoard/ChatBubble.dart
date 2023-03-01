import 'package:online_learner/library_main.dart';

class ChatBubble extends StatefulWidget {
  final String uid;
  const ChatBubble({Key? key, required this.uid}) : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final String userId = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  Widget build(BuildContext context) {
    return userId == widget.uid? Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(

        ),
      ],
    ):
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(

        ),
      ],
    );
  }
}
