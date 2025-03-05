import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  static final String routeName = 'Scan';

  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan Page')),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () => getImage(ImageSource.camera),
                label: Text('Camera'),
                icon: Icon(Icons.camera),
              ),
              TextButton.icon(
                onPressed: () => getImage(ImageSource.gallery),
                label: Text('Gallery'),
                icon: Icon(Icons.photo_album),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getImage(ImageSource source) async {
    /// The `async` keyword marks this function as asynchronous.
    /// This means the function can perform operations that take time to complete (e.g., picking an image).

    /// Use `await` to wait for the result of an asynchronous operation.
    /// Here, `ImagePicker().pickImage` is an asynchronous method that returns a `Future<XFile?>`.
    /// The `await` keyword pauses the execution of this function until the `Future` completes.
    final xFile = await ImagePicker().pickImage(source: source);

    /// After the `await` operation completes, the code continues executing.
    /// Check if the user picked an image (i.e., `xFile` is not null).
    if (xFile != null) {
      // If in debug mode, print the path of the selected image.
      if (kDebugMode) {
        print("the path is ${xFile.path}");
      }

      EasyLoading.show(status: "text is being extracted");

      /// object from google ML kit which will process the text from the image
      final textRecogniser = TextRecognizer(
        script: TextRecognitionScript.latin,
      );

      /// process the text from the selected file path and return the recognisedText
      //as it return Future<RecognizedText> we have to use await
      final recognisedText = await textRecogniser.processImage(
        InputImage.fromFilePath(xFile.path),
      );

      EasyLoading.dismiss(animation: true);

      final tempList = <String>[];

      // store the recognisedText in a tempList
      for (var block in recognisedText.blocks) {
        for (var lines in block.lines) {
          tempList.add(lines.text);
        }
      }

      if (kDebugMode) {
        print(" the recognised text is : $tempList");
      }
    }
  }
}
