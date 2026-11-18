require "sqlite3"

class User
  attr_accessor :id, :firstname, :lastname, :age, :password, :email

  # cədvəli yaradan metod
  def self.create_table(db)
    db.execute("CREATE TABLE IF NOT EXISTS users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            firstname TEXT,
            lastname TEXT,
            age INTEGER,
            password TEXT,
            email TEXT
        )")
  end

  # hər bağlantı açılanda cədvəl yoxlanılır
  def self.connect
    db = SQLite3::Database.new("db.sql")
    create_table(db)
    db
  end

  def initialize(id, firstname, lastname, age, password, email)
    @id = id
    @firstname = firstname
    @lastname = lastname
    @age = age
    @password = password
    @email = email
  end

  def to_h
    {
      id: @id,
      firstname: @firstname,
      lastname: @lastname,
      age: @age,
      password: @password,
      email: @email,
    }
end

  #yeni user yaraxmaq ucun istifade olunur
  def self.create(user_info)
    #databasee yeni user elave edirem
    user_info = user_info.transform_keys(&:to_s)
    db = connect
    db.execute(
      "INSERT INTO users (firstname, lastname, age, password, email)
                VALUES (?, ?, ?, ?, ?)",
      user_info["firstname"],
      user_info["lastname"],
      user_info["age"],
      user_info["password"],
      user_info["email"]
    )
    #databasein verdiyi yeni user idsini gotururuk
    id = db.last_insert_row_id
    #yaratdiximiz useri databaseden tapiriq
    user = db.execute(
      "SELECT * FROM users WHERE id=?",
      id,
    ).first
    db.close
    #arrayi user objectə çevirir
    User.new(*user)
  end
  #verilen idye sahib useri databaseden tapir
  def self.find(user_id)
    #databaseden idsi verilen useri tapir
    db = connect
    user = db.execute(
      "SELECT * FROM users WHERE id = ?",
      user_id
    ).first
    #databaseden gelen arrayi User objecte cevirir
    db.close
    User.new(*user)
  end
  #databasedeki butun userleri getirir
  def self.all
    db = connect
    #users tabledaki butun usexleri getirir
    users = db.execute("SELECT * FROM users")
    #her useri User objecte cevirir
    db.close
    users.map do |user|
      User.new(*user)
    end
  end
  #verilen idye sahib useri update edir
  def self.update(user_id, attribute, value)
    #databasede verilen userin verilen attributeni deyisir
    db = connect
    db.execute(
      "UPDATE users SET #{attribute}=? WHERE id=?",
      value,
      user_id
    )
    # update etdiyimiz useri databaseden tapiriq
    user = db.execute("SELECT * FROM users WHERE id = ?",
                      user_id).first
    db.close
    #arrayi user objecte cevirir
    User.new(*user)
    # execute bizim datavase connectiondu
  end
  #verilen idye sagib useri databaseden silir
  def self.destroy(user_id)
    db = connect
    db.execute(
      "DELETE FROM users WHERE id = ?",
      user_id
    )
    db.close
  end
end

# use=User.new(1,"Leman","Aliyeva",19,"2007","1234","aliyevaleman@mail.com")
