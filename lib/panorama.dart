import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:panorama/panorama.dart';

class panorama extends StatelessWidget {
  const panorama({super.key, this.imagePath});
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: [
          Panorama(
            animSpeed: 1.0,
            sensorControl: SensorControl.Orientation,
            child: Image.network("http://10.0.2.2:4000/uploads/${imagePath!}"),
          ),
          Padding(
              padding: const EdgeInsets.all(35.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 27,
                ),
              ))
        ]),
      ),
    );
  }
}
