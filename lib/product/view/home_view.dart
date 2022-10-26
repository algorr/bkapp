import 'package:bkapp/core/extensions/size_extension.dart';
import 'package:bkapp/product/view/user_detail_view.dart';
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
                    return _singleCardWidget(context, state, index);
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

// single card design
  Card _singleCardWidget(BuildContext context, UserDataState state, int index) {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: _circleAvatarWidget(context, state, index),
        ),
        Expanded(
          flex: 4,
          child: _userInfoColumn(state, index),
        ),
        Expanded(
          flex: 1,
          child: _detialViewButton( state,  index),
        )
      ],
    ));
  }

// circle avatar for user avatar
  SizedBox _circleAvatarWidget(
      BuildContext context, UserDataState state, int index) {
    return SizedBox(
        height: context.dynamicWidth(.2),
        width: context.dynamicWidth(.1),
        child: CircleAvatar(
            backgroundImage: NetworkImage('${state.users[index].avatar}')));
  }

// user infos widget
  Column _userInfoColumn(UserDataState state, int index) {
    return Column(
      children: [
        Text('${state.users[index].name} ${state.users[index].surname}'),
        Text(state.users[index].email ?? ''),
        Text(state.users[index].phone ?? ''),
      ],
    );
  }

// button for detail view
  IconButton _detialViewButton(UserDataState state, int index) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserDetailView(
                    user: state.users[index],
                  )));
        },
        icon: const Icon(Icons.next_plan));
  }
}
