import 'package:bkapp/core/extensions/size_extension.dart';
import 'package:bkapp/domain/models/user_model.dart';
import 'package:bkapp/product/consts/page_consts.dart';
import 'package:flutter/material.dart';

class UserDetailView extends StatelessWidget {
  final User user;
  const UserDetailView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UserDetailViewConsts.appBarTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            flex: 3,
            child: SizedBox(),
          ),
          Expanded(
            flex: 3,
            child: _userAvatarWidget(context),
          ),
          Expanded(
            flex: 2,
            child: _userInfoColumnWidget(context),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: context.paddingOnlyHigh,
              child: _userInfoTextWidget(),
            ),
          ),
          const Expanded(
            flex: 4,
            child: SizedBox(),
          )
        ],
      ),
    );
  }

//fake static String for dummy data
  Text _userInfoTextWidget() => const Text(UserInfo.userInfo);

// user info column widget for detail_view
  Column _userInfoColumnWidget(context) {
    return Column(
      children: [
        Text('${user.name} ${user.surname}',style: Theme.of(context).textTheme.copyWith().headline6,),
        Text(user.email ?? ''),
        Text(user.phone ?? ''),
      ],
    );
  }

// user info circle avatar widget for detail_view
  CircleAvatar _userAvatarWidget(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(user.avatar ?? ''),
      radius: context.mediumVal,
    );
  }
}
