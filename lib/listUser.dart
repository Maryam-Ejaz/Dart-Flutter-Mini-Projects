// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'sqlhelper.dart';
import 'push_notifications.dart';

class ListOfItems extends StatefulWidget {
  const ListOfItems({Key? key}) : super(key: key);

  @override
  State<ListOfItems> createState() => _ListOfItemsState();
}

class _ListOfItemsState extends State<ListOfItems> {

  // NotificationServices notificationServices = NotificationServices();
  List<Map<String, dynamic>> _list = [];


  // Get all items
  void _getAllItems() async {
    final data = await SQLHelper.getItems();

    setState(() {
      _list = data;
    });
  }

  @override
  void initState(){
    super.initState();
    _getAllItems();
    // notificationServices.initializeNotifications();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Add Item
  Future<void> _addItem() async {
    await SQLHelper.createItem(_titleController.text, _descriptionController.text);
    _getAllItems();
    // notificationServices.sendNotification(
    //     'Add Notification',
    //     'The ${_titleController.text} Item has been added');
  }

  // Update Item
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(id, _titleController.text, _descriptionController.text);
    // notificationServices.sendNotification(
    //     'Update Notification',
        // 'The ${_titleController.text} Item has been updated');
    _getAllItems();
  }

  // Delete Item
  Future<void> _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully Deleted Item'))
    );
    _getAllItems();
    // notificationServices.sendNotification(
    //     'Delete Notification',
    //     'The ${_titleController.text} Item has been deleted');
  }

  // Show Items
  void _showForm(int? id){
    if(id != null){
      final existingItem = _list.firstWhere((element) => element['id'] == id);
      _titleController.text = existingItem['title'];
      _descriptionController.text = existingItem['description'];
    }

    if(id == null){
      _titleController.text = '';
      _descriptionController.text = '';
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,

        builder: (_) => Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 250,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (id == null){
                      await _addItem();
                    }
                    if (id != null){
                      await _updateItem(id);
                    }

                    _titleController.text = '';
                    _descriptionController.text = '';

                    Navigator.of(context).pop();
                  },
                  child: Text(id == null ? "Create New" : "Update"))
            ],
          ),
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQFLite Implementation'),
        backgroundColor: Colors.white, toolbarTextStyle: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.teal,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ).bodyMedium,
        titleTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.teal,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ).titleLarge,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.white, Colors.white],
          ),
        ),
        child: _list.isEmpty ?
        const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('No Items Added',style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black26
            ),
            ),
          ),
        ) : Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('List of Items',style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.teal,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    title: Text(_list[index]['title']),
                    subtitle: Text(_list[index]['description']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => _showForm(_list[index]['id']),
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => _deleteItem(_list[index]['id']),
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}