part of 'messaging_bloc.dart';

@immutable
abstract class MessagingEvent extends Equatable {
  const MessagingEvent([List props = const <dynamic>[]]);

  @override
  List<Object> get props => <dynamic>[];
}

//triggered to fetch list of chats
class FetchConversationList extends MessagingEvent {
  @override
  String toString() => 'FetchConversationList';
}

//triggered when stream containing list of chats has new data
class ReceivedNewConversation extends MessagingEvent {
  const ReceivedNewConversation(this.conversationList);

  final List<Conversation> conversationList;

  @override
  String toString() => 'ReceivedChatsEvent';
}

//triggered to get details of currently open conversation
class FetchCurrentConversationDetails extends MessagingEvent {
  FetchCurrentConversationDetails(this.conversation) : super([conversation]);
  final Conversation conversation;

  @override
  String toString() => 'FetchConversationDetailsEvent';
}

class FetchMessages extends MessagingEvent {
  FetchMessages(this.room) : super([room]);
  final Conversation room;

  @override
  String toString() => 'FetchMessages';
}

//i think i'm gonna make the message all one big thing instead of having like a separate text/photo/file etc message
class ReceiveMessage extends MessagingEvent {
  ReceiveMessage(this.messages) : super([messages]);
  final List<Message> messages;

  @override
  String toString() => 'ReceiveMessage';
}

class SendMessage extends MessagingEvent {
  // SendMessageEvent({@required this.message}) : assert(message != null);
  SendMessage(this.message) : super([message]);
  final Message message;

  @override
  String toString() => 'SendMessage';
}

//TODO IMPLEMENT THESE LATER
class EditMessage extends MessagingEvent {
  EditMessage(this.messageIndex) : super([messageIndex]);
  final int messageIndex;

  @override
  String toString() => 'EditMessage';
}

class DeleteMessage extends MessagingEvent {
  DeleteMessage(this.messageIndex) : super([messageIndex]);
  final int messageIndex;

  @override
  String toString() => 'DeleteMessage';
}

//triggered on page change
class UpdatePage extends MessagingEvent {
  final int index;
  final Conversation activeConversation;

  UpdatePage(this.index, this.activeConversation)
      : super([index, activeConversation]);

  @override
  String toString() => 'ChangePage';
}
