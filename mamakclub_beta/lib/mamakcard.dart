import 'package:flutter/material.dart';
import 'package:mamakclub_beta/mamakstyles.dart';

class MamakCard extends StatelessWidget {
final String cardTitle; 
final String leftHeader; 
final String rightHeader;
final String leftValue;
final String rightValue;
final String leftSubTitle;
final String rightSubTitle;

  MamakCard({Key key, @required this.cardTitle, @required this.leftHeader,
  @required this.rightHeader,@required this.leftValue, @required this.rightValue,
  @required this.leftSubTitle,@required this.rightSubTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:new Column(
          children: <Widget>[
              Text(cardTitle, textAlign: TextAlign.center, style: MamakStyles.cardTitleStyle()),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(leftHeader, textAlign: TextAlign.center, style: MamakStyles.tableHeaderStyle()),
                  Text(' '),
                  Text(rightHeader, textAlign: TextAlign.center, style: MamakStyles.tableHeaderStyle()),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Expanded(
                    child:Text(leftValue, textAlign: TextAlign.center, style: MamakStyles.petrolStyle())
                  ),
                  new Text('-'),
                  new Expanded(
                    child:Text(rightValue, textAlign: TextAlign.center, style: MamakStyles.petrolStyle())
                  )
                  ,
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Expanded(
                    child:Text(leftSubTitle, textAlign: TextAlign.center, style: MamakStyles.headerFooterSmallStyle()),
                  ),
                  Text(' '),
                  new Expanded(
                    child:Text(rightSubTitle, textAlign: TextAlign.center, style: MamakStyles.headerFooterSmallStyle()),
                  )
                ],
              )
          ],
        ) 
        //,
      ),
    );
  }
}
