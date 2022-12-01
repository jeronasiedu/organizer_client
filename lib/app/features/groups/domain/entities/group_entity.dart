// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:organizer_client/app/features/groups/domain/entities/sub_group_entity.dart';

class GroupEntity extends Equatable {
  final String id;
  final String name;
  final int totalPeople;
  final int peoplePerGroup;
  final int totalGroups;
  final String createdBy;
  final List<SubGroupEntity> subGroups;
  const GroupEntity({
    required this.id,
    required this.name,
    required this.totalPeople,
    required this.peoplePerGroup,
    required this.totalGroups,
    required this.createdBy,
    required this.subGroups,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        totalPeople,
        peoplePerGroup,
        totalGroups,
        subGroups,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'totalPeople': totalPeople,
      'peoplePerGroup': peoplePerGroup,
      'totalGroups': totalGroups,
      'createdBy': createdBy,
      'subGroups': subGroups.map((x) => x.toMap()).toList(),
    };
  }

  factory GroupEntity.fromMap(Map<String, dynamic> map) {
    return GroupEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      totalPeople: map['totalPeople'] as int,
      peoplePerGroup: map['peoplePerGroup'] as int,
      totalGroups: map['totalGroups'] as int,
      createdBy: map['createdBy'] as String,
      subGroups: List<SubGroupEntity>.from(
        (map['subGroups'] as List<int>).map<SubGroupEntity>(
          (x) => SubGroupEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupEntity.fromJson(String source) =>
      GroupEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}