INSERT INTO user_role (role_id, name, permission_level) VALUES ('65b0075f662329afe4bb3e6b73a3eecf', 'Admin', 1);
INSERT INTO user_role (role_id, name, permission_level) VALUES ('9cef3e32f0b60dd45e75b4eb6ebca17b', 'Coordinator', 2);
INSERT INTO user_role (role_id, name, permission_level) VALUES ('3071704b1cbf8abc1cc0b072dadec49b', 'Faculty', 2);
INSERT INTO user_role (role_id, name, permission_level) VALUES ('581c16c93e573343963815258c7c91f9', 'Student', 3);

INSERT INTO app_user (user_id, first_name, last_name, email, role_id, password) VALUES ('8b72105565441d6e547b6193cf9782b4', 'Administrator', '', 'admin', '65b0075f662329afe4bb3e6b73a3eecf', '8KZdhebgZAkZ/wnHfFVwx81LDJoQTQjRn1sviayhWw0=$U5+nBQFW1r96veavMNnDvl5G3ALJyY2tuNTuBy/oA9Q=');

INSERT INTO building (building_id, created_by, name) VALUES ('73285e99115b46958da135cdc87e5979', '8b72105565441d6e547b6193cf9782b4', 'Administration');
INSERT INTO building (building_id, created_by, name) VALUES ('361f42d188854f4faecc8f7313bd9053', '8b72105565441d6e547b6193cf9782b4', 'McGowan');
INSERT INTO building (building_id, created_by, name) VALUES ('437364cf50994316b66aff02a14b38ca', '8b72105565441d6e547b6193cf9782b4', 'Holy Cross');

INSERT INTO building_coordinate (coordinate_id, coordinate_data, building_id) VALUES ('ddb656bf7f7643a588cc7ce1383a771d', '"{\"type\":\"FeatureCollection\",\"features\":[{\"type\":\"Feature\",\"geometry\":{\"type\":\"Polygon\",\"coordinates\":[[[-8446933.521771798,5049316.046571197],[-8446909.138414914,5049283.497014376],[-8446900.774058463,5049273.995947136],[-8446880.268458366,5049289.703013803],[-8446911.591175789,5049331.528724969],[-8446933.521771798,5049316.046571197]]]},\"properties\":null}]}"', '73285e99115b46958da135cdc87e5979');
INSERT INTO building_coordinate (coordinate_id, coordinate_data, building_id) VALUES ('cd1c46d6f4854ef19246f16af62e4bf6', '"{\"type\":\"FeatureCollection\",\"features\":[{\"type\":\"Feature\",\"geometry\":{\"type\":\"Polygon\",\"coordinates\":[[[-8446963.698534664,5049213.488995077],[-8446941.744568048,5049229.249557793],[-8446953.796394216,5049245.941900484],[-8446949.8529061,5049253.171175872],[-8446935.118684333,5049263.379210815],[-8446954.856229238,5049290.93379666],[-8446974.557279576,5049276.519838015],[-8446980.416161507,5049284.397927668],[-8447002.998708887,5049267.612085324],[-8446963.698534664,5049213.488995077]]]},\"properties\":null}]}"', '361f42d188854f4faecc8f7313bd9053');
INSERT INTO building_coordinate (coordinate_id, coordinate_data, building_id) VALUES ('f8a92fc04ee74945af193f4243420f3c', '"{\"type\":\"FeatureCollection\",\"features\":[{\"type\":\"Feature\",\"geometry\":{\"type\":\"Polygon\",\"coordinates\":[[[-8447002.285586065,5049267.42088277],[-8446963.160327425,5049214.283873965],[-8446928.3826528,5049205.5484992005],[-8446941.237116456,5049229.835559354],[-8446953.171269117,5049245.890968572],[-8446951.351579137,5049252.452020467],[-8446935.775435865,5049264.029929765],[-8446955.067676567,5049290.985433176],[-8446974.656069092,5049276.797209947],[-8446980.712206265,5049284.944731043],[-8447002.285586065,5049267.42088277]]]},\"properties\":null}]}"', '437364cf50994316b66aff02a14b38ca');

INSERT INTO category (category_id, name) VALUES ('faceb0ab63bd4ff69fe69b551133bce8', 'Test2');
INSERT INTO category (category_id, name) VALUES ('4bdd0ad8c4d0461cba5b727050807ad3', 'Edit2');

