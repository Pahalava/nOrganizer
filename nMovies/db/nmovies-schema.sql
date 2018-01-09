BEGIN TRANSACTION;

DROP TABLE IF EXISTS template;
DROP TABLE IF EXISTS movie;
DROP TABLE IF EXISTS director;
DROP TABLE IF EXISTS actor;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS tag;

CREATE TABLE template(
	id INTEGER PRIMARY KEY AUTOINCREMENT, 
	name TEXT NOT NULL,
	is_active TINYINT NOT NULL DEFAULT 1
);
CREATE TABLE movie(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	templated_id NOT NULL REFERENCES template(id) on update cascade,
	name TEXT NOT NULL,
	release_date TEXT,
	is_active TINYINT NOT NULL DEFAULT 1
);
-- occurrence examplpe - field:{name:Date,occurrence:0} sub-field:{name:birthday, occurrence:1}
CREATE TABLE subfield(
	id INTEGER PRIMARY KEY AUTOINCREMENT, 
	name TEXT NOT NULL,
	datatype TEXT, --contains the regular expression for the field. If empty, field's datatype is applicable. If not empty, overrides field's datatype.
	occurrence TINYINT NOT NULL DEFAULT 0, -- maximum number of times this field can occur. 0 means any number of times.
	field_id NOT NULL REFERENCES field(id) on update cascade,
	is_active TINYINT NOT NULL DEFAULT 1
);
CREATE TABLE contact(
	id INTEGER PRIMARY KEY AUTOINCREMENT, 
	person_id NOT NULL REFERENCES movie(id) on update cascade,
	field_id NOT NULL REFERENCES field(id) on update cascade,
	subfield_id NOT NULL REFERENCES subfield(id) on update cascade,
	name TEXT,
	valu TEXT NOT NULL,
	is_active TINYINT NOT NULL DEFAULT 1
);
COMMIT;