import 'package:bkapp/product/viewmodel/user_data/user_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
  }

  void _onScroll() {
    if (_didArrivedBottom) {
      context.read<UserDataBloc>().add(const UserDataFetchEvent());
    }
  }

  bool get _didArrivedBottom {
    if (!_scrollController.hasClients) {
      return false;
    }
    final atEndScroll = _scrollController.position.maxScrollExtent;
    final currentScrollOffset = _scrollController.offset;
    return currentScrollOffset >= atEndScroll * .8;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
      ),
      body: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          switch (state.status) {
            case FetchStatus.failure:
              return const Center(
                child: Text('Oopppsss!'),
              );
            case FetchStatus.success:
              return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network('${state.users[index].avatar}')),
                        Column(
                          children: [
                            Text(
                                '${state.users[index].name} ${state.users[index].surname} ?? '),
                            Text(state.users[index].email ?? ''),
                            Text(state.users[index].phone ?? ''),
                          ],
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.next_plan))
                      ],
                    ));
                  });
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}

//title: Text('${userList?[index].name} ${userList?[index].surname} ?? '),