INSERT INTO floor (floor_id, building_id, floor_name) VALUES ('96027d0799094e909235693eb83c508c', '361f42d188854f4faecc8f7313bd9053', '1');
INSERT INTO floor (floor_id, building_id, floor_name) VALUES ('29c6a5ea13ac4504b66e1ee858bca028', '73285e99115b46958da135cdc87e5979', '2');
INSERT INTO floor (floor_id, building_id, floor_name) VALUES ('44d282fa701342ccb7c27c9637d4bab4', '437364cf50994316b66aff02a14b38ca', '1');
INSERT INTO floor (floor_id, building_id, floor_name) VALUES ('dfdf5f0aec14490a8f14536856591577', '437364cf50994316b66aff02a14b38ca', '2');

INSERT INTO floor_comment (comment_id, floor_id, comment_msg, created_date, created_by, deleted) VALUES ('0bd66ed456bd42b0bdf6d296a2da1243', '29c6a5ea13ac4504b66e1ee858bca028', 'Test Comment', '2018-04-16 14:26:19.748', '8b72105565441d6e547b6193cf9782b4', 0);
INSERT INTO floor_comment (comment_id, floor_id, comment_msg, created_date, created_by, deleted) VALUES ('61f3af859c39408aa339497fbc93b009', 'dfdf5f0aec14490a8f14536856591577', 'test comment 2', '2018-05-06 23:52:09.769', '8b72105565441d6e547b6193cf9782b4', 0);
INSERT INTO floor_comment (comment_id, floor_id, comment_msg, created_date, created_by, deleted) VALUES ('bfb544e1c16442a494a773b8d119af75', 'dfdf5f0aec14490a8f14536856591577', 'test comment 3', '2018-05-07 00:08:51.077', '8b72105565441d6e547b6193cf9782b4', 0);
INSERT INTO floor_comment (comment_id, floor_id, comment_msg, created_date, created_by, deleted) VALUES ('d0d3b974afcb4422a3807a14b071c7f6', 'dfdf5f0aec14490a8f14536856591577', 'test comment 4', '2018-05-07 20:57:23.315', '8b72105565441d6e547b6193cf9782b4', 0);
INSERT INTO floor_comment (comment_id, floor_id, comment_msg, created_date, created_by, deleted) VALUES ('494c0aba28de4dfc80457a7e7a193d76', 'dfdf5f0aec14490a8f14536856591577', 'test comment 5', '2018-05-08 16:26:01.679', '8b72105565441d6e547b6193cf9782b4', 0);
INSERT INTO floor_comment (comment_id, floor_id, comment_msg, created_date, created_by, deleted) VALUES ('edab6a10ca5e4bd889d61c917fa8abe0', '44d282fa701342ccb7c27c9637d4bab4', 'test comment 6', '2018-05-08 17:08:11.382', '8b72105565441d6e547b6193cf9782b4', 0);

INSERT INTO room (room_id, floor_id, room_name) VALUES ('c8c9b303b7b249c092c57bbf7ddaad73', '29c6a5ea13ac4504b66e1ee858bca028', '100');
INSERT INTO room (room_id, floor_id, room_name) VALUES ('bd9eab399db9481c9765d950a0e257a5', '29c6a5ea13ac4504b66e1ee858bca028', '101');
INSERT INTO room (room_id, floor_id, room_name) VALUES ('db4bd3c4790143d79d78a1a59e957f86', '29c6a5ea13ac4504b66e1ee858bca028', '104');
INSERT INTO room (room_id, floor_id, room_name) VALUES ('84cdc682dff645b28207dbf1fbcbe0d8', '29c6a5ea13ac4504b66e1ee858bca028', '105');
INSERT INTO room (room_id, floor_id, room_name) VALUES ('1bf05038bbc447b4982900d7d3c37d47', '44d282fa701342ccb7c27c9637d4bab4', '100');
INSERT INTO room (room_id, floor_id, room_name) VALUES ('4966481651aa444b95f8553210267bed', 'dfdf5f0aec14490a8f14536856591577', '100');

