// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CommunityEntity extends Equatable {
  final String id;
  final String name;
  final int totalPeople;
  final int peoplePerGroup;
  final int totalGroups;
  final String createdBy;
  const CommunityEntity({
    required this.id,
    required this.name,
    required this.totalPeople,
    required this.peoplePerGroup,
    required this.totalGroups,
    required this.createdBy,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        totalPeople,
        peoplePerGroup,
        totalGroups,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'totalPeople': totalPeople,
      'peoplePerGroup': peoplePerGroup,
      'totalGroups': totalGroups,
      'createdBy': createdBy,
    };
  }

  factory CommunityEntity.initial() {
    return const CommunityEntity(
      id: "",
      name: "",
      totalPeople: 0,
      peoplePerGroup: 0,
      totalGroups: 0,
      createdBy: "",
    );
  }

  factory CommunityEntity.fromMap(Map<String, dynamic> map) {
    return CommunityEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      totalPeople: map['totalPeople'] as int,
      peoplePerGroup: map['peoplePerGroup'] as int,
      totalGroups: map['totalGroups'] as int,
      createdBy: map['createdBy'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommunityEntity.fromJson(String source) =>
      CommunityEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  CommunityEntity copyWith({
    String? id,
    String? name,
    int? totalPeople,
    int? peoplePerGroup,
    int? totalGroups,
    String? createdBy,
  }) {
    return CommunityEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      totalPeople: totalPeople ?? this.totalPeople,
      peoplePerGroup: peoplePerGroup ?? this.peoplePerGroup,
      totalGroups: totalGroups ?? this.totalGroups,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
