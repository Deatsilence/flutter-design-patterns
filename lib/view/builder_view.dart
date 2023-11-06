import 'package:design_patterns/patterns/builder/builder.dart';
import 'package:flutter/material.dart';

class BuilderView extends StatefulWidget {
  const BuilderView({super.key});

  @override
  State<BuilderView> createState() => _BuilderViewState();
}

class _BuilderViewState extends State<BuilderView> {
  NotPhotoPhotoBuilder _constantPhoto = NotPhotoPhotoBuilder(
    name: "What's wrong ?",
    size: const Size(50, 200),
    createdDate: DateTime.now(),
    deletedDate: null,
  );
  NotPhotoPhotoBuilder _photo = NotPhotoPhotoBuilder(
    name: "Me and my family",
    size: const Size(200, 100),
    createdDate: DateTime.now(),
    deletedDate: null,
  );
  final PhotoBuilder _photoBuilder = PhotoBuilder();

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                _constantPhoto = NotPhotoPhotoBuilder(
                  name: "What's wrong ?",
                  size: const Size(50, 200),
                  createdDate: DateTime.now(),
                  deletedDate: DateTime.utc(2023, 1, 1),
                );
              });
            },
            label: const Text("normally"),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                _count++;
                if (_count == 3) {
                  _photoBuilder.setDeletedDate(deletedDate: DateTime.now());
                  _photo = _photoBuilder.build();
                } else if (_count == 1) {
                  _photoBuilder.setName(name: "They");
                  _photoBuilder.setSize(size: const Size(900, 300));
                  _photo = _photoBuilder.build();
                }
              });
            },
            label: const Text("with builder"),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InformationsOfPhoto(photo: _constantPhoto),
              const SizedBox(height: 10), // use Gap instead of this
              _InformationsOfPhoto(photo: _photo),
            ],
          ),
        ),
      ),
    );
  }
}

class _InformationsOfPhoto extends StatefulWidget {
  const _InformationsOfPhoto({required this.photo});

  final Photo photo;

  @override
  State<_InformationsOfPhoto> createState() => _InformationsOfPhotoState();
}

class _InformationsOfPhotoState extends State<_InformationsOfPhoto> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.photo.name ?? "empty"),
        Text(widget.photo.size.toString()),
        Text(widget.photo.createdDate.toString()),
        Text(widget.photo.deletedDate.toString()),
      ],
    );
  }
}
