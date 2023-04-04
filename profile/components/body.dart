import 'package:auf/bloc/user_bloc.dart';
import 'package:auf/constant.dart';
import 'package:auf/models/user/user_model.dart';
import 'package:auf/public_components/button_logout.dart';
import 'package:auf/public_components/custom_dialog.dart';
import 'package:auf/public_components/space.dart';
import 'package:auf/public_components/theme_snack_bar.dart';
import 'package:auf/public_components/theme_spinner.dart';
import 'package:auf/screens/delete_account/delete_account_screen.dart';
import 'package:auf/screens/profile/components/view_profile_picture.dart';
import 'package:auf/screens/profile/edit_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:package_info/package_info.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserModel userModel;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // late PackageInfo packageInfo;
  // String version = "";

  // getVersion() async {
  //   packageInfo = await PackageInfo.fromPlatform();
  //   return packageInfo.version;
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50),
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: kPrimaryGradientColor,
              ),
            ),
            Positioned(
              top: 85,
              left: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100,
                  child: widget.userModel.profilePhoto == null
                      //If no profile picture
                      ? Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.black.withOpacity(0.23),
                                width: 2),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black.withOpacity(0.23),
                            size: 50,
                          ),
                        )
                      //If profile picture has been uploaded
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewProfilePicture(
                                  profilePhoto: widget.userModel.profilePhoto!,
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'editprofile',
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              // child: Hero(
                              // tag: 'editprofile',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(150),
                                child: Image.network(
                                  widget.userModel.profilePhoto!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            Positioned(
              top: 160,
              right: 20,
              child: ScaleTap(
                enableFeedback: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(
                        userModel: widget.userModel,
                      ),
                    ),
                  );
                },
                child: Container(
                  //margin: EdgeInsets.only(top: 80, left: 250),
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: kWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Space(10),
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            ProfileDetails(
              title: "Hero Code",
              details: widget.userModel.code!,
            ),
            ScaleTap(
              enableFeedback: true,
              onPressed: () async {
                ClipboardData data =
                    ClipboardData(text: widget.userModel.code!);
                await Clipboard.setData(data);

                ThemeSnackBar.showSnackBar(
                    context, "Hero code copied to clipboard");
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                decoration: BoxDecoration(),
                child: Icon(
                  Iconsax.copy,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
        ProfileDetails(
          title: "Full Name",
          details: widget.userModel.fullname!,
        ),
        ProfileDetails(
          title: "Gender",
          details: widget.userModel.gender!,
        ),
        ProfileDetails(
          title: "Identity Card No.",
          details: widget.userModel.icNo!,
        ),
        ProfileDetails(
          title: "Email",
          details: widget.userModel.email!,
        ),
        ProfileDetails(
          title: "Phone",
          details: widget.userModel.phoneNo!,
        ),
        ProfileDetails(
          title: "Address",
          details: widget.userModel.address!,
        ),
        ProfileDetails(
          title: "State",
          details: widget.userModel.worldDivision!,
        ),
        //  ProfileDetails(
        //   title: "Group",
        //   details: userModel.,
        // ),
        ProfileDetails(
          title: "Bank",
          details: widget.userModel.bankModel!.name!,
        ),
        ProfileDetails(
          title: "Bank Account No",
          details: widget.userModel.accountNumber!,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            children: [
              ButtonLogout("Logout", primaryColor: Colors.red,
                  onPressed: () async {
                UserBloc userBloc = UserBloc();
                CustomDialog.show(context,
                    dismissOnTouchOutside: false,
                    description: "Log you out...",
                    center: ThemeSpinner.spinner());
                await userBloc.signOut(context);

                // LoadingDialog.hide(context);
              }),
              const SizedBox(height: 10),
              ButtonLogout(
                "Delete Account",
                icon: Icons.delete_forever_outlined,
                primaryColor: Colors.red[900],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeleteAccount(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              const Text(
                version,
                style: TextStyle(color: kGrey, fontSize: 10),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileDetails extends StatelessWidget {
  final String title;
  final String details;
  const ProfileDetails({
    super.key,
    required this.title,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 247, 247, 247),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(details)
        ],
      ),
    );
  }
}
