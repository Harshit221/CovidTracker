import 'package:flutter/material.dart';

class FilterCountry extends StatefulWidget {
  List<String> countries;
  Map<String, String> flags;
  FilterCountry({Key key, this.countries, this.flags}) : super(key: key);

  @override
  _FilterCountryState createState() => _FilterCountryState();
}

class _FilterCountryState extends State<FilterCountry> {
  TextEditingController editingController = TextEditingController();
  List<String> items = List<String>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 650,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",

                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              onChanged: (value) {
                filterSearchResults(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(backgroundImage: AssetImage('assets/${widget.flags[items[index]]}'),radius: 15,),

                      SizedBox(width: 10,),
                      Expanded(child: Text('${items[index]}')),
                    ],
                  ),
                  onTap: (){
                    Navigator.of(context).pop(items[index]);
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20,),

        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    items.addAll(widget.countries);
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(widget.countries);
    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if(item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(widget.countries);
      });
    }
  }

}
