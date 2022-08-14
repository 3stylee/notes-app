const idColumn = 'id';
const emailColumn = 'email';
const userIDColumn = 'user_id';
const textColumn = 'text';
const dbName = 'notes.db';
const noteTable = 'note';
const userTable = 'user';
const createUserTable = '''
      REATE TABLE IF NOT EXISTS user (
      id    INTEGER PRIMARY KEY AUTOINCREMENT
                  NOT NULL,
      email TEXT    NOT NULL
                  UNIQUE
      );
      ''';

const createNoteTable = '''
      CREATE TABLE IF NOT EXISTS note (
      id      INTEGER PRIMARY KEY AUTOINCREMENT
                    NOT NULL,
      user_id INTEGER NOT NULL
                    REFERENCES user (id),
      text    TEXT
      );
      ''';
