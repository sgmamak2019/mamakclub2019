import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageLayoutState extends State<HomePageLayout>{

  
  Widget _buildBody(BuildContext context){
     return StreamBuilder<QuerySnapshot>(
      stream:Firestore.instance.collection('petrol').snapshots(),
      builder:(context,snapshot){
        if(!snapshot.hasData) return LinearProgressIndicator();
         return _buildList(context,snapshot.data.documents);
      }
    );
  }
   Widget _buildList(BuildContext context,List<DocumentSnapshot> snapshot){
    return 
      ListView(
      padding: const EdgeInsets.only(top:20.0),
      children:snapshot.map((data)=>_buildListItem(context,data)).toList()
      );
  }
 Widget _buildExpansionTable(Record r){

   return new Container(
     child:Table(
       border: TableBorder(left: BorderSide.none,top:BorderSide.none, bottom: BorderSide.none),
       children: [
         TableRow(
          decoration: BoxDecoration(
            border: Border.all(width:0.0)
          ),
           children:[
              TableCell(
               child:new Align(
                 alignment: Alignment.centerLeft, child: new Text('')
               )
               ),
               TableCell(
                child:new Container(
                 width:10,
                 child:new Align(alignment: Alignment.center, child: new Text('PRICES',style:TextStyle(
                   fontSize:11,
                   fontWeight: FontWeight.bold
                 )))
               )
              )
          ]
         ),
          TableRow(
            decoration: BoxDecoration(
              color: Colors.grey[300],
                border: Border.all(width:0.0)
             ),
             children:[
                TableCell(
                child: _buildMamakCell('With Discount')
               ),
               TableCell(
                child: _buildMamakCellWithSub(r.price_with_discount, r.price_with_discount_company,Colors.green)
              )
          ]
         ),
          TableRow(
             decoration: BoxDecoration(
                border: Border.all(width:0.0)
             ),
             children:[
                TableCell(
                  child: _buildMamakCell('No Discount')
               ),
               TableCell(
                  child: _buildMamakCellWithSub(r.price_no_discount, r.price_no_discount_company,Colors.red)
              )
          ]
         )
       ]
     )
   );
 }
Widget _buildMamakCell(String label){
  return new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[
                           new Padding(
                            padding :EdgeInsets.all(5.0),
                            child: Align(alignment:Alignment.topCenter, child: new Text(label,style:TextStyle(
                            fontSize:12,height: 1.0
                          )))
                          ) 
                    ]
                  );
}
Widget _buildMamakCellWithSub(String title,String subtitle,Color colr){
      return new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                        new Padding(
                             padding :EdgeInsets.only(top:3.0,bottom: 3),
                          child:new Align(alignment: Alignment.center, child: new Text(title,style:TextStyle(
                          fontSize:13, color: colr,height: 1.0
                        ))),
                        ),
                           new Padding(
                             padding :EdgeInsets.all(0.5),
                          child:new Align(alignment: Alignment.center, child: new Text(subtitle,style:TextStyle(
                          fontSize:11, color: Colors.grey,height: 1.0
                        ))),
                        ),
                  ]
        );
}
 Widget _buildListItem(BuildContext context,DocumentSnapshot data){
    final Record record = Record.fromSnapShot(data);
    if(data.documentID=="_info"){
      return new Container(
        child:new Align(
          alignment:Alignment.center, child:new Text('Rates snapped at :' + record.snap_nicedate,
              style:TextStyle(fontSize:10, color:Colors.black)
          ))
        );
    }
    return new Container(
      decoration: new BoxDecoration(
         border: new Border(
           bottom: new BorderSide(
             color: Colors.blue,
             style: BorderStyle.none
           )
         )
      ),
      child:new Column(
        children:[
          ExpansionTile(
              initiallyExpanded: true,
              title: new Container(
                          height: 10,
                          padding:EdgeInsets.all(0.0),
                          child:new Align(
                            child: new Text(data.documentID,style:TextStyle(
                              fontSize:14, color:Colors.blueGrey, height: 1.0
                            )),
                          )
              ),
              
              children: <Widget>[
                _buildExpansionTable(record)
              ],
          )
    ])
    );
  }
  List<Widget> _drawerListItem(BuildContext context){
    List<ListTile> listItems = new List<ListTile>();

    listItems.add(new ListTile(
          title:Text('Carloan')
        ));

    listItems.add(
        new ListTile(
          title:Text('Fixed Deposit (SG)')
        )
    );
    listItems.add(
        new ListTile(
          title:Text('Fixed Deposit (MY)')
        )
    );
    return listItems;
  }
  Widget _drawerList(BuildContext context){
    return new ListView(
      padding:EdgeInsets.zero,
      children:[
        new Container(
          height:100,
          child:DrawerHeader(
          //  / margin: EdgeInsets.all(1.0),
            child:Column(
              children: [Text('Mamak Club',
                style:TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              )]
            ),
            decoration: BoxDecoration(
              color:Colors.blueGrey,
            ),
          ),
        ),
      
        new ListTile(
          title:Text('Carloan')
        ),
        new ListTile(
          title:Text('Fixed Deposit (MY)')
        ),
        new ListTile(
          title:Text('Fixed Deposit (SG)')
        )
      ]
    );
  }
  @override
  Widget build(BuildContext context){
      return new Scaffold(
      drawer: new Drawer(
        child:_drawerList(context)
      ),
      appBar:AppBar(
        title:Text(widget.title)
      ),
      body:_buildBody(context)
      );
  }
}
class HomePageLayout extends StatefulWidget{
  final String title;
  HomePageLayout({Key key, this.title}) : super(key: key);

  @override
  HomePageLayoutState createState()=>new HomePageLayoutState();

}

class Record{
  final String price_no_discount;
  final String price_no_discount_company;
  final String price_with_discount;
  final String price_with_discount_company;
  final String snap_nicedate;
  final DocumentReference reference;
 
  Record.fromMap(Map<String,dynamic> map, {this.reference})
  :price_no_discount = map['price-no-discount']==null ? '' :map['price-no-discount'] ,
  price_no_discount_company = map['price-no-discount_company']==null? '' : map['price-no-discount_company'],
  price_with_discount = map['price-with-discount']==null ? '' : map['price-with-discount'],
  price_with_discount_company = map['price-with-discount_company']==null ? '' : map['price-with-discount_company'],
  snap_nicedate = map['snap_nicedate'] ==null? '' : map['snap_nicedate'];

  Record.fromSnapShot(DocumentSnapshot snapshot)
  :this.fromMap(snapshot.data,reference:snapshot.reference);

  @override
  String toString()=>"Record<$price_no_discount:$price_no_discount_company>";

}
