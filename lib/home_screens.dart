import 'package:flutter/material.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final _toDoController = TextEditingController();
  List _toDoItens = [];

  void addList() {
    setState(() {
      Map<String, dynamic> _newList = Map();
      _newList['title'] = _toDoController.text;
      _toDoController.text = "";
      _newList['ok'] = false;
      _toDoItens.add(_newList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Lista de compras"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Apagar tudo"),
                      content: Text(
                          "Tem certeza que deseja apagar toda a lista de compra?"),
                      actions: [
                        FlatButton(
                          child: Text("Sim"),
                          onPressed: () {
                            setState(() {
                              _toDoItens.clear();
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                        FlatButton(
                          child: Text("Não"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _toDoController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                      icon: Icon(Icons.add_rounded), onPressed: addList),
                  prefixIcon: Icon(Icons.add_shopping_cart),
                  hintText: "Ex: Maçã"),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _toDoItens.length, itemBuilder: buildItem))
        ],
      ),
    );
  }

  Widget buildItem(context, index) {
    return Dismissible(
        onDismissed: (DismissDirection direction) {
          setState(() {
            _toDoItens.removeAt(index);
          });
        },
        key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
        background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        direction: DismissDirection.startToEnd,
        child: CheckboxListTile(
          title: Text(_toDoItens[index]['title']),
          value: _toDoItens[index]['ok'],
          secondary: _toDoItens[index]['ok']
              ? Icon(Icons.check)
              : Icon(Icons.error_outline),
          onChanged: (c) {
            setState(() {
              _toDoItens[index]['ok'] = c;
            });
          },
        ));
  }

  void _deleteList(index) {
    _toDoItens.removeAt(index);
  }
}
