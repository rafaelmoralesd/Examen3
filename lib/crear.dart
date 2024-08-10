

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Crear extends StatelessWidget {
  Crear({super.key});

  final TextEditingController nombre_album = TextEditingController();
  final TextEditingController  nombre_banda = TextEditingController();
  final TextEditingController anio_lanzamiento = TextEditingController();
    final TextEditingController votos = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Album'),
      ),
      body: Column(
        children: [
          TextField(
            controller: nombre_album,
            decoration: const InputDecoration(
              labelText: 'Nombre',
            ),
          ),
          TextField(
            controller: nombre_banda,
            decoration: const InputDecoration(
              labelText: 'Nombre de la Banda',
            ),
          ),
          TextField(
            controller: anio_lanzamiento,
            decoration: const InputDecoration(
              labelText: 'Año de lanzamiento',
            ),
          ),
        
          
          ElevatedButton(
            onPressed: () async {
              final Albumes = {
                'Nombre': nombre_album.text,
                'Año de lanzamiento': anio_lanzamiento.text,
                'Nombre de la Banda': nombre_banda.text,
                'Votos':double.parse(votos.text),
              };

            
              final albumesRef =
                  FirebaseFirestore.instance.collection('Albumes');

              
              albumesRef.doc('1234').set(Albumes);
        
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}