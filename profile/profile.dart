import 'package:auf/bloc/user_bloc.dart';
import 'package:auf/constant.dart';
import 'package:auf/helpers/secure_storage_api.dart';
import 'package:auf/models/user/user_model.dart';
import 'package:auf/models/user/user_response_model.dart';
import 'package:auf/providers/user_data_notifier.dart';
import 'package:auf/public_components/button_logout.dart';
import 'package:auf/public_components/button_primary.dart';
import 'package:auf/public_components/button_secondary.dart';
import 'package:auf/public_components/button_tertiary.dart';
import 'package:auf/public_components/custom_dialog.dart';
import 'package:auf/public_components/h1.dart';
import 'package:auf/public_components/loading_dialog.dart';
import 'package:auf/public_components/space.dart';
import 'package:auf/public_components/theme_spinner.dart';
import 'package:auf/resource/user_resource.dart';
import 'package:auf/screens/change_password/change_password.dart';
import 'package:auf/screens/profile/components/body.dart';
import 'package:auf/screens/profile/edit_profile.dart';
import 'package:auf/services/web_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<UserModel?> _userModel;
  UserBloc userBloc = UserBloc();

  // For refresher
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    UserModel? user = await checkAuthenticated();

    if (user != null) {
      // Declare notifier
      final UserDataNotifier userDataNotifier =
          Provider.of<UserDataNotifier>(context, listen: false);
      // Set to the notifier
      userDataNotifier.setUserData(user);
    }
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  Future<UserModel?> checkAuthenticated() async {
    //get data from secure storage
    try {
      final UserResponseModel userResponseModel = await userBloc.me(context);
      if (userResponseModel.data != null) {
        //save in secured storage
        await SecureStorageApi.saveObject("user", userResponseModel.data!);
        //save in GetIt
        UserResource.setGetIt(userResponseModel.data!);

        return userResponseModel.data!;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

// Get user details
  Future<UserModel?> getUserDetails() async {
    //return this._memoizer.runOnce((user) async {
    // Means no argument passed to this interface, so current user profile
    // Get from getit current user data
    UserModel user = GetIt.instance.get<UserModel>();
    if (user.id != null) {
      return user;
    } else {
      return await checkAuthenticated();
    }
  }

  @override
  void initState() {
    super.initState();
    _userModel = getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SmartRefresher(
        controller: _refreshController,
        header: WaterDropMaterialHeader(),
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child:
              // Use the user data notifier
              Consumer<UserDataNotifier>(
                  builder: (context, userDataNotifier, _) {
            // If the user data in the notifier is not null
            if (userDataNotifier.user != null) {
              // Show UI using the data in the notifier
              return Body(
                userModel: userDataNotifier.user!,
              );
              // Else try to get the data from shared preferences the show the UI
            } else {
              return FutureBuilder(
                  future: _userModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      // Set to the user data notifier
                      userDataNotifier.setUserData(snapshot.data);
                      // return UI
                      return Body(
                        userModel: snapshot.data!,
                      );
                    } else {
                      // Show loading
                      return Center(
                        child: ThemeSpinner.spinner(),
                      );
                    }
                  });
            }
          }),
        ),
      ),
    );
  }
}
