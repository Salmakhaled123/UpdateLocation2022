import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymap/cubit/cubit.dart';
import 'package:mymap/cubit/states.dart';
import 'cubit/bloc_observer.dart';
import 'modules/mapScreen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent));
  runApp( MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit(),
      child: BlocConsumer<LocationCubit, LocationStates>(
        builder: (context, state) {
          return MaterialApp(theme: ThemeData(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)),
            debugShowCheckedModeBanner: false,
            home: MapScreen(),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
