import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/show_toast.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset('assets/life.gif', fit: BoxFit.fill)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                int sum1 = withoutIsolate();
                debugPrint('The Sum without Isolation is $sum1');
              },
              child: const Text('Calculate without Isolate'),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final receivePort = ReceivePort();
              await Isolate.spawn(Isolate1, receivePort.sendPort);
              receivePort.listen((sum1) {
                debugPrint('The Sum1 with Isolation is $sum1');
                 Fluttertoast.showToast(
                    msg: 'Sum1 = $sum1',
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 2,
                    backgroundColor:Colors.red.shade700,
                    textColor: Colors.white,
                    fontSize: 16.0);
              });
              final receivePort2 = ReceivePort();
              await Isolate.spawn(Isolate2, receivePort2.sendPort);
              receivePort2.listen((sum2) {
                debugPrint('The Sum2 with Isolation is $sum2');
                showToast('Sum 2 = $sum2',Colors.blue.shade700);
              },
              );
              final receivePort3 = ReceivePort();
              await Isolate.spawn(Isolate3, receivePort3.sendPort);
              receivePort3.listen((sum3) {
                debugPrint('The Sum3 with Isolation is $sum3');
                showToast('Sum 3 = $sum3',Colors.orange.shade700);
              },
              );
            }, child: const Text('Calculate with Isolate'),
    ),
        ],
      ),
    ));
  }

  int withoutIsolate() {
    int sum = 0;
    for (int i = 0; i < 1000000000; i++) {
      sum += i;
    }
    return sum;
  }
}

Isolate1(SendPort sendPort) {
  int sum1 = 0;
  for (int i = 0; i < 1000000000; i++) {
    sum1 += i;
  }
  sendPort.send(sum1);
}
Isolate2(SendPort sendPort) {
    int sum2 = 0;
    for (int i = 0; i < 1000000; i++) {
      sum2 += i;
    }
    sendPort.send(sum2);
  }
Isolate3(SendPort sendPort) {
  int sum3 = 0;
  for (int i = 0; i < 255555555; i++) {
    sum3 += i;
  }
  sendPort.send(sum3);
}
