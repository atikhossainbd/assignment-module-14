import 'package:contact_list/models/contact_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _numberTEController = TextEditingController();

  // contact list
  final List<ContactItem> contactItem = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _inputField(_nameTEController, "Name", "Name"),
            const SizedBox(height: 12),
            _inputField(_numberTEController, "Number", "Number"),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                _addItem();
              },
              child: const Text("Add"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: contactItem.length,
                itemBuilder: (context, index) {
                  return _contactListTile(contactItem[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactListTile(ContactItem contactItem, int position) {
    return Card(
      color: Colors.grey.shade200,
      elevation: 0,
      child: ListTile(
        onLongPress: () {
          _showDeleteDialog(position);
        },
        leading: const CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.person,
            color: Colors.blueGrey,
          ),
        ),
        title: Text(
          contactItem.name,
          style: TextStyle(
              color: Colors.deepOrange.shade300, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(contactItem.number),
        trailing: const Icon(
          Icons.call,
          color: Colors.blue,
        ),
      ),
    );
  }

  TextField _inputField(TextEditingController textEditingController,
      String hintText, String label) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        label: Text(label),
      ),
    );
  }

  void _showDeleteDialog(int position) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Are your sure for Delete ?"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.no_sim_outlined,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {
                _deleteItem(position);
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.blue,
              ),
            )
          ],
        );
      },
    );
  }

  void _addItem() {
    contactItem.add(ContactItem(
        name: _nameTEController.text, number: (_numberTEController.text)));
    _nameTEController.text = "";
    _numberTEController.text = "";
    setState(() {});
  }

  void _deleteItem(int position) {
    contactItem.removeAt(position);
    setState(() {});
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _numberTEController.dispose();
    super.dispose();
  }
}
