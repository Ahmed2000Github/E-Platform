import 'package:flutter/material.dart';

class ControlsWidget extends StatelessWidget {
  final VoidCallback onClickedPickImage;
  final VoidCallback onClickedTakeImage;

  const ControlsWidget({
    @required this.onClickedPickImage,
    @required this.onClickedTakeImage,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: onClickedPickImage,
            child: Text('Pick Image'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onClickedTakeImage,
            child: Text('Take Image'),
          ),
          const SizedBox(width: 8),
        ],
      );
}
