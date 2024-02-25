# Details

Date : 2024-02-25 16:09:49

Directory c:\\Users\\adria\\Documents\\DHBW\\Studienarbeit\\DUO

Total : 129 files,  6260 codes, 681 comments, 1136 blanks, all 8077 lines

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [Makefile](/Makefile) | Makefile | 14 | 0 | 5 | 19 |
| [README.md](/README.md) | Markdown | 2 | 0 | 1 | 3 |
| [duo_backend/Dockerfile](/duo_backend/Dockerfile) | Docker | 11 | 0 | 12 | 23 |
| [duo_backend/Makefile](/duo_backend/Makefile) | Makefile | 29 | 0 | 12 | 41 |
| [duo_backend/ReadMe.md](/duo_backend/ReadMe.md) | Markdown | 4 | 0 | 1 | 5 |
| [duo_backend/api/auth_routes.go](/duo_backend/api/auth_routes.go) | Go | 103 | 1 | 17 | 121 |
| [duo_backend/api/server.go](/duo_backend/api/server.go) | Go | 32 | 0 | 8 | 40 |
| [duo_backend/api/session_manager.go](/duo_backend/api/session_manager.go) | Go | 168 | 12 | 43 | 223 |
| [duo_backend/api/session_routes.go](/duo_backend/api/session_routes.go) | Go | 51 | 0 | 15 | 66 |
| [duo_backend/app.env](/duo_backend/app.env) | Environment Variables | 5 | 0 | 0 | 5 |
| [duo_backend/db.env](/duo_backend/db.env) | Environment Variables | 3 | 0 | 0 | 3 |
| [duo_backend/db/migration/000001_user.down.sql](/duo_backend/db/migration/000001_user.down.sql) | SQL | 8 | 0 | 3 | 11 |
| [duo_backend/db/migration/000001_user.up.sql](/duo_backend/db/migration/000001_user.up.sql) | SQL | 20 | 0 | 5 | 25 |
| [duo_backend/db/migration/000002_session.down.sql](/duo_backend/db/migration/000002_session.down.sql) | SQL | 1 | 0 | 0 | 1 |
| [duo_backend/db/migration/000002_session.up.sql](/duo_backend/db/migration/000002_session.up.sql) | SQL | 8 | 0 | 1 | 9 |
| [duo_backend/db/query/session.sql](/duo_backend/db/query/session.sql) | SQL | 4 | 4 | 3 | 11 |
| [duo_backend/db/query/user.sql](/duo_backend/db/query/user.sql) | SQL | 5 | 5 | 4 | 14 |
| [duo_backend/db/sqlc/db.go](/duo_backend/db/sqlc/db.go) | Go | 22 | 3 | 7 | 32 |
| [duo_backend/db/sqlc/models.go](/duo_backend/db/sqlc/models.go) | Go | 21 | 3 | 7 | 31 |
| [duo_backend/db/sqlc/querier.go](/duo_backend/db/sqlc/querier.go) | Go | 17 | 3 | 6 | 26 |
| [duo_backend/db/sqlc/session.sql.go](/duo_backend/db/sqlc/session.sql.go) | Go | 66 | 4 | 13 | 83 |
| [duo_backend/db/sqlc/store.go](/duo_backend/db/sqlc/store.go) | Go | 37 | 0 | 8 | 45 |
| [duo_backend/db/sqlc/user.sql.go](/duo_backend/db/sqlc/user.sql.go) | Go | 58 | 4 | 16 | 78 |
| [duo_backend/docker-compose.yml](/duo_backend/docker-compose.yml) | YAML | 24 | 0 | 1 | 25 |
| [duo_backend/go.mod](/duo_backend/go.mod) | Go Module File | 42 | 0 | 3 | 45 |
| [duo_backend/go.sum](/duo_backend/go.sum) | Go Checksum File | 98 | 0 | 1 | 99 |
| [duo_backend/main.go](/duo_backend/main.go) | Go | 44 | 1 | 12 | 57 |
| [duo_backend/pb/auth_messages.pb.go](/duo_backend/pb/auth_messages.pb.go) | Go | 430 | 13 | 62 | 505 |
| [duo_backend/pb/duo_service.pb.go](/duo_backend/pb/duo_service.pb.go) | Go | 106 | 7 | 8 | 121 |
| [duo_backend/pb/duo_service_grpc.pb.go](/duo_backend/pb/duo_service_grpc.pb.go) | Go | 262 | 21 | 31 | 314 |
| [duo_backend/pb/session_messages.pb.go](/duo_backend/pb/session_messages.pb.go) | Go | 641 | 16 | 91 | 748 |
| [duo_backend/pb/void.pb.go](/duo_backend/pb/void.pb.go) | Go | 108 | 8 | 16 | 132 |
| [duo_backend/sqlc.yaml](/duo_backend/sqlc.yaml) | YAML | 10 | 0 | 0 | 10 |
| [duo_backend/token/maker.go](/duo_backend/token/maker.go) | Go | 9 | 0 | 4 | 13 |
| [duo_backend/token/paseto_maker.go](/duo_backend/token/paseto_maker.go) | Go | 42 | 0 | 12 | 54 |
| [duo_backend/token/paseto_maker_test.go](/duo_backend/token/paseto_maker_test.go) | Go | 38 | 0 | 12 | 50 |
| [duo_backend/token/payload.go](/duo_backend/token/payload.go) | Go | 35 | 0 | 9 | 44 |
| [duo_backend/util/challenge.go](/duo_backend/util/challenge.go) | Go | 34 | 2 | 6 | 42 |
| [duo_backend/util/config.go](/duo_backend/util/config.go) | Go | 27 | 0 | 8 | 35 |
| [duo_backend/util/random.go](/duo_backend/util/random.go) | Go | 42 | 0 | 11 | 53 |
| [duo_client/README.md](/duo_client/README.md) | Markdown | 10 | 0 | 7 | 17 |
| [duo_client/analysis_options.yaml](/duo_client/analysis_options.yaml) | YAML | 3 | 22 | 4 | 29 |
| [duo_client/android/app/build.gradle](/duo_client/android/app/build.gradle) | Groovy | 51 | 5 | 12 | 68 |
| [duo_client/android/app/src/debug/AndroidManifest.xml](/duo_client/android/app/src/debug/AndroidManifest.xml) | XML | 3 | 4 | 1 | 8 |
| [duo_client/android/app/src/main/AndroidManifest.xml](/duo_client/android/app/src/main/AndroidManifest.xml) | XML | 27 | 6 | 1 | 34 |
| [duo_client/android/app/src/main/res/drawable-v21/launch_background.xml](/duo_client/android/app/src/main/res/drawable-v21/launch_background.xml) | XML | 4 | 7 | 2 | 13 |
| [duo_client/android/app/src/main/res/drawable/launch_background.xml](/duo_client/android/app/src/main/res/drawable/launch_background.xml) | XML | 4 | 7 | 2 | 13 |
| [duo_client/android/app/src/main/res/values-night/styles.xml](/duo_client/android/app/src/main/res/values-night/styles.xml) | XML | 9 | 9 | 1 | 19 |
| [duo_client/android/app/src/main/res/values/styles.xml](/duo_client/android/app/src/main/res/values/styles.xml) | XML | 9 | 9 | 1 | 19 |
| [duo_client/android/app/src/profile/AndroidManifest.xml](/duo_client/android/app/src/profile/AndroidManifest.xml) | XML | 3 | 4 | 1 | 8 |
| [duo_client/android/build.gradle](/duo_client/android/build.gradle) | Groovy | 26 | 0 | 5 | 31 |
| [duo_client/android/gradle.properties](/duo_client/android/gradle.properties) | Properties | 3 | 0 | 1 | 4 |
| [duo_client/android/gradle/wrapper/gradle-wrapper.properties](/duo_client/android/gradle/wrapper/gradle-wrapper.properties) | Properties | 5 | 0 | 1 | 6 |
| [duo_client/android/settings.gradle](/duo_client/android/settings.gradle) | Groovy | 24 | 0 | 6 | 30 |
| [duo_client/ios/Flutter/AppFrameworkInfo.plist](/duo_client/ios/Flutter/AppFrameworkInfo.plist) | XML | 26 | 0 | 1 | 27 |
| [duo_client/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist](/duo_client/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist) | XML | 8 | 0 | 1 | 9 |
| [duo_client/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist](/duo_client/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist) | XML | 8 | 0 | 1 | 9 |
| [duo_client/ios/RunnerTests/RunnerTests.swift](/duo_client/ios/RunnerTests/RunnerTests.swift) | Swift | 7 | 2 | 4 | 13 |
| [duo_client/ios/Runner/AppDelegate.swift](/duo_client/ios/Runner/AppDelegate.swift) | Swift | 12 | 0 | 2 | 14 |
| [duo_client/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json](/duo_client/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json) | JSON | 122 | 0 | 1 | 123 |
| [duo_client/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json](/duo_client/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json) | JSON | 23 | 0 | 1 | 24 |
| [duo_client/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md](/duo_client/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md) | Markdown | 3 | 0 | 2 | 5 |
| [duo_client/ios/Runner/Base.lproj/LaunchScreen.storyboard](/duo_client/ios/Runner/Base.lproj/LaunchScreen.storyboard) | XML | 36 | 1 | 1 | 38 |
| [duo_client/ios/Runner/Base.lproj/Main.storyboard](/duo_client/ios/Runner/Base.lproj/Main.storyboard) | XML | 25 | 1 | 1 | 27 |
| [duo_client/ios/Runner/Info.plist](/duo_client/ios/Runner/Info.plist) | XML | 49 | 0 | 1 | 50 |
| [duo_client/ios/Runner/Runner-Bridging-Header.h](/duo_client/ios/Runner/Runner-Bridging-Header.h) | C++ | 1 | 0 | 1 | 2 |
| [duo_client/lib/main.dart](/duo_client/lib/main.dart) | Dart | 31 | 0 | 4 | 35 |
| [duo_client/lib/pb/auth_messages.pb.dart](/duo_client/lib/pb/auth_messages.pb.dart) | Dart | 323 | 9 | 47 | 379 |
| [duo_client/lib/pb/auth_messages.pbenum.dart](/duo_client/lib/pb/auth_messages.pbenum.dart) | Dart | 0 | 9 | 3 | 12 |
| [duo_client/lib/pb/auth_messages.pbjson.dart](/duo_client/lib/pb/auth_messages.pbjson.dart) | Dart | 65 | 15 | 16 | 96 |
| [duo_client/lib/pb/duo_service.pb.dart](/duo_client/lib/pb/duo_service.pb.dart) | Dart | 1 | 9 | 4 | 14 |
| [duo_client/lib/pb/duo_service.pbenum.dart](/duo_client/lib/pb/duo_service.pbenum.dart) | Dart | 0 | 9 | 3 | 12 |
| [duo_client/lib/pb/duo_service.pbgrpc.dart](/duo_client/lib/pb/duo_service.pbgrpc.dart) | Dart | 129 | 9 | 23 | 161 |
| [duo_client/lib/pb/duo_service.pbjson.dart](/duo_client/lib/pb/duo_service.pbjson.dart) | Dart | 3 | 9 | 4 | 16 |
| [duo_client/lib/pb/google/protobuf/timestamp.pb.dart](/duo_client/lib/pb/google/protobuf/timestamp.pb.dart) | Dart | 68 | 110 | 13 | 191 |
| [duo_client/lib/pb/google/protobuf/timestamp.pbenum.dart](/duo_client/lib/pb/google/protobuf/timestamp.pbenum.dart) | Dart | 0 | 9 | 3 | 12 |
| [duo_client/lib/pb/google/protobuf/timestamp.pbjson.dart](/duo_client/lib/pb/google/protobuf/timestamp.pbjson.dart) | Dart | 14 | 10 | 6 | 30 |
| [duo_client/lib/pb/session_messages.pb.dart](/duo_client/lib/pb/session_messages.pb.dart) | Dart | 524 | 9 | 70 | 603 |
| [duo_client/lib/pb/session_messages.pbenum.dart](/duo_client/lib/pb/session_messages.pbenum.dart) | Dart | 0 | 9 | 3 | 12 |
| [duo_client/lib/pb/session_messages.pbjson.dart](/duo_client/lib/pb/session_messages.pbjson.dart) | Dart | 100 | 18 | 22 | 140 |
| [duo_client/lib/pb/void.pb.dart](/duo_client/lib/pb/void.pb.dart) | Dart | 30 | 9 | 11 | 50 |
| [duo_client/lib/pb/void.pbenum.dart](/duo_client/lib/pb/void.pbenum.dart) | Dart | 0 | 9 | 3 | 12 |
| [duo_client/lib/pb/void.pbjson.dart](/duo_client/lib/pb/void.pbjson.dart) | Dart | 9 | 10 | 6 | 25 |
| [duo_client/lib/provider/api_provider.dart](/duo_client/lib/provider/api_provider.dart) | Dart | 24 | 0 | 6 | 30 |
| [duo_client/lib/provider/game_state_provider.dart](/duo_client/lib/provider/game_state_provider.dart) | Dart | 8 | 0 | 3 | 11 |
| [duo_client/lib/provider/storage_provider.dart](/duo_client/lib/provider/storage_provider.dart) | Dart | 22 | 0 | 6 | 28 |
| [duo_client/lib/screens/login_screen.dart](/duo_client/lib/screens/login_screen.dart) | Dart | 51 | 0 | 4 | 55 |
| [duo_client/lib/screens/registration_screen.dart](/duo_client/lib/screens/registration_screen.dart) | Dart | 67 | 0 | 5 | 72 |
| [duo_client/lib/screens/session_test_screen.dart](/duo_client/lib/screens/session_test_screen.dart) | Dart | 97 | 5 | 7 | 109 |
| [duo_client/lib/screens/start_screen.dart](/duo_client/lib/screens/start_screen.dart) | Dart | 62 | 0 | 7 | 69 |
| [duo_client/lib/utils/connection/abstract_connection.dart](/duo_client/lib/utils/connection/abstract_connection.dart) | Dart | 9 | 0 | 2 | 11 |
| [duo_client/lib/utils/connection/grpc_server_connection.dart](/duo_client/lib/utils/connection/grpc_server_connection.dart) | Dart | 129 | 13 | 25 | 167 |
| [duo_client/lib/utils/constants.dart](/duo_client/lib/utils/constants.dart) | Dart | 5 | 1 | 1 | 7 |
| [duo_client/lib/utils/encryption/encryption_handler.dart](/duo_client/lib/utils/encryption/encryption_handler.dart) | Dart | 29 | 3 | 10 | 42 |
| [duo_client/linux/flutter/generated_plugin_registrant.cc](/duo_client/linux/flutter/generated_plugin_registrant.cc) | C++ | 7 | 4 | 5 | 16 |
| [duo_client/linux/flutter/generated_plugin_registrant.h](/duo_client/linux/flutter/generated_plugin_registrant.h) | C++ | 5 | 5 | 6 | 16 |
| [duo_client/linux/flutter/generated_plugins.cmake](/duo_client/linux/flutter/generated_plugins.cmake) | CMake | 19 | 0 | 6 | 25 |
| [duo_client/linux/main.cc](/duo_client/linux/main.cc) | C++ | 5 | 0 | 2 | 7 |
| [duo_client/linux/my_application.cc](/duo_client/linux/my_application.cc) | C++ | 74 | 11 | 20 | 105 |
| [duo_client/linux/my_application.h](/duo_client/linux/my_application.h) | C++ | 7 | 7 | 5 | 19 |
| [duo_client/macos/Flutter/GeneratedPluginRegistrant.swift](/duo_client/macos/Flutter/GeneratedPluginRegistrant.swift) | Swift | 8 | 3 | 4 | 15 |
| [duo_client/macos/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist](/duo_client/macos/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist) | XML | 8 | 0 | 1 | 9 |
| [duo_client/macos/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist](/duo_client/macos/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist) | XML | 8 | 0 | 1 | 9 |
| [duo_client/macos/RunnerTests/RunnerTests.swift](/duo_client/macos/RunnerTests/RunnerTests.swift) | Swift | 7 | 2 | 4 | 13 |
| [duo_client/macos/Runner/AppDelegate.swift](/duo_client/macos/Runner/AppDelegate.swift) | Swift | 8 | 0 | 2 | 10 |
| [duo_client/macos/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json](/duo_client/macos/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json) | JSON | 68 | 0 | 1 | 69 |
| [duo_client/macos/Runner/Base.lproj/MainMenu.xib](/duo_client/macos/Runner/Base.lproj/MainMenu.xib) | XML | 343 | 0 | 1 | 344 |
| [duo_client/macos/Runner/Info.plist](/duo_client/macos/Runner/Info.plist) | XML | 32 | 0 | 1 | 33 |
| [duo_client/macos/Runner/MainFlutterWindow.swift](/duo_client/macos/Runner/MainFlutterWindow.swift) | Swift | 12 | 0 | 4 | 16 |
| [duo_client/pubspec.yaml](/duo_client/pubspec.yaml) | YAML | 26 | 60 | 17 | 103 |
| [duo_client/test/widget_test.dart](/duo_client/test/widget_test.dart) | Dart | 14 | 10 | 7 | 31 |
| [duo_client/web/index.html](/duo_client/web/index.html) | HTML | 38 | 16 | 6 | 60 |
| [duo_client/web/manifest.json](/duo_client/web/manifest.json) | JSON | 35 | 0 | 1 | 36 |
| [duo_client/windows/flutter/generated_plugin_registrant.cc](/duo_client/windows/flutter/generated_plugin_registrant.cc) | C++ | 6 | 4 | 5 | 15 |
| [duo_client/windows/flutter/generated_plugin_registrant.h](/duo_client/windows/flutter/generated_plugin_registrant.h) | C++ | 5 | 5 | 6 | 16 |
| [duo_client/windows/flutter/generated_plugins.cmake](/duo_client/windows/flutter/generated_plugins.cmake) | CMake | 19 | 0 | 6 | 25 |
| [duo_client/windows/runner/flutter_window.cpp](/duo_client/windows/runner/flutter_window.cpp) | C++ | 49 | 7 | 16 | 72 |
| [duo_client/windows/runner/flutter_window.h](/duo_client/windows/runner/flutter_window.h) | C++ | 20 | 5 | 9 | 34 |
| [duo_client/windows/runner/main.cpp](/duo_client/windows/runner/main.cpp) | C++ | 30 | 4 | 10 | 44 |
| [duo_client/windows/runner/resource.h](/duo_client/windows/runner/resource.h) | C++ | 9 | 6 | 2 | 17 |
| [duo_client/windows/runner/utils.cpp](/duo_client/windows/runner/utils.cpp) | C++ | 54 | 2 | 10 | 66 |
| [duo_client/windows/runner/utils.h](/duo_client/windows/runner/utils.h) | C++ | 8 | 6 | 6 | 20 |
| [duo_client/windows/runner/win32_window.cpp](/duo_client/windows/runner/win32_window.cpp) | C++ | 210 | 24 | 55 | 289 |
| [duo_client/windows/runner/win32_window.h](/duo_client/windows/runner/win32_window.h) | C++ | 48 | 31 | 24 | 103 |
| [helpers/protoc.dockerfile](/helpers/protoc.dockerfile) | Docker | 12 | 1 | 5 | 18 |
| [proto/auth_messages.proto](/proto/auth_messages.proto) | Protocol Buffers | 26 | 0 | 11 | 37 |
| [proto/duo_service.proto](/proto/duo_service.proto) | Protocol Buffers | 14 | 0 | 8 | 22 |
| [proto/session_messages.proto](/proto/session_messages.proto) | Protocol Buffers | 40 | 0 | 12 | 52 |
| [proto/void.proto](/proto/void.proto) | Protocol Buffers | 4 | 0 | 4 | 8 |

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)