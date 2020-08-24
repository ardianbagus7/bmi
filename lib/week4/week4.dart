
import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udacoding_bootcamp/cores/cores.dart';
import 'package:udacoding_bootcamp/week2/week2.dart';

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