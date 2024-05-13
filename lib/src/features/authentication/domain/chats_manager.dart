import 'package:chatapp/src/features/authentication/domain/entities/chat_messages_resp.dart';
import 'package:chatapp/src/features/authentication/domain/entities/chats_list_resp.dart';

class ListChatsManager {
  ChatsUserResp? chatsSelected;
  List<ChatsUserResp>? chatsUser = [];
  List<ChatDetailsWithUserResp>? chatsToShow = [];
}
