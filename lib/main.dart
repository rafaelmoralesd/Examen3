// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:examen3/firebase_options.dart';
import 'package:examen3/crear.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Albumes',
      
      initialRoute: '/home',
      routes: {
        '/home': (BuildContext context) => const HomePage(),
        '/crear': (BuildContext context) => Crear(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final albumesRef = FirebaseFirestore.instance.collection('Albumes');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Albumes'),
      ),
      body: StreamBuilder(
        // future: productosRef.get(),
        stream: albumesRef.snapshots(),
        builder: (BuildContext conext,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final query = snapshot.data; 

          final listaAlbumes =
              query!.docs;

          return ListView.builder(
            itemCount: listaAlbumes.length,
            itemBuilder: (BuildContext context, int index) {
              final Albumes = listaAlbumes[index].data(); 
             
             return ListTile(
              leading: IconButton(onPressed: () async{
                  void _incrementCounter() {
                     albumesRef.doc('RM').update({
                      'Votos': FieldValue.increment(1),
                     }).then((value) {
 
                        Albumes['Votos']++;
                     });
                     }
                
               


              }, icon: const Icon(Icons.plus_one) ),

                title: Text(Albumes['Nombre   ${Albumes['Votos']}']),
                subtitle: Text(Albumes['Año de lanzamiento']),
                trailing: Text(Albumes['Nombre de la Banda']),

                
                
             );

                
             
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/crear');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
