import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> init() async {
      String path = await getDatabasesPath();
      return openDatabase(
        join(path, 'localDatabase.db'),
        onCreate: (database, version) async {
          await database.execute('''create table student(
                                          id      uuid not null primary key,
                                          ids varchar,
                                          pseudo 	varchar,
                                          institution varchar,
                                          structure varchar,
                                          departement varchar,
                                          cycle varchar,
                                          mail varchar,
                                          password varchar,
                                          navigation_route varchar,
                                          navigation_value varchar,
                                          created_date datetime,
                                          updated_date datetime
                                        )''',);
          await database.execute('''create table institution(
                                          id      uuid not null primary key,
                                          name varchar,
                                          full_name varchar,
                                          type varchar,
                                          file_name varchar,
                                          created_date datetime,
                                          updated_date datetime
                                        )''',);
          await database.execute('''create table structure(
                                          id      uuid not null primary key,
                                          name varchar,
                                          full_name varchar,
                                          type varchar,
                                          file_name varchar,
                                          created_date datetime,
                                          updated_date datetime,
                                          id_institution uuid not null,
                                          foreign key (id_institution) references institution (id)
                                          on delete cascade on update cascade
                                        )''',);
          await database.execute('''create table departement(
                                          id      uuid not null primary key,
                                          name varchar,
                                          full_name varchar,
                                          file_name varchar,
                                          created_date datetime,
                                          updated_date datetime,
                                          id_structure uuid not null,
                                          foreign key (id_structure) references structure (id)
                                          on delete cascade on update cascade
                                        )''',);
          await database.execute('''create table semestre(
                                          id      uuid not null primary key,
                                          name varchar,
                                          type varchar,
                                          full_name varchar,
                                          cycle varchar
                                        )''',);
          await database.execute('''create table departement_semestre(
                                          id_departement uuid not null,
                                          id_semestre uuid not null,
                                          created_date datetime,
                                          updated_date datetime,
                                          primary key (id_departement, id_semestre),
                                          foreign key (id_departement) references departement (id)
                                          on delete cascade on update cascade,
                                          foreign key (id_semestre) references semestre (id)
                                          on delete cascade on update cascade
                                        )''',);
          await database.execute('''create table matiere(
                                          id      uuid not null primary key,
                                          name varchar,
                                          full_name varchar,
                                          created_date datetime,
                                          updated_date datetime,
                                          id_departement uuid not null,
                                          id_semestre uuid not null,
                                          foreign key (id_departement, id_semestre) references departement_semestre (id_departement, id_semestre)
                                          on delete cascade on update cascade
                                        )''',);
          await database.execute('''create table section(
                                          id      uuid not null primary key,
                                          full_name varchar
                                        )''',);
          await database.execute('''create table matiere_section(
                                          id_matiere uuid not null,
                                          id_section uuid not null,
                                          created_date datetime,
                                          updated_date datetime,
                                          primary key (id_matiere, id_section),
                                          foreign key (id_matiere) references matiere (id)
                                          on delete cascade on update cascade,
                                          foreign key (id_section) references section (id)
                                          on delete cascade on update cascade
                                        )''',);
          await database.execute('''create table epreuve(
                                          id      uuid not null primary key,
                                          full_name numeric,
                                          file_name varchar,
                                          id_matiere uuid not null,
                                          id_section uuid not null,
                                          created_date datetime,
                                          updated_date datetime,
                                          foreign key (id_matiere, id_section) references matiere_section (id_matiere, id_section)
                                          on delete cascade on update cascade
                                        )''',);
          await database.rawInsert('''INSERT INTO student (id, ids, navigation_route, navigation_value) VALUES 
                                        ('00000000-0000-0000-0000-000000000000','0000','/','')''');
        },
        version: 1,
      );
  }
}