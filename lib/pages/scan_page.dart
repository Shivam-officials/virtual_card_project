import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_card_project/models/ContactModel.dart';
import 'package:virtual_card_project/pages/form_page.dart';
import 'package:virtual_card_project/utils/constants.dart';

class ScanPage extends StatefulWidget {
  static final String routeName = 'Scan';

  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanOver = false;
  List<String> lines = [];
  ContactModel contactDetails = ContactModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Page'),
        actions: [
          IconButton(
            onPressed:
                (contactDetails.image != null)
                    ? () {
                      if (isVCardEntryValid()) {
                        context.goNamed(
                          FormPage.routeName,
                          extra: contactDetails,
                        );
                      }
                    }
                    : null,
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
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
          if (isScanOver)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DragTargetItem(
                      properties: ContactProperties.name,
                      onDrop: setPropertyValue,
                    ),
                    DragTargetItem(
                      properties: ContactProperties.mobile,
                      onDrop: setPropertyValue,
                    ),
                    DragTargetItem(
                      properties: ContactProperties.email,
                      onDrop: setPropertyValue,
                    ),
                    DragTargetItem(
                      properties: ContactProperties.company,
                      onDrop: setPropertyValue,
                    ),
                    DragTargetItem(
                      properties: ContactProperties.designation,
                      onDrop: setPropertyValue,
                    ),
                    DragTargetItem(
                      properties: ContactProperties.address,
                      onDrop: setPropertyValue,
                    ),
                    DragTargetItem(
                      properties: ContactProperties.website,
                      onDrop: setPropertyValue,
                    ),
                  ],
                ),
              ),
            ),
          if (isScanOver)
            Padding(padding: EdgeInsets.all(8.0), child: Text(hint)),
          Wrap(
            children: lines.map((line) => LineItem(lineText: line)).toList(),
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

      setState(() {
        lines = tempList;
        isScanOver = true;
        contactDetails = contactDetails.copyWith(image: xFile.path);
      });
    }
  }

  setPropertyValue(String property, String value) {
    switch (property) {
      case ContactProperties.name:
        contactDetails = contactDetails.copyWith(name: value);
        break;
      case ContactProperties.website:
        contactDetails = contactDetails.copyWith(website: value);
        break;
      case ContactProperties.designation:
        contactDetails = contactDetails.copyWith(designation: value);
        break;
      case ContactProperties.company:
        contactDetails = contactDetails.copyWith(company: value);
        break;
      case ContactProperties.address:
        contactDetails = contactDetails.copyWith(address: value);
        break;
      case ContactProperties.email:
        contactDetails = contactDetails.copyWith(email: value);
        break;
      case ContactProperties.mobile:
        contactDetails = contactDetails.copyWith(mobile: value);
        break;
    }
  }

  bool isVCardEntryValid() {
    return (contactDetails.name != null && contactDetails.address != null);
  }
}

class LineItem extends StatelessWidget {
  final String lineText;
  const LineItem({super.key, required this.lineText});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      key: GlobalKey(),
      feedback: Container(
        padding: EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Colors.black45),
        child: Text(
          lineText,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
      ), // feedback widget shows what will be seen on dragging
      dragAnchorStrategy: childDragAnchorStrategy,
      data: lineText,
      child: Chip(label: Text(lineText)),
    );
  }
}

class DragTargetItem extends StatefulWidget {
  final String properties;
  final Function(String, String) onDrop;
  const DragTargetItem({
    super.key,
    required this.properties,
    required this.onDrop,
  });

  @override
  State<DragTargetItem> createState() => _DragTargetItemState();
}

class _DragTargetItemState extends State<DragTargetItem> {
  String dragItem = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(widget.properties)),
        Expanded(
          flex: 2,
          child: DragTarget<String>(
            builder: (context, candidateData, rejectedData) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border:
                      candidateData.isNotEmpty
                          ? Border.all(color: Colors.red, width: 2)
                          : null,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(dragItem.isEmpty ? 'Drop here' : dragItem),
                    ),
                    if (dragItem.isNotEmpty)
                      InkWell(
                        onTap: () {
                          setState(() {
                            dragItem = '';
                          });
                        },
                        child: const Icon(Icons.clear, size: 15),
                      ),
                  ],
                ),
              );
            },
            onAcceptWithDetails: (dropTargetDetails) {
              setState(() {
                dragItem =
                    dragItem.isEmpty
                        ? dropTargetDetails.data
                        : "$dragItem ${dropTargetDetails.data}";
                // widget.onDrop()
              });
              widget.onDrop(widget.properties, dragItem);
            },
          ),
        ),
      ],
    );
  }
}
