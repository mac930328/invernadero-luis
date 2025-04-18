import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widgets/circular_sensor_widget.dart';

class DatosPage extends StatefulWidget {
  const DatosPage({super.key});

  @override
  DatosPageState createState() => DatosPageState();
}

class DatosPageState extends State<DatosPage> {
  final DatabaseReference sensorRef = FirebaseDatabase.instance.ref('datos');

  double temperatura = 0.0;
  double humedad = 0.0;
  int? humedad2 = 0;

  @override
  void initState() {
    super.initState();

    sensorRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
      if (data != null && data is Map) {
        setState(() {
          temperatura =
              (data['t'] != null)
                  ? double.tryParse(data['t']?.toString() ?? '0') ?? 0.0
                  : 0.0;
          humedad =
              (data['h'] != null)
                  ? double.tryParse(data['h']?.toString() ?? '0') ?? 0.0
                  : 0.0;
          humedad2 =
              data['h2'] != null ? int.tryParse(data['h2'].toString()) : null;
        });
      } else {
        debugPrint("⚠️ No se pudo leer los datos correctamente: $data");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Datos de los Sensores')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularSensorWidget(
              value: temperatura,
              label: "S1\nTemp.",
              color: Colors.orange,
              symbol: "ºC",
            ),
            SizedBox(height: 20),
            CircularSensorWidget(
              value: humedad,
              label: "S1\nHumidity.",
              color: Colors.blueAccent,
              symbol: "%",
            ),
            SizedBox(height: 20),
            CircularSensorWidget(
              value:
                  humedad2 != null
                      ? double.tryParse(humedad2.toString()) ?? 0.0
                      : 0.0,
              label: "S2\nHumidity.",
              color: Colors.lightBlue,
              symbol: "%",
            ),
          ],
        ),
      ),
    );
  }
}
