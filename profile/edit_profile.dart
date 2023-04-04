import 'dart:io';

import 'package:auf/constant.dart';
import 'package:auf/form_bloc/edit_profile_form_bloc.dart';
import 'package:auf/helpers/general_method.dart';
import 'package:auf/helpers/http_response.dart';
import 'package:auf/models/default_response_model.dart';
import 'package:auf/models/user/bank_model.dart';
import 'package:auf/models/user/edit_profile_request_model.dart';
import 'package:auf/models/user/state_model.dart';
import 'package:auf/models/user/title_model.dart';
import 'package:auf/models/user/user_model.dart';
import 'package:auf/models/user/user_response_model.dart';
import 'package:auf/providers/user_data_notifier.dart';
import 'package:auf/public_components/button_primary.dart';
import 'package:auf/public_components/input_decoration.dart';
import 'package:auf/public_components/theme_snack_bar.dart';
import 'package:auf/public_components/theme_spinner.dart';
import 'package:auf/screens/navigation_bar/navigation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final UserModel userModel;
  const EditProfile({super.key, required this.userModel});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<Media> temp = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        //Appbar
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        //Content
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (context) => EditProfileFormBloc(widget.userModel),
              child: Builder(
                builder: (context) {
                  final EditProfileFormBloc formBloc =
                      BlocProvider.of<EditProfileFormBloc>(context);
                  return FormBlocListener<EditProfileFormBloc, UserModel,
                      UserResponseModel>(
                    // On submit
                    onSubmitting: (context, state) {
                      // Remove focus from input field
                      FocusScope.of(context).unfocus();
                      // Set loading true
                      setState(() {
                        _isLoading = true;
                      });
                    },
                    onSuccess: (context, state) {
                      // Set loading false
                      setState(() {
                        _isLoading = false;
                      });

                      // Declare notifier
                      final UserDataNotifier userDataNotifier =
                          Provider.of<UserDataNotifier>(context, listen: false);
                      // Set to the notifier
                      userDataNotifier.setUserData(state.successResponse!);

                      // Navigate to profile screen
                      Navigator.of(context).pop();
                    },
                    // Validation failed
                    onSubmissionFailed: (context, state) {
                      // Set loading false
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    onFailure: (context, state) {
                      // Set loading to false
                      setState(() {
                        _isLoading = false;
                      });

                      // if (state.failureResponse != null) {
                      //   if (state.failureResponse!.statusCode !=
                      //       HttpResponse.HTTP_UNAUTHORIZED) {
                      //     //Set data
                      //     UserModel userModel = new UserModel();
                      //     userModel.email = formBloc.email.value;
                      //     // Hide current snackbar
                      //     ScaffoldMessenger.of(context)
                      //         .hideCurrentSnackBar();

                      //   }
                      // }

                      ThemeSnackBar.showSnackBar(context,
                          state.failureResponse?.message ?? "Server error");
                      return;
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(150.0),
                          child: ScaleTap(
                            onPressed: () {},
                            child: Stack(children: [
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(100),
                              //   child: Container(
                              //     height: 130,
                              //     width: 130,
                              //     child: formBloc.newPhoto == null
                              //         ? CachedNetworkImage(
                              //             fit: BoxFit.cover,
                              //             imageUrl: widget.userModel.thumbnail!,
                              //             progressIndicatorBuilder:
                              //                 (context, url, downloadProgress) {
                              //               return ThemeSpinner.spinner();
                              //             },
                              //           )
                              //         : Image.file(
                              //             File(formBloc.newPhoto!.path!),
                              //             fit: BoxFit.cover,
                              //           ),
                              //   ),
                              // ),
                              formBloc.newPhoto == null
                                  //If no profile pic
                                  ? Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(150),
                                      ),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: widget.userModel.thumbnail!,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) {
                                          return ThemeSpinner.spinner();
                                        },
                                      ),
                                    )
                                  //If profile pic available
                                  : Hero(
                                      tag: 'editprofile',
                                      child: Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 0),
                                        ),
                                        // child: Hero(
                                        // tag: 'editprofile',
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(150),
                                          child: Image.file(
                                            File(formBloc.newPhoto!.path!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        // ),
                                      ),
                                    ),
                              Positioned(
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: () async {
                                    temp = (await selectImages())!;
                                    await setImageToCircle(temp, formBloc);
                                    print("edit photo");
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    color: Colors.grey.withOpacity(0.4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.file_upload_outlined,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Upload",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        Column(
                          children: [
                            DropdownFieldBlocBuilder<TitleModel>(
                              showEmptyItem: false,
                              selectFieldBloc: formBloc.title,
                              itemBuilder: (context, itemData) => FieldItem(
                                child: DropdownMenuItem(
                                  value: itemData.id,
                                  child: Text(itemData.title!),
                                ),
                              ),
                              decoration: textFieldInputDecoration(
                                "Title",
                                prefixIcon: Icon(
                                  Iconsax.user,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            TextFieldBlocBuilder(
                              textFieldBloc: formBloc.newName,
                              cursorColor: kPrimaryColor,
                              textCapitalization: TextCapitalization.none,
                              decoration: textFieldInputDecoration(
                                "Name",
                                hintText: "ex: Izzat Rizal",
                                prefixIcon: const Icon(
                                  Iconsax.sms,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            TextFieldBlocBuilder(
                              textFieldBloc: formBloc.phoneNo,
                              cursorColor: kPrimaryColor,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: textFieldInputDecoration(
                                "Phone No",
                                hintText: "ex: 01356897856",
                                prefixIcon: const Icon(
                                  Iconsax.call,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            TextFieldBlocBuilder(
                              textFieldBloc: formBloc.newAddress,
                              cursorColor: kPrimaryColor,
                              minLines: 1,
                              maxLines: 5,
                              decoration: textFieldInputDecoration(
                                "Address",
                                hintText: "ex: Lot 15, Kampung AUF, 16400",
                                prefixIcon: Icon(
                                  Iconsax.location,
                                  color: kPrimaryColor,
                                ),
                                //   child: ClipRRect(
                                //     borderRadius: BorderRadius.circular(150),
                                //     child: Image.network(
                                //       widget.userModel.profilePhoto!,
                                //       fit: BoxFit.cover,
                                //     ),
                                //   ),
                              ),
                            ),
                            DropdownFieldBlocBuilder<DivisionModel>(
                              showEmptyItem: false,
                              selectFieldBloc: formBloc.division,
                              itemBuilder: (context, itemData) => FieldItem(
                                child: DropdownMenuItem(
                                  value: itemData.id,
                                  child: Text(itemData.name!),
                                ),
                              ),
                              decoration: textFieldInputDecoration(
                                "State",
                                prefixIcon: Icon(
                                  FontAwesomeIcons.mapPin,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ButtonPrimary(
                              "Save", onPressed: () => formBloc.submit(),
                              loadingText: "Saving...",
                              isLoading: _isLoading,
                              //Navigator.pop(context);
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> setImageToCircle(
      List<Media> temp, EditProfileFormBloc formBloc) async {
    setState(() {
      // Add to the model
      formBloc.newPhoto = temp[0];
      // trigger parent widget to update the next button
      // widget.onSelectImage(widget.postRequestModel);
    });
  }

  Future<List<Media>?> selectImages() async {
    try {
      return await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        showGif: false,
        showCamera: true,
        // Disable crop
        cropConfig: CropConfig(enableCrop: false),
        // Limit the size to 2048
        compressSize: 2048,
        uiConfig: UIConfig(
          uiThemeColor: kPrimaryLightColor,
        ),
      );
    } on PlatformException {
      return null;
    }
  }
}