INSERT INTO room_coordinates (room_id, room_coordinates) VALUES ('4966481651aa444b95f8553210267bed', '"{\"type\":\"Feature\",\"geometry\":{\"type\":\"Polygon\",\"coordinates\":[[[-8446935.666030645,5049262.4657801995],[-8446947.292626845,5049280.6099626925],[-8446965.436809339,5049268.983366492],[-8446953.81021314,5049250.839183999],[-8446935.666030645,5049262.4657801995]]]},\"properties\":null}"');
INSERT INTO room_coordinates (room_id, room_coordinates) VALUES ('bd9eab399db9481c9765d950a0e257a5', '"{\"type\":\"Feature\",\"geometry\":{\"type\":\"Polygon\",\"coordinates\":[[[-8446886.766721489,5049339.726678741],[-8446893.168745117,5049348.571188428],[-8446902.013254805,5049342.1691648],[-8446895.611231176,5049333.324655113],[-8446886.766721489,5049339.726678741]]]},\"properties\":{\"roomId\":\"034b815cc6fb4581aacdce7299ac4200\"}}"');
INSERT INTO room_coordinates (room_id, room_coordinates) VALUES ('db4bd3c4790143d79d78a1a59e957f86', '"{\"type\":\"Feature\",\"geometry\":{\"type\":\"Polygon\",\"coordinates\":[[[-8446880.6179965,5049314.081986577],[-8446886.103995256,5049321.107121838],[-8446893.129130518,5049315.62112308],[-8446887.643131763,5049308.595987819],[-8446880.6179965,5049314.081986577]]]},\"properties\":{\"roomId\":\"78a719665e7249f0b26a0020a9b58c12\"}}"');
INSERT INTO room_coordinates (room_id, room_coordinates) VALUES ('84cdc682dff645b28207dbf1fbcbe0d8', '"{\"type\":\"Feature\",\"geometry\":{\"type\":\"Polygon\",\"coordinates\":[[[-8446925.349449974,5049282.291602794],[-8446929.738454485,5049290.0495243715],[-8446937.496376064,5049285.660519859],[-8446933.107371552,5049277.902598281],[-8446925.349449974,5049282.291602794]]]},\"properties\":{\"roomId\":\"abf9bf5684e24630afc01815ba4ba50d\"}}"');
INSERT INTO room_coordinates (room_id, room_coordinates) VALUES ('c8c9b303b7b249c092c57bbf7ddaad73', '"{\"type\":\"Feature\",\"geometry\":{\"type\":\"Polygon\",\"coordinates\":[[[-8446941.656412095,5049301.681679387],[-8446946.045416607,5049309.439600964],[-8446953.803338185,5049305.050596451],[-8446949.414333673,5049297.292674874],[-8446941.656412095,5049301.681679387]]]},\"properties\":null}"');
INSERT INTO room_coordinates (room_id, room_coordinates) VALUES ('1bf05038bbc447b4982900d7d3c37d47', '"{\"type\":\"Feature\",\"geometry\":{\"type\":\"Polygon\",\"coordinates\":[[[-8446935.666030645,5049262.4657801995],[-8446947.292626845,5049280.6099626925],[-8446965.436809339,5049268.983366492],[-8446953.81021314,5049250.839183999],[-8446935.666030645,5049262.4657801995]]]},\"properties\":null}"');

INSERT INTO staff_assigned_to_room (assignment_id, room_id, staff_id) VALUES ('66d8d626c254417f993a863fe2d76073', 'c8c9b303b7b249c092c57bbf7ddaad73', '8761c1d6df23494ca62e5dd25bd7ee1a');
INSERT INTO staff_assigned_to_room (assignment_id, room_id, staff_id) VALUES ('e2bacc0c5d4d401b8d5f32982e2d4d5b', 'db4bd3c4790143d79d78a1a59e957f86', '8761c1d6df23494ca62e5dd25bd7ee1a');
INSERT INTO staff_assigned_to_room (assignment_id, room_id, staff_id) VALUES ('2c7597405c294b43b07b8960e3ea512d', 'db4bd3c4790143d79d78a1a59e957f86', NULL);
INSERT INTO staff_assigned_to_room (assignment_id, room_id, staff_id) VALUES ('4cd1bf8eecb54e278e049962f3e5a3f6', '84cdc682dff645b28207dbf1fbcbe0d8', '8761c1d6df23494ca62e5dd25bd7ee1a');
INSERT INTO staff_assigned_to_room (assignment_id, room_id, staff_id) VALUES ('3f829b7ab3074ae19e3dc47aa18de538', '84cdc682dff645b28207dbf1fbcbe0d8', NULL);
INSERT INTO staff_assigned_to_room (assignment_id, room_id, staff_id) VALUES ('e014f85ed5824b819c268547748d54e4', '1bf05038bbc447b4982900d7d3c37d47', '2168ac0b9da743e79b96829f54cd87e1');
INSERT INTO staff_assigned_to_room (assignment_id, room_id, staff_id) VALUES ('622b2dd2762e48bda76ad971cee615ae', '1bf05038bbc447b4982900d7d3c37d47', '8761c1d6df23494ca62e5dd25bd7ee1a');
INSERT INTO staff_assigned_to_room (assignment_id, room_id, staff_id) VALUES ('9d1c599155d444f8ad20593d32ba5f9e', '4966481651aa444b95f8553210267bed', '8761c1d6df23494ca62e5dd25bd7ee1a');
INSERT INTO staff_assigned_to_room (assignment_id, room_id, staff_id) VALUES ('7e2ba4b47015404a92615ceb83ce4fab', '4966481651aa444b95f8553210267bed', NULL);
