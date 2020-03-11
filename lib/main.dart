import 'package:flutter/material.dart';
import 'package:ipl_team_analysis/pages/home.dart';
import 'package:ipl_team_analysis/provider/mainprovider.dart';
import 'package:provider/provider.dart';

void main(){
  //WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    ChangeNotifierProvider<MainProvider>.value(
    value: MainProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
    )
  );
}

