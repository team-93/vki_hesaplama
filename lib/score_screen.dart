import 'package:flutter/material.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:share_plus/share_plus.dart';

class ScoreScreen extends StatelessWidget {
  final double bmiScore;

  final int age;

  String? bmiStatus;

  String? paylasStatus;

  String? bmiInterpretation;

  Color? bmiStatusColor;

  ScoreScreen({Key? key, required this.bmiScore, required this.age})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    setBmiInterpretation();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("VKİ SKORUNUZ"),
      ),
      body: Container(
          padding: const EdgeInsets.all(12),
          child: Card(
              elevation: 12,
              shape: const RoundedRectangleBorder(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "SONUCUNUZ",
                      style: TextStyle(fontSize: 30, color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PrettyGauge(
                      gaugeSize: 300,
                      minValue: 0,
                      maxValue: 40,
                      segments: [
                        GaugeSegment('İdeal kilonun altında', 18.5, Colors.red),
                        GaugeSegment('İdeal kiloda', 6.4, Colors.green),
                        GaugeSegment('İdeal kilonun üstünde', 5, Colors.orange),
                        GaugeSegment('İdeal kilonun çok üstünde (Obez)', 10.1, Colors.pink),
                      ],
                      valueWidget: Text(
                        bmiScore.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 40),
                      ),
                      currentValue: bmiScore.toDouble(),
                      needleColor: Colors.blue,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      bmiStatus!,
                      style: TextStyle(fontSize: 20, color: bmiStatusColor!),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      bmiInterpretation!,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Tekrar Hesapla")),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Share.share(
                                  "Vücut Kitle İndeksim: ${bmiScore.toStringAsFixed(1)}, $paylasStatus \nPeki ya sen?");
                            },
                            child: const Text("Paylaş")),
                      ],
                    )
                  ]))),
    );
  }

  void setBmiInterpretation() {
    if (bmiScore > 30) {
      bmiStatus = "İdeal kilonun çok üstündesiniz (obez)";
      paylasStatus = "İdeal kilonun çok üstündeyim.";
      bmiInterpretation = "\n Lütfen beslenme alışkanlıklarınızı ve aktivitelerinizi\n gözden geçirin.";
      bmiStatusColor = Colors.pink;
    } else if (bmiScore >= 25) {
      bmiStatus = "İdeal kilonun üstündesiniz";
      paylasStatus = "İdeal kilonun üstündeyim.";
      bmiInterpretation = "Lütfen düzenli bir şekilde egzersiz yaparak \nkilo vermeye çalışın. ";
      bmiStatusColor = Colors.orange;
    } else if (bmiScore >= 18.5) {
      bmiStatus = "İdeal kilodasınız";
      paylasStatus = "İdeal kilodayım.";
      bmiInterpretation = "Mükemmel gayet fitsiniz.";
      bmiStatusColor = Colors.green;
    } else if (bmiScore < 18.5) {
      bmiStatus = "İdeal kilonun altındasınız";
      paylasStatus = "İdeal kilonun altındayım.";
      bmiInterpretation = "Lütfen öğün atlamadan beslenip kilo almaya çalışın.";
      bmiStatusColor = Colors.red;
    }
  }
}
