// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
//
// import '../../componant/colors.dart';
// import 'ai_chat_bot.dart';
//
// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});
//
//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> {
//
//   final _openAI = OpenAI.instance.build(
//     token: OPENAI_API_KEY,
//     baseOption: HttpSetup(
//       receiveTimeout: const Duration(
//         seconds: 5,
//       ),
//     ),
//     enableLog: true,
//   );
//
//   final ChatUser _currentUser =
//       ChatUser(id: '1', firstName: "Ahmed", lastName: "Mokhtar");
//   final ChatUser _gptChatUser =
//       ChatUser(id: '2', firstName: "Chat", lastName: "GPT");
//    final List<ChatMessage> _messages = <ChatMessage>[];
//    final List<ChatUser> _typingUsers = <ChatUser>[];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  AppBar(
//         backgroundColor: TColors.backGround,
//         title: const Text(' HealthBot', style: TextStyle(color: TColors.black)),
//
//       ),
//       body: DashChat(
//           currentUser: _currentUser,
//           typingUsers:_typingUsers,
//           messageOptions: const MessageOptions(
//             currentUserContainerColor: TColors.black,
//             containerColor: TColors.primary,
//             textColor: TColors.white,
//           ),
//           onSend: (ChatMessage m) {
//             getChatResponse(m);
//           },
//           messages: _messages),
//       backgroundColor: TColors.backGround
//     );
//   }
//
//   Future<void> getChatResponse(ChatMessage m) async {
//     setState(() {
//       _messages.insert(0, m);
//       _typingUsers.add(_gptChatUser);
//     });
//     List<Messages> messageHistory = _messages.reversed.map((m) {
//       if (m.user == _currentUser) {
//         return Messages(role: Role.user, content: m.text);
//       } else {
//         return Messages(role: Role.assistant, content: m.text);
//       }
//     }).toList();
//
//     final request = ChatCompleteText(
//       model: GptTurbo0301ChatModel(),
//       messages: messageHistory,
//       maxToken: 200,
//     );
//     final response = await _openAI.onChatCompletion(request: request);
//     for (var element in response!.choices) {
//       if (element.message != null) {
//         setState(() {
//           _messages.insert(
//               0,
//               ChatMessage(
//                   user: _gptChatUser,
//                   createdAt: DateTime.now(),
//                   text: element.message!.content),
//           );
//         });
//       }
//     }
//     setState(() {
//       _typingUsers.remove(_gptChatUser);
//     });
//   }
// }
