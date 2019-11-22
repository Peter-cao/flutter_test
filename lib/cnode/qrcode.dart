import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/qrcode.dart';


class QrCode extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return QrCodeState();
  }
  
}

class QrCodeState extends State<QrCode>{
  QRCaptureController _captureController = QRCaptureController();

  bool _isTorchOn = false;

  @override
  void initState() {
    super.initState();

    _captureController.onCapture((data) {
      print('onCapture----$data');
      Navigator.pop(context, data);
    });
  }

  Widget _buildToolBar() {
    return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                _captureController.pause();
              },
              child: Text('pause'),
            ),
            FlatButton(
              onPressed: () {
                if (_isTorchOn) {
                  _captureController.torchMode = CaptureTorchMode.off;
                } else {
                  _captureController.torchMode = CaptureTorchMode.on;
                }
                _isTorchOn = !_isTorchOn;
              },
              child: Text('torch'),
            ),
            FlatButton(
              onPressed: () {
                _captureController.resume();
              },
              child: Text('resume'),
            ),
          ],
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("扫码"),
      ),
      body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            QRCaptureView(controller: _captureController),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildToolBar(),
            )
          ],
        ),
    );
  }

}