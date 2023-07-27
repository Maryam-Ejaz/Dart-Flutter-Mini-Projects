import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'services.dart';
import '_services.dart';

class ApiCrud extends StatefulWidget {
  const ApiCrud({super.key});

  @override
  State<ApiCrud> createState() => _ApiCrudState();
}

class _ApiCrudState extends State<ApiCrud> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  late Future<List<Product>> productsList;
  @override
  void initState() {
    super.initState();
    setState(() {
      productsList = fetchProduct();
    });
    // createproduct("H");
    // deleteproduct('418');
    // updateAlbum('id');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Stack(
      children: [
        Column(
          children: [
            _search(),
            products(),
          ],
        ),
        Align(
            alignment: FractionalOffset.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Add New product'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0.0,
                                        blurRadius: 5.0,
                                        offset: Offset(0.0, 0.0),
                                      )
                                    ]),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: TextField(
                                  controller: titleController,
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    hintText: 'Title',
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0.0,
                                        blurRadius: 5.0,
                                        offset: Offset(0.0, 0.0),
                                      )
                                    ]),
                                child: TextField(
                                  controller: descriptionController,
                                  minLines: 2,
                                  maxLines: 10,
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    hintText: 'Description',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => {
                                titleController.text = "",
                                descriptionController.text = "",
                                Navigator.pop(context, 'Cancel'),
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => {
                                createProduct(titleController.text,
                                        descriptionController.text)
                                    .then((value) => {
                                          setState(() {
                                            productsList = fetchProduct();
                                          }),
                                          titleController.text = "",
                                          descriptionController.text = "",
                                        }),
                                Navigator.pop(context, 'Add'),
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 50)),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }

  Expanded products() {
    return Expanded(
      // child: ListView(
      child:
          // for (Todo todoo in todoList) todoItem(todoo),
          FutureBuilder(
        future: fetchProduct(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (ctx, index) {
                if (snapshot.data[index].title != "" ||
                    snapshot.data[index].description != "") {
                  return productItem(
                    product: snapshot.data[index],
                    onDeleted: () => {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Success'),
                          content: const Text('Deleted Successfully'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  productsList = fetchProduct();
                                }),
                                Navigator.pop(context, 'Ok'),
                              },
                              child: const Text('Ok'),
                            ),
                          ],
                        ),
                      ),
                    },
                    onUpdated: () => {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Success'),
                          content: const Text('Updated Successfully'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  productsList = fetchProduct();
                                }),
                                Navigator.pop(context, 'Ok'),
                              },
                              child: const Text('Ok'),
                            ),
                          ],
                        ),
                      )
                    },
                  );
                }
                return SizedBox();
              },
            );
          }
        },
      ),
    );
  }
}

// *****************************************One product Tile

class productItem extends StatefulWidget {
  final VoidCallback? onDeleted;
  final VoidCallback? onUpdated;
  final Product? product;
  const productItem(
      {super.key, @required this.product, this.onDeleted, this.onUpdated});

  @override
  State<productItem> createState() => _productItemState();
}

// ignore: camel_case_types
class _productItemState extends State<productItem> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    print(widget.product?.title);
    var tit = widget.product?.title;
    var des = widget.product?.description;

    titleController.text = tit!;
    descriptionController.text = des!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

          // ***************************** Checkbox for active inactive status
          leading: const Icon(
              // widget.product?.status == 'active'
              // ?
              Icons.check_box
              // : Icons.check_box_outline_blank,
              // color: tdBlue,
              ),

          // *********************************  product Title
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product!.title,
                style: const TextStyle(
                    // color: tdGrey,
                    ),
              ),
              Text(
                widget.product!.description,
                style: const TextStyle(
                    // color: tdGrey,
                    ),
              ),
            ],
          ),

          // ****************** DELETE product *******************
          trailing: Wrap(
            spacing: 10,
            children: [
              Container(
                height: 35,
                width: 35,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  iconSize: 18,
                  // color: Colors.white,

                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Edit'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      // color: Colors.grey,
                                      spreadRadius: 0.0,
                                      blurRadius: 5.0,
                                      offset: Offset(0.0, 0.0),
                                    )
                                  ]),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: TextField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  fillColor: Colors.grey,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: 'Update Title',
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 0.0,
                                      blurRadius: 5.0,
                                      offset: Offset(0.0, 0.0),
                                    )
                                  ]),
                              child: TextField(
                                controller: descriptionController,
                                minLines: 2,
                                maxLines: 10,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  border: InputBorder.none,
                                  // hintStyle: TextStyle(color: tdGrey),
                                  hintText: 'Update Description',
                                ),
                              ),
                            ),
                            //
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => {
                              Navigator.pop(context, 'Cancel'),
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => {
                              updateProduct(
                                      widget.product!.id.toString(),
                                      titleController.text,
                                      descriptionController.text)
                                  .then((value) => {
                                        widget.onUpdated!(),
                                        // status = "",
                                      }),
                              Navigator.pop(context, 'Update'),
                            },
                            child: const Text('Update'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 35,
                width: 35,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  //  color: tdRed
                ),
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  iconSize: 18,
                  // color: Colors.,
                  onPressed: () => {
                    deleteProduct(widget.product!.id.toString())
                        .then((value) => {
                              widget.onDeleted!(),
                            })
                  },
                ),
              ),
            ],
          )),
    );
  }
}

Container _search() {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      child: const TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            // color: tdBlack,
            size: 20,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          // hintStyle: TextStyle(color: tdGrey)),
        ),
      ));
}
