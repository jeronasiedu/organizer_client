import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizer_client/app/core/user/data/database/user_remote_database.dart';
import 'package:organizer_client/app/features/chat/domain/entities/group_message.dart';
import 'package:organizer_client/shared/constant/db_collections.dart';

abstract class GroupChatRemoteDatabase {
  Stream<List<GroupMessageEntity>> getMessages(String groupId);
  Future<void> sendMessage(
    GroupMessageEntity message,
  );
  Future<void> deleteMessage(
    GroupMessageEntity message,
  );
  Future<void> editMessage(GroupMessageEntity message);
}

class GroupChatRemoteDatabaseImpl implements GroupChatRemoteDatabase {
  final UserRemoteDatabase userRemoteDatabase;
  GroupChatRemoteDatabaseImpl({required this.userRemoteDatabase});

  @override
  Stream<List<GroupMessageEntity>> getMessages(String groupId) {
    final messagesSnapshot = FirebaseFirestore.instance
        .collection(GROUPS_COLLECTION)
        .doc(groupId)
        .collection(MESSAGES_COLLECTION)
        .orderBy('timestamp', descending: true)
        .snapshots();
    return messagesSnapshot.asyncMap((snapshot) async {
      final messagesData = snapshot.docs;
      final List<GroupMessageEntity> messages = [];
      for (final message in messagesData) {
        final data = message.data();
        final sender = await userRemoteDatabase.get(data['sender']);
        data['sender'] = sender.toMap();
        messages.insert(0, GroupMessageEntity.fromMap(data));
      }
      return messages;
    });
  }

  @override
  Future<void> sendMessage(GroupMessageEntity message) async {
    final Map<String, dynamic> messageData = message.toMap();
    messageData['sender'] = message.sender.id;

    // if chat type is group, add the message to the group collection else add it the community collection

    await FirebaseFirestore.instance
        .collection(GROUPS_COLLECTION)
        .doc(message.groupId)
        .collection(MESSAGES_COLLECTION)
        .doc(message.id)
        .set(messageData);
  }

  @override
  Future<void> deleteMessage(GroupMessageEntity message) async {
    //  update the isDeleted field to true
    await FirebaseFirestore.instance
        .collection(GROUPS_COLLECTION)
        .doc(message.groupId)
        .collection(MESSAGES_COLLECTION)
        .doc(message.id)
        .delete();
  }

  @override
  Future<void> editMessage(GroupMessageEntity message) async {
    //  update the content field
    await FirebaseFirestore.instance
        .collection(GROUPS_COLLECTION)
        .doc(message.groupId)
        .collection(MESSAGES_COLLECTION)
        .doc(message.id)
        .update({'content': message.content});
  }
}
