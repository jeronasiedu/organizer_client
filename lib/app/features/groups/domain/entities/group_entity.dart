// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/features/groups/domain/entities/social_link_entity.dart';

class GroupEntity extends Equatable {
  final String id;
  final String name;
  final int capacity;
  final String communityId;
  final String communityName;
  final List<AppUser> members;
  final List<SocialLinkEntity> socialLinks;
  final bool isAnonymity;
  const GroupEntity({
    required this.id,
    required this.name,
    required this.capacity,
    required this.communityId,
    required this.communityName,
    required this.members,
    required this.socialLinks,
    required this.isAnonymity,
  });
  @override
  List<Object> get props {
    return [
      id,
      name,
      capacity,
    ];
  }

  // nice formatting for the number of members
  String get membersCount {
    // if the group is full, show the capacity
    if (members.length == capacity) {
      return '$capacity/$capacity have joined';
    }
    return '${members.length}/$capacity have joined';
  }

  // check if group is full
  bool get isFull {
    return members.length == capacity;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'capacity': capacity,
      'communityId': communityId,
      'communityName': communityName,
      'members': members.map((x) => x.toMap()).toList(),
      'socialLinks': socialLinks.map((x) => x.toMap()).toList(),
      'isAnonymity': isAnonymity,
    };
  }

  // check if the user is already in the group
  // getter for isMember
  bool get isMember {
    return members
        .any((member) => member.id == FirebaseAuth.instance.currentUser!.uid);
  }

  String toJson() => json.encode(toMap());

  factory GroupEntity.fromJson(String source) =>
      GroupEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  factory GroupEntity.fromMap(Map<String, dynamic> map) {
    return GroupEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      capacity: map['capacity'] as int,
      communityId: map['communityId'] as String,
      communityName: map['communityName'] as String,
      members: List<AppUser>.from(
        (map['members'] as List<AppUser>)
            .map<AppUser>((AppUser x) => AppUser.fromMap(x.toMap())),
      ),
      socialLinks: List<SocialLinkEntity>.from(
        (map['socialLinks'] as List<dynamic>).map<SocialLinkEntity>(
          (x) => SocialLinkEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      isAnonymity: map['isAnonymity'] as bool,
    );
  }
}
