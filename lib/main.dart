import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
// import 'package:requests/requests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<CameraDescription> cameras=[];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(CameraApp());
}

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller=CameraController(cameras[0], ResolutionPreset.max);
  CameraImage? img;
  CameraController? cameraController;
  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        // cameraController!.startImageStream((imagestream){
        //   img = imagestream;
        //   runmodel();
        // });
      });
    });
  }

  // void runmodel() async{
  //   var result = await Tflite.runModelOnFrame(bytelist: img!.planes.map((plane){
  //     return plane.bytes;
  //   }));
  // }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Camera Surveillance System"),
          backgroundColor: Colors.lightGreen,
        ),
        body:Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10,bottom: 2),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 180,
                        height: 180,
                        child: CameraPreview(controller)),
                  ),
                  SizedBox(
                      width: 180,
                      height: 180,
                      child: CameraPreview(controller)),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 180,
                        height: 180,
                        child: CameraPreview(controller)),
                  ),
                  SizedBox(
                      width: 180,
                      height: 180,
                      child: CameraPreview(controller)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
              child:Text("Live video Feed"),
              ),
            ),
            Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0,left: 90),
                  child: RaisedButton(
                    child: Icon(Icons.camera_alt),
                      color: Colors.lightGreen,
                      onPressed: () async {
                      // File img = controller.takePicture() as File;
                      // var url = Uri.parse('http://192.168.1.104:456/get_img');
                      // final request = http.MultipartRequest("GET",url);
                      // final headers = {"Content-type":"multipart/form-data"};
                      // request.files.add(
                      //   http.MultipartFile('image',img.readAsBytes().asStream(),img.lengthSync())
                      // );
                      // request.headers.addAll(headers);
                      // await request.send();
                      // String base64Image = base64Encode(img.readAsBytesSync());
                      // // var data = 123;
                      // var url = Uri.parse('http://127.0.0.1:8000/get_img');
                      //
                      // final r = await http.post(Uri.parse("http://192.168.1.104:456/get_img"),headers: <String, String>{'Accept': '*/*'},body:{'image': base64Image});

                    }

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:20,left: 20.0),
                  child: RaisedButton(
                  child: Icon(Icons.videocam),
                  color: Colors.lightGreen,
                  onPressed: () async {}),
                )
              ],


            ),
            ),
          ],
        ),
      )
    );
  }
}