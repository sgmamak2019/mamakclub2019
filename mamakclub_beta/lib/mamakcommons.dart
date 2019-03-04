import 'package:flutter/material.dart';
import 'package:mamakclub_beta/collection.dart';

class MamakCommons {
  static List<Collection> getDefaultCollections() {
    List<Collection> collections = new List<Collection>();

    Collection petrol = new Collection();
    Collection fxsg = new Collection();
    Collection fxmy = new Collection();
    Collection fixed_sg = new Collection();
    Collection fixed_my = new Collection();
    petrol.collectionName = "petrol";
    petrol.titleName = "Petrol";
    fxsg.collectionName = "fx";
    fxsg.collectionIcon = Icons.attach_money;
    fxsg.titleName = "FX (SG)";
    fxmy.titleName = "FX (MY)";
    fxmy.collectionIcon = Icons.attach_money;
    fxmy.collectionName = "fx_my";
    fixed_sg.collectionName = "fixed_deposit_sg";
    fixed_sg.collectionIcon = Icons.account_balance;
    fixed_sg.titleName = "Fixed Deposit SG";
    fixed_my.collectionIcon = Icons.account_balance;
    fixed_my.collectionName = "fixed_deposit_my";
    fixed_my.titleName = "Fixed Deposit MY";
    petrol.collectionIcon = Icons.airport_shuttle;
    collections = new List<Collection>();
    collections.add(petrol);
    collections.add(fxsg);
    collections.add(fxmy);
    collections.add(fixed_sg);
    collections.add(fixed_my);
    return collections;

  }

  static Widget getMamakDrawer(drawerList){
    return new Drawer(child:drawerList);
  }
  static String getValue(String  map){
    return map == null?'':map;
  }



}
