import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController= TextEditingController();
  final TextEditingController numberController= TextEditingController();

  final List<Map<String, String>> contact = [];

  void addContact(){
    final name= nameController.text.trim();
    final number= numberController.text.trim();

    if (name.isEmpty || number.isEmpty){
      return;
    };
    setState(() {
      contact.add({'name':name, 'number':number});
      nameController.clear();
      numberController.clear();
    });
  }


  void deleteContact(int index){
    showDialog(context: context,
        builder: (context)=>AlertDialog(
          title: Text("Delete Contract"),
          content: Text("Are you sure for delete"),
          actions: [
            TextButton(onPressed:() => Navigator.pop(context),
                child: Icon(Icons.cancel_presentation)),
            TextButton(
              onPressed: () {
                setState(() {
                  contact.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Icon(Icons.delete)
            ),
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contract List"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: numberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ),
          Container(
            width: 300,
            child: ElevatedButton(
              onPressed: addContact,
              child: const Text("Add"),
            ),
          ),

          Expanded(
            child: contact.isEmpty
                ? const Center(child: Text("No contacts yet."))
                : ListView.builder(
              itemCount: contact.length,
              itemBuilder: (context, index) {
                final contactItem = contact[index];
                return GestureDetector(
                  onLongPress: () => deleteContact(index),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(contactItem['name'] ?? ''),
                      subtitle: Text(contactItem['number'] ?? ''),
                      trailing:
                        Icon(Icons.call, color: Colors.red),


                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

    );
  }
}