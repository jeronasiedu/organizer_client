// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';

class GroupEntity extends Equatable {
  final String id;
  final String name;
  final int capacity;
  final String communityId;
  final List<AppUser> members;
  const GroupEntity({
    required this.id,
    required this.name,
    required this.capacity,
    this.communityId = "",
    required this.members,
  });
  // set groupRef
  set communityId(String value) => communityId = value;

  @override
  List<Object> get props {
    return [
      id,
      name,
      capacity,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'capacity': capacity,
      'communityId': communityId,
      'members': members.map((x) => x.toMap()).toList(),
    };
  }

  // check if the user is already in the group
  // getter for isMember
  bool get isMember {
    return members
        .any((member) => member.id == FirebaseAuth.instance.currentUser!.uid);
  }

  factory GroupEntity.initial() {
    return const GroupEntity(id: '', name: '', capacity: 0, members: []);
  }

  factory GroupEntity.fromMap(Map<String, dynamic> map) {
    return GroupEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      capacity: map['capacity'] as int,
      communityId: map['communityId'] as String,
      members: List<AppUser>.from(
        (map['members'] as List<int>).map<AppUser>(
          (x) => AppUser.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupEntity.fromJson(String source) =>
      GroupEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
