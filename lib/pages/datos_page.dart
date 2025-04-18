import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widgets/thermometer_widget.dart';

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
      appBar: AppBar(title: Text('Datos del Sensor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ThermometerWidget(
              borderColor: Colors.red,
              innerColor: Colors.blue,
              indicatorColor: Colors.red,
              temperature: temperatura,
              width: 50,
            ),
            SizedBox(height: 20),
            Text('Temperatura: ${temperatura.toStringAsFixed(1)} ºC'),
            Text('Humedad: ${humedad.toStringAsFixed(1)} %'),
            Text('Humedad 2: ${humedad2 ?? 'N/A'} %'),
          ],
        ),
      ),
    );
  }
}
