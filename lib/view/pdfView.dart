import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jewellery/style/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

// class OpenPdf extends StatefulWidget {
//   OpenPdf({super.key, required this.url});
//   String url;
//   @override
//   _OpenPdfState createState() => _OpenPdfState();
// }

// class _OpenPdfState extends State<OpenPdf> {
//   String pathPDF = "";
//   String landscapePathPdf = "";
//   String remotePDFpath = "";
//   String corruptedPathPDF = "";

//   @override
//   void initState() {
//     super.initState();
//     // fromAsset('assets/corrupted.pdf', 'corrupted.pdf').then((f) {
//     //   setState(() {
//     //     corruptedPathPDF = f.path;
//     //   });
//     // });
//     // fromAsset('assets/demo-link.pdf', 'demo.pdf').then((f) {
//     //   setState(() {
//     //     pathPDF = f.path;
//     //   });
//     // });
//     // fromAsset('assets/demo-landscape.pdf', 'landscape.pdf').then((f) {
//     //   setState(() {
//     //     landscapePathPdf = f.path;
//     //   });
//     // });

//     createFileOfPdfUrl().then((f) {
//       setState(() {
//         remotePDFpath = f.path;
//       });
//     });
//   }

//   Future<File> createFileOfPdfUrl() async {
//     Completer<File> completer = Completer();
//     print("Start download file from internet!");
//     try {
//       // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
//       // final url = "https://pdfkit.org/docs/guide.pdf";
//       final url = widget.url;
//       final filename = url.substring(url.lastIndexOf("/") + 1);
//       var request = await HttpClient().getUrl(Uri.parse(url));
//       var response = await request.close();
//       var bytes = await consolidateHttpClientResponseBytes(response);
//       var dir = await getApplicationDocumentsDirectory();
//       print("Download files");
//       print("${dir.path}/$filename");
//       File file = File("${dir.path}/$filename");

//       await file.writeAsBytes(bytes, flush: true);
//       completer.complete(file);
//     } catch (e) {
//       throw Exception('Error parsing asset file!');
//     }

//     return completer.future;
//   }

//   Future<File> fromAsset(String asset, String filename) async {
//     // To open from assets, you can copy them to the app storage folder, and the access them "locally"
//     Completer<File> completer = Completer();

//     try {
//       var dir = await getApplicationDocumentsDirectory();
//       File file = File("${dir.path}/$filename");
//       var data = await rootBundle.load(asset);
//       var bytes = data.buffer.asUint8List();
//       await file.writeAsBytes(bytes, flush: true);
//       completer.complete(file);
//     } catch (e) {
//       throw Exception('Error parsing asset file!');
//     }

//     return completer.future;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter PDF View',
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Plugin example app')),
//         body: Center(child: Builder(
//           builder: (BuildContext context) {
//             return Column(
//               children: <Widget>[
//                 // TextButton(
//                 //   child: Text("Open PDF"),
//                 //   onPressed: () {
//                 //     if (pathPDF.isNotEmpty) {
//                 //       Navigator.push(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //           builder: (context) => PDFScreen(path: pathPDF),
//                 //         ),
//                 //       );
//                 //     }
//                 //   },
//                 // ),
//                 // TextButton(
//                 //   child: Text("Open Landscape PDF"),
//                 //   onPressed: () {
//                 //     if (landscapePathPdf.isNotEmpty) {
//                 //       Navigator.push(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //           builder: (context) =>
//                 //               PDFScreen(path: landscapePathPdf),
//                 //         ),
//                 //       );
//                 //     }
//                 //   },
//                 // ),
//                 TextButton(
//                   child: Text("Remote PDF"),
//                   onPressed: () {
//                     if (remotePDFpath.isNotEmpty) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PDFScreen(path: remotePDFpath),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//                 // TextButton(
//                 //   child: Text("Open Corrupted PDF"),
//                 //   onPressed: () {
//                 //     if (pathPDF.isNotEmpty) {
//                 //       Navigator.push(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //           builder: (context) =>
//                 //               PDFScreen(path: corruptedPathPDF),
//                 //         ),
//                 //       );
//                 //     }
//                 //   },
//                 // )
//               ],
//             );
//           },
//         )),
//       ),
//     );
//   }
// }

class PDFScreen extends StatefulWidget {
  final String? path;
  final String? title;

  PDFScreen({Key? key, this.path, this.title}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gradient1,
        title: Text(widget.title ?? "Document"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.share),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      backgroundColor: gradient1,
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: false,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
                false, // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              print('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              print('page change: $page/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              backgroundColor: gradient1,
              label: Text("Go to ${pages! ~/ 2}"),
              onPressed: () async {
                await snapshot.data!.setPage(pages! ~/ 2);
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}

// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

// class OpenPdf extends StatefulWidget {
//   @override
//   _OpenPdfState createState() => _OpenPdfState();
// }

// class _OpenPdfState extends State<OpenPdf> {
//   final sampleUrl = 'http://www.africau.edu/images/default/sample.pdf';

//   String? pdfFlePath;

//   Future<String> downloadAndSavePdf() async {
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File('${directory.path}/sample.pdf');
//     if (await file.exists()) {
//       return file.path;
//     }
//     final response = await http.get(Uri.parse(sampleUrl));
//     await file.writeAsBytes(response.bodyBytes);
//     return file.path;
//   }

//   void loadPdf() async {
//     pdfFlePath = await downloadAndSavePdf();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Builder(builder: (context) {
//         return Scaffold(
//           backgroundColor: Colors.black,
//           appBar: AppBar(
//             title: Text('Plugin example app'),
//           ),
//           body: Center(
//             child: Column(
//               children: <Widget>[
//                 ElevatedButton(
//                   child: Text("Load pdf"),
//                   onPressed: loadPdf,
//                 ),
//                 if (pdfFlePath != null)
//                   Expanded(
//                     child: Container(
//                       child: PdfView(path: pdfFlePath!),
//                     ),
//                   )
//                 else
//                   Text("Pdf is not Loaded"),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
