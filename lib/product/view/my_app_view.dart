import 'package:bkapp/domain/repository/mock_api_repository.dart';
import 'package:bkapp/domain/service/mock/mock_service.dart';
import 'package:bkapp/product/view/home_view.dart';
import 'package:bkapp/product/viewmodel/user_data/user_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => MockApiRepository(MockService()),
        child: BlocProvider(
          create: (context) =>
              UserDataBloc(RepositoryProvider.of<MockApiRepository>(context))..add(const UserDataFetchEvent()),
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeView(),
          ),
        ));
  }
}
