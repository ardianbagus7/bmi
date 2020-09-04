
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udacoding_bootcamp/cores/cores.dart';
import 'package:udacoding_bootcamp/week2/week2.dart';
import 'package:intl/intl.dart' as intl;
import 'package:photo_view/photo_view.dart';

part 'notes/ui/main_week4.dart';
part 'notes/ui/home_page.dart';
part 'notes/ui/profil_page.dart';
part 'notes/ui/detail_note_page.dart';
part 'notes/ui/create_note_page.dart';
part 'notes/model/user_model.dart';
part 'notes/repository/auth_repository.dart';
part 'notes/repository/note_repository.dart';
part 'notes/ui/auth_pages.dart';
part 'notes/provider/auth_provider.dart';
part 'notes/provider/note_provider.dart';
part 'notes/repository/auth_local_repository.dart';
part 'notes/model/note_model.dart';

part 'e_commerce/ui/main_marketplace.dart';
part 'e_commerce/ui/home_page_marketplace.dart';
part 'e_commerce/ui/detail_page_marketplace.dart';
part 'e_commerce/widget/kategori_list_view_marketplace.dart';
part 'e_commerce/model/marketplace_model.dart';
part 'e_commerce/repository/marketplace_repository.dart';
part 'e_commerce/provider/marketplace_provider.dart';
part 'e_commerce/widget/star.dart';
part 'e_commerce/ui/onboarding_page.dart';

part 'galery/home_page.dart';
part 'galery/detail_image_page.dart';