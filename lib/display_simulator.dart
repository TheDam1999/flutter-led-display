import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'display_painter.dart';
import 'to_pixels_converter.dart';

const canvasSize = 100.0;

class DisplaySimulator extends StatefulWidget {
  DisplaySimulator({
    this.text = "TestINIT",
    this.border = false,
    this.debug = true
  });

  final String text;
  final bool border;
  final bool debug;


  @override
  _DisplaySimulatorState createState() => _DisplaySimulatorState();
}

class _DisplaySimulatorState extends State<DisplaySimulator> {
  ByteData? imageBytes;
  List<List<Color>>? pixels;

  @override
  Widget build(BuildContext context) {
    _obtainPixelsFromText(widget.text);

    return Column(
      children: <Widget>[
        SizedBox(height: 96,),
        _getDebugPreview(),
        SizedBox(height: 48,),
        _getDisplay(),
        //_getDisplayWithWidgets()
      ],
    );
  }

  Widget _getDebugPreview() {
    print("dambt 3: $imageBytes  ${ widget.debug}");

    if (imageBytes == null || widget.debug == false) {
      return Container();
    }

    return Image.memory(
      Uint8List.view(imageBytes!.buffer),
      gaplessPlayback: true,
      filterQuality: FilterQuality.none,
      width: canvasSize,
      height: canvasSize,
    );
  }

  Widget _getDisplay() {
    if (pixels == null) {
      return Container();
    }

    return CustomPaint(
      size: Size.square(MediaQuery.of(context).size.width),
      painter: DisplayPainter(pixels: pixels, canvasSize: canvasSize)
    );
  }

  void _obtainPixelsFromText(String text) async {
    print("dambt 1: $text");
    ToPixelsConversionResult result = await ToPixelsConverter.fromString(
      string: text, border: widget.border, canvasSize: canvasSize
    ).convert();

    setState(() {
      print("dambt 2: ${result.imageBytes}");

      this.imageBytes = result.imageBytes;
      pixels = result.pixels;
    });
  }
}

