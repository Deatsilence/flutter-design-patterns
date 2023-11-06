import 'package:flutter/material.dart';

sealed class Photo {
  String? name;
  Size? size;
  DateTime? createdDate;
  DateTime? deletedDate;
}

/// this class is raw form
final class NotPhotoPhotoBuilder implements Photo {
  @override
  String? name;
  @override
  Size? size;
  @override
  DateTime? createdDate;
  @override
  DateTime? deletedDate;

  NotPhotoPhotoBuilder({
    this.name,
    this.size,
    this.createdDate,
    this.deletedDate,
  });
}

final class PhotoBuilder implements Photo {
  @override
  String? name;
  @override
  Size? size;
  @override
  DateTime? createdDate;
  @override
  DateTime? deletedDate;

  PhotoBuilder({
    this.name,
    this.size,
    this.createdDate,
    this.deletedDate,
  });

  PhotoBuilder setName({required String name}) {
    this.name = name;
    return this;
  }

  PhotoBuilder setSize({required Size size}) {
    this.size = size;
    return this;
  }

  PhotoBuilder setCreatedDate({required DateTime createdDate}) {
    this.createdDate = createdDate;
    return this;
  }

  PhotoBuilder setDeletedDate({required DateTime deletedDate}) {
    this.deletedDate = deletedDate;
    return this;
  }

  NotPhotoPhotoBuilder build() => NotPhotoPhotoBuilder(
        name: name,
        size: size,
        createdDate: createdDate,
        deletedDate: deletedDate,
      );
}
